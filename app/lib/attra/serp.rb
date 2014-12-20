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

    def base_url
      return self.url.split(".org").first + ".org"
    end

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

    def results
      options = {
        base_url: self.base_url,
        path:     self.path
      }
      results = Wombat.crawl do
        base_url options[:base_url]
        path options[:page]

        listings 'xpath=//*[@id="main_content"]/table', :iterator do |item|
          puts "\n\nZOMG #{item}\n\n"
          url { "xpath=./tbody/tr/td/strong/a/@href" }
        end
      end
      puts results
      return results
    end

  end
end
