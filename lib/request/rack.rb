class Request
  # Rack request
  class Rack < self

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

    MUTABLE_KEYS = IceNine.deep_freeze(%w(
      rack.errors
      rack.input
    ))

    SERVER_PORT = Key.new('SERVER_PORT')

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
      dup = rack_env.dup
      MUTABLE_KEYS.each do |key|
        dup.delete(key)
      end
      @rack_env = dup
    end

    REQUEST_METHOD = Key.new('REQUEST_METHOD')

    # Return request method
    #
    # @return [Method]
    #
    # @api private
    #
    def request_method
      Method.get(access(REQUEST_METHOD))
    end

    accessor(:path_info,      Key.new('PATH_INFO')      )
    accessor(:host,           Key.new('SERVER_NAME')    )
    accessor(:protocol,       Key.new('rack.url_scheme'))

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
