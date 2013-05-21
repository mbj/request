require 'spec_helper'

describe Request::Rack, '#rack_env' do
  subject { object.rack_env }

  let(:object) { described_class.new(rack_env) }

  let(:rack_env) { mock('Rack Env') }

  it { should be(rack_env) }

  it_should_behave_like 'an idempotent method'
end
