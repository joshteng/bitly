enable :sessions

get '/' do
  # Look in app/views/index.erb
  @error = session.delete(:error)
  erb :index
end

post '/submiturl' do
  @url = Url.new(params[:url])

  if @url.save
    erb :index
  else
    session[:error] = @url.errors.full_messages.to_sentence
    redirect '/'
  end
end

#################check if logined
before '/all_urls' do
  redirect '/login' unless login?
end

get '/all_urls' do
  @all_urls = Url.all
  @current_user = User.find(session[:current_user_id])
  erb :all_urls
end

get '/login' do
  erb :login
end

get '/signup' do
  erb :signup
end

post '/signup' do
  user = User.new(params[:user])
  if user.save
    login(user)
    redirect '/all_urls'
  else
    session[:error] = "Try again"
    erb :signup
  end
end


get '/:short_url' do
  actual_url = Url.find_by_short_link!(params[:short_url])
  actual_url.increment!(:visits)
  # Url.update_counters(actual_url.id, visits: 1 )
  redirect to "#{actual_url.link}"
end

post '/login' do
  user = User.find_by_email(params[:login][:email])
  if user && valid_password?(user, params[:login][:password])
    session.delete(:error)
    login(user)
    redirect '/all_urls'
  else
    session[:error] = "Wrong email/password"
    redirect '/login'
  end
end

delete '/logout' do
  session[:current_user_id] = nil
  redirect '/'
end
