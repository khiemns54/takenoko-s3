namespace :takenoko do

  task :upload_table_to_s3,[:table] => :environment do |t, args|
    Takenoko.upload_table_to_s3(args[:table])
  end

  task :upload_all_to_s3 => :environment do
    Takenoko.upload_all_to_s3
  end

  task :download_and_upload_table_to_s3,[:table] => :environment do |t, args|
    Takenoko.download_and_upload_table_to_s3(args[:table])
  end

  task :download_and_upload_all_to_s3 => :environment do
    Takenoko.download_and_upload_all_to_s3
  end

  namespace :table do
    task :to_s3,[:table] =>"takenoko:download_and_upload_table_to_s3"
    task "to_s3:upload_only",[:table] =>"takenoko:upload_table_to_s3"
  end

  namespace :all do
    task :to_s3 => "takenoko:download_and_upload_all_to_s3"
    task "to_s3:upload_only" =>"takenoko:upload_all_to_s3"
  end

end
