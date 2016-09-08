require "takenoko"
require 'takenoko/mapping_generator'
require "takenoko/s3/takenoko"
require "takenoko/s3/attach_helper"
require "takenoko/s3/client"
require "takenoko/s3/mapping_generator"

module Takenoko
  module S3
    extend self
    mattr_accessor :aws_key_id
    @@aws_key_id = nil

    mattr_accessor :aws_key_secret
    @@aws_key_secret = nil

    mattr_accessor :to_s3
    @@to_s3 = false

    mattr_accessor :region
    @@region = "ap-northeast-1"

    mattr_accessor :bucket
    @@bucket = nil

    mattr_accessor :file_location
    @@file_location = "attached_files"

    mattr_accessor :s3_public
    @@s3_public = false

    @@client = nil

    def client
      Client.new(aws_key_id,aws_key_secret,region)
    end
  end

  class Railtie < Rails::Railtie
    railtie_name :takenoko

    rake_tasks do
      load "takenoko/s3/tasks/takenoko.rake"
    end
  end
end
