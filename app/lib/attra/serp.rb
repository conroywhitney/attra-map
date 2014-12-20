require 'cgi'

module Attra
  class Serp

    # https://attra.ncat.org/attra-pub/internships/search_results.php?FarmName=&City=&State=&Keyword=&allDate=1&Go=Go
    # https://attra.ncat.org/attra-pub/internships/search_results.php?FarmName=&City=&State=&Keyword=&allDate=1&page=4

    attr_accessor \
      :url,
      :uri,
      :farm_name,
      :city,
      :state,
      :keyword,
      :all_date,
      :page


    QS_KEYS = {
      farm_name: "FarmName",
      city: "City",
      state: "State",
      keyword: "Keyword",
      all_date: "allDate",
      page: "page"
    }

    def initialize(url)
      self.url = url
      self.uri = URI.parse(url)

      qs  = CGI::parse(self.uri.query)
      QS_KEYS.each do |k,v|
        instance_variable_set("@#{k}", qs[QS_KEYS[k]].first)
      end
    end

    def next_url
      next_uri = self.uri.dup
      next_uri.query = QS_KEYS.collect do |attribute, qs_key|
        value = instance_variable_get("@#{attribute}")
        value = value.blank? ? 2 : value.to_i + 1 if attribute == :page
        "#{qs_key}=#{value}"
      end.join("&")
      return next_uri.to_s
    end

  end
end
