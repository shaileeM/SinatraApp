require 'data_mapper'

class Student
 include DataMapper::Resource
   property :id, Serial
   property :name, String
   property :address, Text
   property :phone, Integer
   property :date_birth, Date

end

configure do
 enable :sessions
   set :username, 'shailee'
   set :password, '123'
end

DataMapper.finalize

get '/students' do
   @students = Student.all
   erb :students
end

get '/students/new' do
   @student = Student.new
   erb :new_student
end

get '/students/:id' do
   @student = Student.get(params[:id])
   erb :show_student
end

get '/students/:id/edit' do
   @student = Student.get(params[:id])
   erb :edit_student
end

post '/students' do  
   student = Student.create(params[:student])
   redirect to("/students/#{student.id}")
end

put '/students/:id' do
   student = Student.get(params[:id])
   student.update(params[:student])
   redirect to("/students/#{student.id}")
end

delete '/students/:id' do
   Student.get(params[:id]).destroy
   redirect to('/students')
end

post '/login' do
   if params[:username] == settings.username && params[:password] == settings.password
   session[:admin] = true
       redirect to ('/students') 
   else
       erb :login 
   end
end