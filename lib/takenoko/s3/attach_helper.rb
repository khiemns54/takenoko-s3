module Takenoko
  module AttachHelper
    extend self
    def upload_to_s3(table_data)
      return false unless table_data[:to_s3].present?
      raise 'bucket must be set' if table_data[:bucket].blank?
      raise 'attach_files empty' if table_data[:attach_files].blank?
      bucket = Takenoko.s3.client.bucket(table_data[:bucket])
      table_data[:attach_files].each do |col|
        next unless col[:to_s3].present?
        table_data[:rows].each do |row|
          next if row[col[:column_name]].blank?
          file_path = col[:download_location] + '/' + File.basename(row[col[:column_name]])
          unless File.file?(file_path)
            raise "File not found: #{file_path}, download first or use download_and_upload_to_s3" 
          end
          file = File.open(file_path)
          s3_path = col[:s3_folder]+ "/" +  File.basename(row[col[:column_name]])
          Rails.logger.info "Uploading to s3: #{file_path} -> #{s3_path}"
          bucket.files.create({
            key: s3_path,
            body: file,
            public: col[:s3_public]
          })
        end
      end
      return true
    end
  end
end