class Request
  # Rack request
  class Rack < self

    SERVER_PORT       = Key.new('SERVER_PORT')
    REQUEST_METHOD    = Key.new('REQUEST_METHOD')
    RACK_URL_SCHEME   = Key.new('rack.url_scheme')
    IF_MODIFIED_SINCE = Key.new('HTTP_IF_MODIFIED_SINCE')
    CONTENT_LENGTH    = Key.new('CONTENT_LENGTH')
    HTTP_COOKIE       = Key.new('HTTP_COOKIE')

    # Error raised when an invalid rack env key is accessed
    InvalidKeyError = Class.new(RuntimeError)

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
    def self.accessor(name, key, *args)
      define_method(name) do
        access(key, *args)
      end
    end
    private_class_method :accessor

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

    CONTENT_LENGTH_REGEXP = /\A[0-9]+\z/.freeze

    # Return content length
    #
    # @return [Fixnum]
    #
    # @api private
    #
    def content_length
      value = @rack_env.fetch(CONTENT_LENGTH) do
        return 0
      end

      unless value =~ CONTENT_LENGTH_REGEXP
        fail InvalidKeyError, 'invalid content length'
      end

      value.to_i
    end
    memoize :content_length

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

    # Return a registry of all received cookies
    #
    # @return [Cookie::Registry]
    #
    # @api private
    def cookies
      Cookie::Registry.coerce(rack_env.fetch(HTTP_COOKIE, EMPTY_STRING))
    end
    memoize :cookies

    accessor(:path_info,    Key.new('PATH_INFO'))
    accessor(:host,         Key.new('SERVER_NAME'))
    accessor(:query_string, Key.new('QUERY_STRING'))
    accessor(:content_type, Key.new('CONTENT_TYPE'), nil)
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
    def access(key, *args)
      @rack_env.fetch(key, *args)
    end

  end # Rack
end # Request
