require 'composition'
require 'equalizer'
require 'abstract_type'
require 'adamantium'
require 'ice_nine'

# Library namespace and abstract base class
class Request
  KEYS = %W(path_info protocol port request_method host).map(&:to_sym).freeze

  METHODS = (KEYS + %W(rack_env get? post?)).map(&:to_sym).freeze

  include Adamantium::Flat, AbstractType, Equalizer.new(*KEYS)

  # Return protocol
  #
  # @return [Protocol]
  #
  # @api private
  #
  abstract_method :protocol

  # Return path info
  #
  # @return [String]
  #
  # @api private
  #
  abstract_method :path_info

  # Return host
  #
  # @return [String]
  #
  # @api private
  #
  abstract_method :host

  # Return port
  #
  # @return [Integer]
  #
  # @api private
  #
  abstract_method :port

  # Return request method
  #
  # @return [Method]
  #
  # @api private
  #
  abstract_method :request_method

  # Return absolute uri
  #
  # @return [String]
  #
  # @api private
  #
  def absolute_uri
    "#{root_uri}#{path_info}"
  end

  # Replace path
  #
  # @param [Path]
  #
  # @api private
  #
  def absolute_uri_path(path)
    "#{root_uri}#{path}"
  end

  # Test if request method is post
  #
  # @return [true]
  #   if request method is post
  #
  # @return [false]
  #   otherwise
  #
  # @api private
  #
  def get?
    request_method == 'POST'
  end

  # Test if request method is get
  #
  # @return [true]
  #   if request method is get
  #
  # @return [false]
  #   otherwise
  #
  # @api private
  #
  def get?
    request_method == 'GET'
  end

  # Return routed request
  #
  # @param [Hash] params
  #
  # @api private
  #
  def route(params)
    Routed.new(self, params)
  end

  # Return root uri
  #
  # @return [String]
  #
  # @api private
  #
  def root_uri
    "#{protocol}://#{host_with_port}"
  end
  memoize :root_uri

  # Return host with optional port
  #
  # Only returns port if protocols default port diffes from actual port.
  #
  # @return [String]
  #
  # @api private
  #
  def host_with_port
    uhost, uport = self.host, self.port
    if port != protocol.default_port
      "#{uhost}:#{uport}"
    else
      uhost
    end
  end
  memoize :host_with_port

end

require 'request/key'
require 'request/rack'
require 'request/routed'
require 'request/method'
require 'request/protocol'
