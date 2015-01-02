module Adapters
  class Destination < Adapters::BaseListing

    # lets us work in dev (ActiveRecord usually implements for us)
    # https://stackoverflow.com/questions/6853471/ruby-on-rails-unloadable
    unloadable

    def self.class_interface
      return [
        :destroy_all
      ]
    end

    def self.instance_interface
      return [
        :save!
      ]
    end

    def adapt(object)
      return object
    end

    def listing
      self.source
    end

  end
end
