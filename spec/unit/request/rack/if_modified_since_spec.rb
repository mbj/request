require 'spec_helper'

describe Request::Rack, '#if_modified_since' do
  subject { object.if_modified_since }

  let(:object)   { described_class.new(env) }
  let(:rack_key) { 'HTTP_IF_MODIFIED_SINCE' }

  context 'if value is decodable' do
    it_should_behave_like 'a rack env accessor' do

      # Strip milliseconds
      let(:time)           { Time.httpdate(Time.now.httpdate) }
      let(:rack_key_value) { time.httpdate                    }
      let(:expected_value) { time                             }
    end
  end

  context 'if value is not decodable' do
    it_should_behave_like 'a rack env accessor' do
      let(:rack_key_value) { 'foo' }
      let(:expected_value) { nil   }
    end
  end
end
