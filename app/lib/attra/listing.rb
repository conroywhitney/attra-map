require 'cgi'
require 'nokogiri'
require 'open-uri'

module Attra
  class Listing < Attra::Page

    # https://attra.ncat.org/attra-pub/internships/farmdetails.php?FarmName=&City=&State=OR&Keyword=&allDate=0&page=1&FarmID=3391

    attr_accessor \
      :attra_id,
      :title,
      :address,
      :city,
      :state,
      :zip,
      :contact,
      :contact_phones,
      :contact_emails,
      :contact_method,
      :website,
      :updated_on,
      :description,
      :internship_starts_on,
      :internship_ends_on,
      :num_interns,
      :app_deadline,
      :minimum_stay_length,
      :meals,
      :skills_desired,
      :educational_opportunities,
      :stipend,
      :housing,
      :internship_details,
      :fulltext_search

    after_initialize :parse!

    def clean_url
      self.url = "attra-pub/internships/#{self.url}" unless self.url.include?("attra-pub/internships/")
      super
    end

    def self.qs_keys
      return {
        attra_id:  "FarmID",
        farm_name: "FarmName",
        city:      "City",
        state:     "State",
        keyword:   "Keyword",
        all_date:  "allDate",
        page:      "page"
      }
    end

    def self.section_labels
      return {
        "Contact"                     => :contact,
        "Phone"                       => :contact_phones,
        "Email"                       => :contact_emails,
        "Website"                     => :website,
        "Last Updated"                => :updated_on,
        "General Description"         => :description,
        "Internship Starts"           => :internship_starts_on,
        "Internship Ends"             => :internship_ends_on,
        "Number of Interns"           => :num_interns,
        "App Deadline"                => :app_deadline,
        "Minimum Length of Stay"      => :minimum_stay_length,
        "Meals"                       => :meals,
        "Skills Desired"              => :skills_desired,
        "Educational Opportunities"   => :educational_opportunities,
        "Stipend"                     => :stipend,
        "Housing"                     => :housing,
        "Preferred method Of Contact" => :contact_method,
        "Internship Details"          => :internship_details
      }
    end

    def cached_or_crawl!
      self.crawl! if self.html.blank?
      self.parse!
    end

    def crawl!
      begin
        doc = Nokogiri::HTML(open(self.url))
      rescue OpenURI::HTTPError => e
        puts "Error opening [#{self.url}]: [#{e.message}]"
        raise e
      end

      # cache
      self.html = doc.to_s.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
      self.save!

      self.parse!
    end

    def parse!
      return false if self.html.blank?

      doc = Nokogiri::HTML(self.html)

      base_xpath = "//div[@id='main_content']//table//tr[1]//td//table//tr//td"

      details  = doc.xpath("#{base_xpath}")
      sections = details.xpath(".//strong")

      # update attributes as we figure them out
      self.source_id       = self.attra_id
      self.title           = sections.shift.content
      self.fulltext_search = details.to_s

      current_attribute = nil
      details.children.each do |element|
        #puts "children [#{element}] (next[#{element.next.to_s}])"

        case element.to_s
        when "<!-- ADDR1 -->"
          parse_address(element.next.to_s)
        when "<!-- City, State, Zip, ZipPlus -->"
          parse_city_state_zip(element.next.to_s)
        end

        case element.class
        when Nokogiri::XML::Text
          concatenate_attribute(current_attribute, element)
        when Nokogiri::XML::Comment
          puts "\n\n\nSARLKSJERSDF\n\n"
        when Nokogiri::XML::Element
          case element.name
          when "br"
            next
          when "strong"
            current_attribute = get_attribute_from_element(element)
          end
          raise_unknown_error(element)
        else
          # skip
          #raise_unknown_error(element)
        end
      end

      return nil
    end

    def full_address
      [self.address, self.city, self.state, self.zip].reject{|e| e.nil?}.join(", ")
    end

    def parse_address(str)
      self.address = str.strip
    end

    def parse_city_state_zip(csz)
      csz        = csz.strip
      csz        = csz.split(", ")
      self.city  = csz.first
      csz        = csz.last.split(" ")
      self.state = csz.first
      self.zip   = csz.last
    end

    def get_attribute_from_element(element)
      clean = element.to_s.gsub(/:?\s*$/, "")
      self.class.section_labels[clean]
    end

    def concatenate_attribute(attribute, element)
      val = instance_variable_get("@#{attribute}") || ""
      val += " " + element.to_s
      instance_variable_set("@#{attribute}", val.strip)
    end

    def raise_unknown_error(element)
      raise "Unsure how to handle element: [#{element}]"
    end

    def content_between(first, last)
      elements = collect_between(first, last)
      return elements.collect{|e| e.content}.join("\t")
    end

    def collect_between(first, last)
      first == last ? [first] : [first, *collect_between(first.next, last)]
    end

  end
end
