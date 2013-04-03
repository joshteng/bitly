get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/submiturl' do
  new_url = Url.create(params[:url])
  redirect to "/?short_link=#{new_url.short_link}"
end

get '/all_urls' do
  @all_urls = Url.all
  erb :all_urls
end

get '/:short_url' do
  actual_url = Url.find_by_short_link(params[:short_url]).link
  redirect to "http://#{actual_url}"
end
