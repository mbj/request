require 'spec_helper'

describe Request::Rack, '#protocol' do
  subject { object.protocol }

  Request::Protocol::ALL.each do |protocol|
    it_should_behave_like 'a rack env accessor' do

      let(:object)           { described_class.new(env) }
      let(:rack_key)         { 'rack.url_scheme'        }
      let(:rack_key_value)   { protocol.name            }
      let(:expected_value)   { protocol                 }

    end
  end
end
