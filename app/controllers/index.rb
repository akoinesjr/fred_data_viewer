get '/' do
  erb :index
end

post '/' do

  dataset_code=params[:dataset_code]

#  unless Dataset.where('name = ?', dataset_code)
    new_dataset=Dataset.create(:name => dataset_code)

    url = URI.parse("http://api.stlouisfed.org/fred/series/observations?series_id=#{dataset_code}&api_key=#{ENV["API_KEY"]}&file_type=json")
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
     http.request(req)
    }

    @observations=JSON.parse(res.body)["observations"]
    @observations.each do |x|
      new_datapoint=Datapoint.create(date: x['date'], value: x['value'], dataset_id: new_dataset.id)
    end
#  end

    redirect "/data/#{new_dataset.id}"
end

get '/data/:id' do
 erb :data
end

get '/releases' do
  erb :releases
end

get '/releases/:id/series' do
  erb :series
end

get '/releases/:id/series/:series_id' do
  erb :series_data
end

get '/sources' do
  erb :sources
end

post '/sign_up' do
  user_info={:name=>params[:name],
             :email=>params[:email],
             :password_hash=>BCrypt::Password.create(params[:password])}
  user=User.create(user_info)
  session[:user_id]=user.id

  redirect to '/sessions/new'

end

get '/sessions/new' do
  erb :sign_in
end

post '/sessions' do
 @email = params[:email]
 @password = params[:password]

 @user = User.where('email = ?', @email).first
 if @user && @user.password == @password
   session[:user_id]=@user.id
   redirect to '/'
 else
   erb :sign_in
 end

end

delete '/sessions/:id' do
  session.clear
  redirect to '/'
  # sign-out -- invoked
end