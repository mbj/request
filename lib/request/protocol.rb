class Request
  class Protocol
    include Adamantium, Concord.new(:name, :default_port)

    private_class_method :new

    ALL = []

    ALL << HTTP  = new('http',   80)
    ALL << HTTPS = new('https', 443)

    # Return name
    #
    # @return [String]
    #
    # @api private
    #
    attr_reader :name

    # Return default port
    #
    # @return [Fixnum]
    #
    # @api private
    #
    attr_reader :default_port

    ALL.freeze

    INDEX = ALL.each_with_object({}) do |protocol, index|
      index[protocol.name] = protocol
    end.freeze

    # Return protocol for name
    #
    # @param [String] name
    #
    # @return [Protocol]
    #
    # @api private
    #
    def self.get(name)
      INDEX.fetch(name)
    end

  end
end
