class Request
  # The request method of a request
  class Method
    include Adamantium, Composition.new(:verb)

    private_class_method :new

    POST = new('POST')
    GET  = new('GET')
    PUT  = new('PUT')
  end
end
