require 'composition'
require 'equalizer'
require 'abstract_type'
require 'adamantium'
require 'ice_nine'

# Library namespace and abstract base class
class Request

  KEYS = %W(
    path_info protocol port request_method 
    host if_modified_since query_params 
    query_string
  ).map(&:to_sym).freeze

  METHODS = (KEYS + %W(rack_env get? post?)).map(&:to_sym).freeze

  include Adamantium::Flat, AbstractType, Equalizer.new(*KEYS)

  # Return protocol
  #
  # @return [Protocol]
  #
  # @api private
  #
  abstract_method :protocol

  # Return if modified since header
  #
  # @return [Time]
  #   if present
  #
  # @return [nil]
  #   otherwise
  #
  # @api private
  #
  abstract_method :if_modified_since

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

  # Return query params
  #
  # @return [Hash]
  #
  # @api private
  #
  abstract_method :query_params

  # Return query string
  #
  # @return [String]
  #
  # @api private
  #
  abstract_method :query_string

  # Return absolute uri
  #
  # @return [String]
  #
  # @api private
  #
  def absolute_uri
    "#{root_uri}#{path_info}"
  end

  # Return absolute uri for path
  #
  # @param [Path]
  #
  # @return [String]
  #
  # @api private
  #
  def absolute_uri_path(path)
    "#{root_uri}#{path}"
  end

  # Return routed request
  #
  # @param [Hash] params
  #
  # @return [Request::Routed]
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
    "#{protocol.name}://#{host_with_port}"
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
