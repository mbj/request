class Request

  # A string with cashed #hash for faster hash access
  class Key < ::String
    alias :str_hash :hash

    # Return hash
    #
    # @return [Fixnum]
    #
    # @api private
    #
    attr_reader :hash

    # Initialize object
    #
    # @param [String] string
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(string)
      super(string)
      @hash = str_hash
      freeze
    end
  end

end
