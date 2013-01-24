class Request
  # Rack request
  class Rack < self

    SERVER_PORT     = Key.new('SERVER_PORT')
    REQUEST_METHOD  = Key.new('REQUEST_METHOD')
    RACK_URL_SCHEME = Key.new('rack.url_scheme')

    # Declare accessor
    #
    # @param [Symbol] name
    # @param [Key] key
    #
    # @return [undefined]
    #
    # @api private
    #
    def self.accessor(name, key)
      define_method(name) do
        access(key)
      end
    end

    # Return rack env
    #
    # @return [Hash]
    #
    # @api private
    #
    attr_reader :rack_env

    # Return http port
    #
    # @return [Fixnum]
    #
    # @api private
    #
    def port
      @rack_env.fetch(SERVER_PORT).to_i(10)
    end
    memoize :port

    # Initialize object
    #
    # @param [Hash] rack_env
    #   the rack env
    #
    # @api private
    #
    def initialize(rack_env)
      @rack_env = rack_env
    end

    # Return request protocol
    #
    # @return [Protocol]
    #
    # @api private
    #
    def protocol
      Protocol.get(access(RACK_URL_SCHEME))
    end
    memoize :protocol

    # Return request method
    #
    # @return [Method]
    #
    # @api private
    #
    def request_method
      Method.get(access(REQUEST_METHOD))
    end
    memoize :request_method

    accessor(:path_info, Key.new('PATH_INFO')      )
    accessor(:host,      Key.new('SERVER_NAME')    )

  private

    # Return value for key
    #
    # @param [Key] key
    #
    # @return [Object]
    #
    # @api private
    #
    def access(key)
      @rack_env.fetch(key)
    end
  end
end
