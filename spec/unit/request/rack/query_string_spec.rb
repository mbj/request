require 'spec_helper'

describe Request::Rack, '#query_string' do
  subject { object.query_string }

  it_should_behave_like 'a rack env accessor' do

    let(:object)   { described_class.new(env) }
    let(:rack_key) { 'QUERY_STRING'           }

  end
end
