require 'csv'

namespace :file do
  desc 'Create users from .csv file'
  task :import_csv, [:path] => :environment do |t, args|
    start_user_qt = User.count
    pp "start_user_qt: #{start_user_qt}"
    file_path = args[:path]
    datas = CSV.read(file_path, headers: true).collect(&:to_hash)

    datas.each do |data|
      birthday = data['birthday']
      new_birthday = Date.strptime(birthday, '%m/%d/%Y')
      data['birthday'] = new_birthday
      User.create!(data)
    end

    end_user_qt = User.count
    pp "end_user_qt: #{end_user_qt}"
    puts "Created #{end_user_qt - start_user_qt} new users"
  end
end