require 'cgi'

module Attra
  class Serp

    # https://attra.ncat.org/attra-pub/internships/search_results.php?FarmName=&City=&State=&Keyword=&allDate=1&Go=Go
    # https://attra.ncat.org/attra-pub/internships/search_results.php?FarmName=&City=&State=&Keyword=&allDate=1&page=4

    attr_accessor \
      :url,
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
      uri = URI.parse(url)
      qs  = CGI::parse(uri.query)
      QS_KEYS.each do |k,v|
        instance_variable_set("@#{k}", qs[QS_KEYS[k]].first)
      end
    end

  end
end
