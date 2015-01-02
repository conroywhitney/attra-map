module Adapters
  class Algolia < Adapters::Destination

  #
  # These are all Algolia hacks so we can use it without ActiveRecord
  # They must come before we include ::AlgoliaSearch
  #

    class Listing; end;

    def self.model_name
      return "Listing"
    end

    def self.unscoped
      yield
    end

    def id
      return self.listing.id
    end
  #
  # End Algolia hacks
  #

    include ::AlgoliaSearch


    # helpful example: https://github.com/algolia/hn-search
    algoliasearch \
      auto_index:      false,
      auto_remove:     false,
      per_environment: true    do

      attribute \
        :id,
        :attra_id,
        :permalink,
        :title,
        :address,
        :fulltext,
        :lat,
        :lon

=begin
      attribute :listed_on_i do
        self.listed_on_i
      end

      customRanking ["desc(me_first)", "desc(listed_on_i)"]
=end

  #    attributesForFaceting [:locations, :offering, :product_types]

      geoloc :lat, :lon

  #    separatorsToIndex '+#$'
    end

    def save!
      self.index!
    end

    def self.destroy_all
      clear_index!
    end

    def self.all
      return ::Listing.all.collect{|listing| Adapters::Algolia.new(listing)}
    end

    def permalink
      return self.listing.url
    end

    def address
      return self.listing.postal_address
    end

    def fulltext
      return self.listing.fulltext_search
    end

=begin
    def listed_on_i
      return Time.parse(self.listed_on.to_s).to_i
    end
=end

  end
end
