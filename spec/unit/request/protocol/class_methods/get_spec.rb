require 'spec_helper'

describe Request::Protocol, '.get' do
  let(:object) { described_class }

  subject { object.get(input) }

  context 'with "http"' do
    let(:input) { 'http' }
    it { should eql(Request::Protocol::HTTP) }
  end

  context 'with "https"' do
    let(:input) { 'https' }
    it { should eql(Request::Protocol::HTTPS) }
  end

  context 'with "ftp"' do
    let(:input) { 'ftp' }
    it 'should raise error' do
      expect { subject }.to raise_error(KeyError, 'key not found: "ftp"')
    end
  end
end
