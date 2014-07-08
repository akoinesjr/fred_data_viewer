require 'json'

get '/' do

  erb :index
end

post '/' do
  dataset_code=params[:dataset_code]

#  unless Dataset.where('name = ?', dataset_code)
    new_dataset=Dataset.create(:name => dataset_code)

    url = URI.parse("http://api.stlouisfed.org/fred/series/observations?series_id=#{dataset_code}&api_key=foobar&file_type=json")
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

