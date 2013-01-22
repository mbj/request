class Request
  class Protocol
    include Adamantium, Composition.new(:name, :default_port)

    private_class_method :new

    HTTP = new('http', 80)
    HTTPS = new('https', 80)

  end
end
