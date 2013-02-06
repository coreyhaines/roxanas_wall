require 'sinatra'
require 'pubnub'


set :public_folder, File.dirname(__FILE__) + '/public'

pubnub_publish_key = ENV["PUBNUB_PUBLISH_KEY"]
get '/create_dummy' do
  pn = Pubnub.new(:publish_key => pubnub_publish_key)
  pn.publish(:channel => :sms_wall,
        :message => "Fun times",
        :callback => lambda { |m| puts m })
end

post '/incoming_sms' do
  pn = Pubnub.new(:publish_key => pubnub_publish_key)
  pn.publish(:channel => :sms_wall,
        :message => params,
        :callback => lambda { |m| puts m })
end
