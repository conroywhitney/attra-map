module Attra
  class Page

    DOMAIN = "attra.ncat.org"

    attr_accessor \
      :url,
      :uri

    def initialize(url)
      url = "https://#{DOMAIN}/#{url}" unless url.include?("http")

      self.url = url
      self.uri = URI.parse(url)

      qs = CGI::parse(self.uri.query)
      self.class.qs_keys.each do |k,v|
        instance_variable_set("@#{k}", qs[self.class.qs_keys[k]].first)
      end
    end

    # abstract class
    def self.qs_keys
      return {}
    end

    # for wombat
    def base_url
      return self.url.split(".org").first + ".org"
    end

    # for wombat
    def path
      return self.url.split(".org").last
    end

  end
end
