require 'takenoko'
module Takenoko
  module MappingGenerator
    extend self
    table_filters << [
      :set_s3_config, ->(name,table){
        if (attach_files = table[:attach_files]).present?
          table[:bucket] ||= Takenoko.s3.bucket
          table[:to_s3] ||= Takenoko.s3.to_s3
          table[:s3_public] ||= Takenoko.s3.s3_public
          table[:s3_location] ||= Takenoko.s3.file_location + "/" + table[:table_name]
          attach_files = attach_files.map do |col|
            col[:to_s3] ||= table[:to_s3]
            col[:s3_public] ||= table[:s3_public]
            col[:s3_folder] = col[:s3_folder].present? ? table[:s3_location] + "/" + col[:s3_folder] : table[:s3_location]
          end
        end
      }
    ]
    def test
      self
    end
  end
end