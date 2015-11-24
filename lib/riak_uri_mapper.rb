class RiakURIMapper

  def initialize(uri)
    @nodes = ("#{uri.host}:#{uri.port}" + uri.path).split("/").map do |node|
      host, port = node.split(":")
      { host: host, pb_port: port }
    end

    @authentication = {}
    @authentication[:user] = uri.user unless uri.user.nil?
    @authentication[:password] = uri.password unless uri.password.nil?
    @authentication.merge(Rack::Utils.parse_nested_query(uri.query).symbolize_keys)
  end

  def build_client
    require "riak"
    Riak::Client.new(
      nodes: @nodes,
      authentication: @authentication
    )
  end

end