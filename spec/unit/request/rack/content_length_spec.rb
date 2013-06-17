require 'spec_helper'

describe Request::Rack, '#content_length' do
  subject { object.content_length }

  let(:rack_key) { 'CONTENT_LENGTH'}

  context 'with decimal positive integer' do
    it_should_behave_like 'a rack env accessor' do

      let(:rack_key_value)   { '10' }
      let(:expected_value)   {  10  }

    end
  end

  context 'with decimal negative integer' do

    it_should_behave_like 'an invalid rack env accessor' do

      let(:rack_key_value)   { '-10' }
      let(:expected_message) { 'invalid content length' }

    end
  end

  context 'other garbadge' do

    it_should_behave_like 'an invalid rack env accessor' do

      let(:rack_key_value)   { '0asd2431' }
      let(:expected_message) { 'invalid content length' }

    end
  end

  context 'when CONTENT_LENGTH key is not present' do

    let(:rack_key) { 'SOMETHING_OTHER' }

    it_should_behave_like 'a rack env accessor' do

      let(:expected_value) { 0                }

    end
  end
end
