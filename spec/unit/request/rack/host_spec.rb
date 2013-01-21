require 'spec_helper'

describe Request::Rack, '#host' do
  subject { object.host }

  it_should_behave_like 'a rack env accessor' do

    let(:object)   { described_class.new(env) }
    let(:rack_key) { 'SERVER_NAME'            }

  end
end
