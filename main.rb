require 'sinatra'
require 'erb'
require 'sass'
require './student'
require 'data_mapper'




configure do
  enable :sessions
    set :username, 'shailee'
    set :password, '123'
end

configure :development do
    DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/student.db")
end

configure :production do
  DataMapper.setup(:default, ENV['DATABASE_URL'])
end

get('/styles.css'){ scss :styles }

get '/' do
    erb :home
end

get '/about' do
  @title = "All About This Website"
    erb :about
end

get '/contact' do
    erb :contact
end

get '/login' do
    erb :login
end

get '/students/new' do
    halt(401, 'Not Authorized') unless session[:admin] 
    @student = Student.new
    erb :new_student
end
not_found do
    erb :not_found
end

get '/logout' do
    session.clear
    redirect to('/login')
end