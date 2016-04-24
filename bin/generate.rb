require 'faker'
require 'json'

# generate users
filename = 'data/users.json'
no_users = ARGV.shift.to_i
File.open(filename, 'w') do |file|
    no_users.times do
        user = {
            name:     name = "#{Faker::Name.first_name} #{Faker::Name.last_name}",
            username: Faker::Internet.user_name(name),
            age:      rand(13..75),
            sex:      ["male", "female"].sample
        }
        file.puts user.to_json
    end
end

# generate posts
filename = 'data/posts.json'
no_posts = ARGV.shift.to_i
File.open(filename, 'w') do |file|
    no_posts.times do
        tags = []
        rand(1..4).times do
            tags << Faker::Hacker.noun
        end

        post = {
            username: Faker::Internet.user_name("#{Faker::Name.first_name} #{Faker::Name.last_name}"),
            text:     Faker::Hacker.say_something_smart,
            tags:     tags
        }
        file.puts post.to_json
    end
end
