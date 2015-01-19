require 'concord'
require 'time'
require 'equalizer'
require 'abstract_type'
require 'adamantium'
require 'ice_nine'
require 'securerandom'

# Library namespace and abstract base class
class Request

  KEYS = %w[
    path_info
    protocol
    port
    request_method
    host
    if_modified_since
    query_params
    query_params_hash
    query_string
    content_length
    content_type
    body
  ].map(&:to_sym).freeze

  METHODS = (KEYS + %w[rack_env get? post?]).map(&:to_sym).freeze

  include Adamantium::Flat, AbstractType, Equalizer.new(*KEYS)

  # Return unique id
  #
  # @return [String]
  #
  # @api private
  #
  def uid
    SecureRandom.hex(6)
  end
  memoize :uid

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
  # @return [Array]
  #
  # @api private
  #
  abstract_method :query_params

  # Return query params hash
  #
  # @return [Hash]
  #
  # @api private
  #
  def query_params_hash
    query_params.each_with_object({}) do |(key, value), hash|
      hash[key] = value
    end
  end
  memoize :query_params_hash

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
    uhost, uport = host, port
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
require 'request/method'
require 'request/protocol'
