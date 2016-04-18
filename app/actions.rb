# Homepage (Root path)
enable :sessions

# helpers do
#   def protected!
#     return if authorized?
#     headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
#     halt 401, "Not authorized\n"
#   end
#
#   def authorized?
#     @auth ||=  Rack::Auth::Basic::Request.new(request.env)
#     if @auth.provided? and @auth.basic? and @auth.credentials
#       username, password = @auth.credentials
#       User.validate(username, password)
#     end
#   end
# end

helpers do

  def loggedin?
    session[:user_id]
  end

end

get '/' do
  erb :index
end

get '/tracks' do
  @tracks = Track.all
  erb :'tracks/index'
end

get '/tracks/new' do
  loggedin?
  #protected!
  @track = Track.new
  erb :'tracks/new'
end

post '/tracks/new' do
  @track = Track.new(
    title: params[:title],
    author: params[:author],
    url: params[:url],
    user_id: session[:user_id]
  )
  if @track.save
    redirect '/tracks'
  else
    erb :'/tracks/new'
  end
end

get '/login' do
  @user = User.new(username: session[:username])
  erb :'login'
end

post '/login' do
  @user = User.find_by username: params[:username]
  if @user.password == params[:password]
    session[:user_id] = @user.id
    erb :'/loggedin'
  else
    redirect '/login'
  end
end

get '/signup' do
  @user = User.new(
  username: params[:username],
  name: params[:name],
  email: params[:email]
  )
  erb :'/signup'
end

post '/signup' do
  @user = User.new(
  username: params[:username],
  password: params[:password],
  name: params[:name],
  email: params[:email]
  )
  if @user.save
    redirect '/login'
  else
    erb :'/signup'
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end
