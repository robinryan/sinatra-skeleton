require 'pry'

#allow us to have reusable, convenient methods to call from anywhere in our actions.rb file or in any view
helpers do
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end


# Homepage (Root path)
get '/' do
  erb :index
end

# get information from the server
get '/signup' do
  erb :signup
end

get '/login' do
  erb :login
end

get '/logout' do
  session[:user_id] = nil #session clear
  redirect '/'
end

get '/profile' do
  erb :profile
end

get '/profile/edit' do
  current_user
  erb :profile
end

get '/school/new' do
  erb :new_school
end

get '/schools/:id' do
  @school = School.find(params[:id])
  erb :school
end



# post information to the server

post '/login' do
  email = params[:email]
  password = params[:password]

  user = User.find_by(email: email, password: password)
  if user #if user exists
    session[:user_id] = user.id
    redirect '/'
  else
    erb :login
  end
end

post '/signup' do
  name = params[:name]
  email = params[:email]
  password = params[:password]
  phone = params[:phone]
  address = params[:address]
  city = params[:city]

  user = User.find_by(email: email)

  if user
    erb :login
  else
    User.create(name: name, email: email, password: password, phone: phone, address: address, city: city)
    session[:user_id] = user.id
    redirect '/'
  end
end

post '/school/new' do
  name = params[:name]
  address = params[:address]
  city = params[:city]
  phone = params[:phone]

  school = School.find_by(name: name)

  if school
    erb :new_school
  else
    new_school = current_user.schools.create(name: name, address: address, city: city, phone: phone)
    redirect "/schools/#{new_school.id}"
  end
end

post '/profile/edit' do
  name = params[:name]
  email = params[:email]
  
end



