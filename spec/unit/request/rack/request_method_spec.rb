require 'spec_helper'

describe Request::Rack, '#request_method' do
  subject { object.request_method }

  it_should_behave_like 'a rack env accessor' do

    let(:object)   { described_class.new(env) }
    let(:rack_key) { 'REQUEST_METHOD'         }

  end
end
