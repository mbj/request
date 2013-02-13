require 'spec_helper'

describe Request::Key, '#hash' do
  subject { described_class.new(string).hash }

  let(:string) { "teststring" }

  it { should == string.hash }
end