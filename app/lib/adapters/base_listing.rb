module Adapters
  class BaseListing

    # lets us work in dev (ActiveRecord usually implements for us)
    # https://stackoverflow.com/questions/6853471/ruby-on-rails-unloadable
    unloadable

    attr_accessor :source

    def initialize(object)
      self.source = self.adapt(object)
    end

    def adapt(object)
      abstract_method(:adapt)
    end

    def respond_to?(method)
      self.source.respond_to?(method) || super(method)
    end

    def method_missing(method, *args, &block)
      # if this object does not directly implement a given method
      # check to see if the source i wrap responds
      if self.source.respond_to?(method)
        # if source implements, let source handle it
        return self.source.send(method, *args, &block)
      else
        # otherwise, method is indeed missing
        super(method, *args, &block)
      end
    end

    def self.class_interface
      abstract_method(:class_interface)
    end

    def self.instance_interface
      abstract_method(:instance_interface)
    end

    def implements_interface?
      self.class.class_interface.each do |method|
        unless self.class.respond_to?(method)
          abstract_method(method)
        end
      end

      self.class.instance_interface.each do |method|
        unless self.respond_to?(method)
          abstract_method(method)
        end
      end

      return true
    end

protected

    def abstract_method(method)
      raise NotImplementedError.new("#{self.class.name} must implement method [#{method.to_s}]")
    end

  end
end
