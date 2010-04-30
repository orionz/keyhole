require 'rubygems'
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'lib/keyhole'

raise "KEYHOLE_USER and KEYHOLE_SECRET must be defined" unless ENV['KEYHOLE_USER'] and ENV['KEYHOLE_SECRET']

use Rack::Auth::Basic do |username, password|
  username == ENV['KEYHOLE_USER'] and password == ENV['KEYHOLE_SECRET']
end

before do
  @keyhole = Keyhole.new
end

get "/stats" do
  content_type 'application/json', :charset => 'utf-8'
  @keyhole.stats.to_json
end

get "/version" do
  @keyhole.version.to_s
end

post "/update" do
  @keyhole.update
  "ok"
end

