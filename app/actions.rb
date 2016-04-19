# Homepage (Root path)
enable :sessions
use Rack::MethodOverride
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

  def upvoted? (track_id)
    Upvote.exists?(session[:user_id], track_id)
  end

  def reviewed?(track_id)
    Review.exists?(session[:user_id], track_id)
  end

end

get '/' do
  erb :index
end

get '/tracks' do
  @tracks = Track.joins("LEFT OUTER JOIN upvotes ON upvotes.track_id = tracks.id").group(:track_id).order('COUNT(track_id) desc')
  #joins(:upvotes).group(:track_id).order('COUNT(track_id) desc')
  erb :'tracks/index'
end

get '/tracks/new' do
  loggedin?
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

get '/tracks/:id' do
  @track = Track.find_by(id: params[:id])
  @user = User.find_by(id: session[:user_id])
  erb :'tracks/show'
end

post '/tracks/:id' do
  @review = Review.new(
    track_id: params[:id],
    user_id: session[:user_id],
    content: params[:content],
    rating: params[:rating]
    )
  @review.save
  redirect back
end

delete '/tracks/:id' do
  @review = Review.find_by(id: params[:id])
  @review.destroy
  redirect back
end

get '/login' do
  @user = User.new(username: session[:username])
  erb :'login'
end

post '/login' do
  @user = User.find_by username: params[:username]
  if @user.password == params[:password]
    session[:user_id] = @user.id
    redirect '/tracks'
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

get '/upvote/:track_id' do
  user = User.find(session[:user_id])
  track = Track.find(params[:track_id])
  Upvote.create(user: user, track: track)
  redirect back
end
