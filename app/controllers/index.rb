get '/' do
  # Look in app/views/index.erb
  @messages = params[:errors]
  erb :index
end

post '/submiturl' do
  new_url = Url.create(params[:url])
  if got_errors?(new_url)

    redirect to "/?errors=#{new_url.errors.messages}"
  else
    redirect to "/?short_link=#{new_url.short_link}"
  end
end

get '/all_urls' do
  @all_urls = Url.all
  erb :all_urls
end

get '/:short_url' do
  actual_url = Url.find_by_short_link(params[:short_url])
  actual_url.increment!(:visits)
  # Url.update_counters(actual_url.id, visits: 1 )
  redirect to "#{actual_url.link}"
end


def got_errors?(new_url)
  !new_url.errors.messages.empty?
end
