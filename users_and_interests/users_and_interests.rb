require "tilt/erubis"
require "sinatra"
require "sinatra/reloader"
require 'yaml'

before do
  @users = YAML.load_file('data/users.yaml')
  @total_users = @users.count
end

get "/" do
  redirect "/users"
end

get "/users" do
  @title = 'Users'

  erb :users
end

get "/user/:name" do
  @name = params[:name]
  @title = @name.capitalize
  @info = @users[@name.to_sym]
  @other_users = other_users(@name.to_sym)

  erb :user
end

def other_users(current)
  @users.each_with_object([]) do |(name, info), result|
    result << name.to_s unless name == current
  end
end

helpers do
  def total_interests
    @users.reduce(0) do |total, (name, info)|
      total += info[:interests].count
    end
  end
end
