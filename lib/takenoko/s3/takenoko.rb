module Takenoko
  extend self
  def s3
    S3
  end

  def upload_table_to_s3(table_name)
    table_data = google_client.get_table(table_name)
    raise "attach_files not set" unless table_data[:attach_files].present?
    AttachHelper.upload_to_s3 table_data
  end

  def upload_all_to_s3
    mapping_config[:tables].each do |table,conf|
      next if conf[:attach_files].blank?
      upload_table_to_s3 table
    end
    return true
  end

  def download_and_upload_table_to_s3(table_name)
    table_data = google_client.get_table(table_name)
    raise "attach_files not set" unless table_data[:attach_files].present?
    AttachHelper.download table_data
    AttachHelper.upload_to_s3 table_data 
  end

  def download_and_upload_all_to_s3
    mapping_config[:tables].each do |table,conf|
      next if conf[:attach_files].blank?
      download_and_upload_table_to_s3 table
    end
    return true
  end
end