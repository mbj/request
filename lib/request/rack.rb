class Request
  # Rack request
  class Rack < self
    SERVER_PORT       = Key.new('SERVER_PORT')
    REQUEST_METHOD    = Key.new('REQUEST_METHOD')
    RACK_URL_SCHEME   = Key.new('rack.url_scheme')
    IF_MODIFIED_SINCE = Key.new('HTTP_IF_MODIFIED_SINCE')
    CONTENT_LENGTH    = Key.new('CONTENT_LENGTH')

    # Initialize object
    #
    # @param [Hash] rack_env
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(rack_env)
      @rack_env = rack_env
    end

    # Return rack env
    #
    # @return [Hash]
    #
    # @api private
    #
    attr_reader :rack_env

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

    # Return content length
    #
    # @return [Fixnum]
    #
    # @api private
    #
    def content_length
      access(CONTENT_LENGTH).to_i(10)
    end

    # Return query params
    #
    # @return [Array]
    #
    # @api private
    #
    def query_params
      Addressable::URI.form_unencode(query_string)
    end
    memoize :query_params

    # Return if modified since
    #
    # @return [Time]
    #   if present
    #
    # @return [nil]
    #   otherwise
    #
    # @api private
    #
    def if_modified_since
      value = @rack_env.fetch(IF_MODIFIED_SINCE) { return }
      begin
        Time.httpdate(value) 
      rescue ArgumentError 
        nil
      end
    end
    memoize :if_modified_since

    accessor(:path_info,    Key.new('PATH_INFO')   )
    accessor(:host,         Key.new('SERVER_NAME') )
    accessor(:query_string, Key.new('QUERY_STRING'))
    accessor(:content_type, Key.new('CONTENT_TYPE'))
    accessor(:body,         Key.new('rack.input'))

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
