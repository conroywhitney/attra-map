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
      city:      "City",
      state:     "State",
      keyword:   "Keyword",
      all_date:  "allDate",
      page:      "page"
    }

    def initialize(url)
      self.url = url
      self.uri = URI.parse(url)

      qs  = CGI::parse(self.uri.query)
      QS_KEYS.each do |k,v|
        instance_variable_set("@#{k}", qs[QS_KEYS[k]].first)
      end
    end

    # for wombat
    def base_url
      return self.url.split(".org").first + ".org"
    end

    # for wombat
    def path
      return self.url.split(".org").last
    end

    def next_url
      # copy our uri so we don't fux with it
      next_uri = self.uri.dup
      # reconstruct query string from our attributes
      next_uri.query = QS_KEYS.collect do |attribute, qs_key|
        value = instance_variable_get("@#{attribute}")
        # increment page number (or set to page 2 if not exists)
        value = value.blank? ? 2 : value.to_i + 1 if attribute == :page
        # return a key=value pair
        "#{qs_key}=#{value}"
      end.join("&")
      return next_uri.to_s
    end

    def listings
      # you can't send instance varialbes into Wombat block
      options = {
        base_url: self.base_url,
        path:     self.path
      }

      results = Wombat.crawl do
        base_url options[:base_url]
        path options[:path]

        # loop through all tables and pull out details urls
        listings "xpath=//div[@id='main_content']//table", :iterator do
          name({  xpath: "*//strong" })
          url({   xpath: "*//a/@href" })
        end
      end

      # clean results from messy DOM structure
      return results["listings"].collect do |listing|
        listing["url"]
      end.select do |url|
        url.present? && url.include?("farmdetails.php")
      end
    end

  end
end
