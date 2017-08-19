namespace :registration do
  desc 'Creates a new user'
  task :create_new_user, [:username] => [:environment] do |_, args|
    User.create(username: args[:username])
  end
end