module GAssign
  class API
    def base_url
      "http://g-assign-api.herokuapp.com"
    end

    def url(path)
      path = "/#{path}" unless path[0] == "/"
      "#{base_url}#{path}"
    end

    def all(resource)
      parse( RestClient.get(url(resource)) )
    end

    def create(resource, params)
      parse( RestClient.post(url(resource), params.to_json, options))
    end

    def parse(response)
      JSON.parse(response)
    rescue
      {}
    end

    def options
      {
        :content_type => :json,
        :accept => :json
      }
    end
  end
end
