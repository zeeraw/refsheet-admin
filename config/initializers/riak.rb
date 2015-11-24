Rails.configuration.after_initialize do |config|
  require "riak_uri_mapper"
  uri = URI(ENV.fetch("RIAK_URL", "pb://127.0.0.1:8087"))
  $riak = RiakURIMapper.new(uri).build_client
end