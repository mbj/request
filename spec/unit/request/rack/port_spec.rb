require 'spec_helper'

describe Request::Rack, '#port' do
  subject { object.port }

  it_should_behave_like 'a rack env accessor' do
    let(:object)         { described_class.new(env) }
    let(:rack_key)       { 'SERVER_PORT'            }
    let(:rack_key_value) { '80'                     }
    let(:expected_value) { 80                       }
  end
end
