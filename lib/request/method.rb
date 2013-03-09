class Request
  # The request method of a request
  class Method
    include Adamantium, Concord.new(:verb)

    private_class_method :new

    ALL = []
    ALL << POST = new('POST')
    ALL << GET  = new('GET')
    ALL << PUT  = new('PUT')
    ALL.freeze

    INDEX = ALL.each_with_object({}) do |method, index|
      index[method.verb]=method
    end.freeze

    # Return request method
    #
    # @param [String] verb
    #
    # @return [Method]
    #
    # @api private
    #
    def self.get(verb)
      INDEX.fetch(verb)
    end
  end
end
