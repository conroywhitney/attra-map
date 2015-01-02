module Attra
  class Page < CrawledPage

    DOMAIN = "attra.ncat.org"

    attr_accessor \
      :uri

    after_initialize :clean_url
    after_initialize :initialize_attributes

    def initialize_attributes
      qs = CGI::parse(self.uri.query)
      self.class.qs_keys.each do |k,v|
        instance_variable_set("@#{k}", qs[self.class.qs_keys[k]].first)
      end
    end

    def uri
      return URI.parse(self.url)
    end

    def clean_url
      self.url = "https://#{DOMAIN}/#{self.url}" unless self.url.include?("http")
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
