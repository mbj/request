class Request
  # The request method of a request
  class Method
    include Adamantium, Concord.new(:verb)

    private_class_method :new

    ALL = []
    ALL << HEAD   = new('HEAD')
    ALL << POST   = new('POST')
    ALL << GET    = new('GET')
    ALL << PUT    = new('PUT')
    ALL << DELETE = new('DELETE')
    ALL.freeze

    # Return verb
    #
    # @return [String]
    #
    # @api private
    #
    attr_reader :verb

    INDEX = ALL.each_with_object({}) do |method, index|
      index[method.verb] = method
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
