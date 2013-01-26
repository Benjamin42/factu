# Load the rails application
require File.expand_path('../application', __FILE__)

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

# Initialize the rails application
Factu::Application.initialize!

Geocoder.configure do |config|
  config.lookup = :google
  #config.api_key = "AIzaSyBxFBK3QBQ4oP6nnhoFTxi2Y8Qgh52lUIo"
  #config.http_proxy = "corbara:Nfvsnxdh2@10.198.237.3:8080"
  #config.https_proxy = "corbara:Nfvsnxdh2@10.198.237.3:8080"
end
