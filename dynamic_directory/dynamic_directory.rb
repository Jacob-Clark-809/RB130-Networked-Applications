require "tilt/erubis"
require "sinatra"
require "sinatra/reloader"

get "/" do
  @files = Dir.glob("public/*").map { |file| file.delete_prefix("public/") }.sort
  @order = params[:order]

  erb :home
end