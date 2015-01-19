require 'spec_helper'

describe Request::Rack, '#cookies' do
  subject { object.cookies }

  let(:object) { described_class.new(env) }

  context 'when HTTP_COOKIE key is present in the env' do
    let(:env)     { { 'HTTP_COOKIE' => cookies } }
    let(:cookies) { 'SID={id: 1}' }

    it { should eql(Cookie::Registry.coerce(cookies)) }
  end

  context 'when HTTP_COOKIE key is NOT present in the env' do
    let(:env) { {} }

    it { should eql(Cookie::Registry.coerce('')) }
  end
end
