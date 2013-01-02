require 'equalizer'
require 'abstract_type'
require 'adamantium'
require 'ice_nine'

# Library namespace and abstract base class
class Request
  include Adamantium, AbstractType, Equalizer.new(:path_info)

  # Return path info
  #
  # @return [String]
  #
  # @api private
  #
  abstract_method :path_info

end

require 'request/key'
require 'request/rack'
