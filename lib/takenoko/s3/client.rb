require 'fog'
module Takenoko
  module S3
    class Client
      def initialize(key,secret,region)
        @config = {
          provider: 'AWS',
          aws_access_key_id:     key,
          aws_secret_access_key: secret,
          region:                region
        }
      end

      def session
        Fog::Storage.new @config
      end

      def buckets
        session.directories
      end

      def bucket(bucket_name,folder_path=nil)
        session.directories.get(bucket_name, prefix:folder_path )
      end

    end
  end
end