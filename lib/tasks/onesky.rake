namespace :onesky do

  desc 'Upload string files of base locale to OneSky platform.'
  task :upload => :environment do
    file_client.upload(locale_path)
    puts 'Done!'
  end

  desc 'Download translations from OneSky platform.'
  task :download => :environment do
    file_client.download(locale_path)
    puts 'Done!'
  end

  desc 'Download base language translations from OneSky platform.'
  task :download_base => :environment do
    file_client.download(locale_path, base_only: true)
    puts 'Done!'
  end

  desc 'Download all languages translations from OneSky platform.'
  task :download_all => :environment do
    file_client.download(locale_path, all: true)
    puts 'Done!'
  end

  desc 'Download translations for a specified language from OneSky platform.'
  task :download_one => :environment do
    file_client.download(locale_path, only: ENV['LANG'])
    puts 'Done!'
  end

  def file_client
    require 'erb'
    data = YAML::load(ERB.new(File.read(Rails.root.join('config', 'onesky.yml'))).result)
    Onesky::Rails::FileClient.new data
  end

  def locale_path
    Rails.root.join('config/locales')
  end

end
