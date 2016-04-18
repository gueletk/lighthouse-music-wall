# Homepage (Root path)
enable :sessions

get '/' do
  erb :index
end

get '/tracks' do
  @tracks = Track.all
  erb :'tracks/index'
end

get '/tracks/new' do
  @track = Track.new
  erb :'tracks/new'
end

post '/tracks/new' do
  @track = Track.new(
    title: params[:title],
    author: params[:author],
    url: params[:url]
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
    session[:username] = params[:username]
    erb :'/loggedin'
  else
    redirect '/login'
  end
end
