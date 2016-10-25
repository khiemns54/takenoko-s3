module Takenoko
  module AttachHelper
    extend self
    def upload_to_s3(table_data)
      errors = []
      return false unless table_data[:to_s3].present?
      raise 'bucket must be set' if table_data[:bucket].blank?
      raise 'attach_files empty' if table_data[:attach_files].blank?
      raise "Bucket not found:#{table_data[:bucket]}" unless bucket = Takenoko.s3.client.bucket(table_data[:bucket])

      table_name = table_data[:table_name]
      takelog = "#{Takenoko.log_folder}/#{table_name}_log.yml"
      log_data = (File.exist?(takelog) && YAML.load_file(takelog)) || {}

      table_data[:attach_files].each do |col|
        next unless col[:to_s3].present?
        table_data[:rows].each do |row|
          next if row[col[:column_name]].blank?
          file_path = col[:download_location] + '/' + File.basename(row[col[:column_name]])
          unless File.file?(file_path)
            errors << "Table[#{table_data[:table_name]}]File not found: #{file_path}" 
            next
          end

          file = File.open(file_path)
          file_name = File.basename(row[col[:column_name]])
          s3_path = col[:s3_folder]+ "/" +  file_name

          # find_val = row[table_data[:find_column]]
          find_val = "#{col[:folder_id]}_#{file_name}"

          if log_data[find_val].present? && (f = bucket.files.get(s3_path))
            if log_data[find_val][:s3_last_upload] && log_data[find_val][:s3_last_upload] >= file.mtime.to_i
              Rails.logger.info "Skip uploaded file: #{file_name}"
              next
            end
          end

          Rails.logger.info "Uploading to s3: #{file_path} -> #{s3_path}"
          f = bucket.files.create({
            key: s3_path,
            body: file,
            public: col[:s3_public],
          })

          log_data[find_val] ||= {}
          log_data[find_val][:s3_last_upload] = file.mtime.to_i
        end
      end

      File.open(takelog, 'w') {|f| f.write log_data.to_yaml }

      raise errors.join("\n") unless errors.empty?
      return true
    end
  end
end