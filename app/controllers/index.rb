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

get '/all_urls' do
  @all_urls = Url.all
  erb :all_urls
end

get '/:short_url' do
  actual_url = Url.find_by_short_link!(params[:short_url])
  actual_url.increment!(:visits)
  # Url.update_counters(actual_url.id, visits: 1 )
  redirect to "#{actual_url.link}"
end
