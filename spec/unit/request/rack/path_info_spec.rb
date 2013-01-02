require 'spec_helper'

describe Request::Rack, '#path_info' do
  subject { object.path_info }

  let(:object)   { described_class.new(env) }
  let(:rack_key) { 'PATH_INFO'              }

  it_should_behave_like 'a rack env accessor'
end
