class Request
  class Routed < self
    def initialize(request, routing_params)
      @request, @routing_params = request, routing_params
    end

    attr_reader :routing_params

    METHODS.each do |name|
      define_method(name) do
        @request.public_send(name)
      end
    end
  end
end

