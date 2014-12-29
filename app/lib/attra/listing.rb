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
      :internship_details


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

    def crawl!
      doc = Nokogiri::HTML(open(self.url))
      base_xpath = "//div[@id='main_content']//table//tr[1]//td//table//tr//td"

      details  = doc.xpath("#{base_xpath}")
      sections = details.xpath(".//strong")

      self.title = sections.shift.content

      current_attribute = nil
      current_value = []
      details.each do |element|
        case element.class
        when Nokogiri::XML::Text
          concatenate_attribute(current_attribute, element)
        when Nokogiri::XML::Comment
        when Nokogiri::XML::Element
          case element.name
          when "br"
            next
          when "strong"
            current_attribute = get_attribute_from_element(element)
          end
          raise_unknown_error(element)
        else
          raise_unknown_error(element)
        end
      end

      0.upto(sections.length - 1) do |i|
        elements = collect_between(sections[i], sections[i + 1])
        #puts "Section [#{sections[i]}] = [#{elements}]"
      end

      return nil
    end

    def get_attribute_from_element(element)
      clean = element.to_s.gsub(/:?\s*$/, "")
      self.class.section_labels[clean]
    end

    def concatenate_attribute(attribute, element)
      val = instance_variable_get("@#{k}") || ""
      val += " " + element.to_s
      instance_variable_set("@#{k}", val)
    end

    def raise_unknown_error(element)
      #raise "Unsure how to handle element: [#{element}]"
    end

    def parse(content, section)
      puts content.to_s
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
