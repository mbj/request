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
        @env.fetch(key)
      end
    end

    # Initialize object
    #
    # @param [Hash] env
    #   the rack env
    #
    # @api private
    #
    def initialize(env)
      @env = IceNine.deep_freeze(env)
    end

    accessor(:path_info, Key.new('PATH_INFO'))
  end
end
