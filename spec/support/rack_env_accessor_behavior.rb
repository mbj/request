shared_examples_for 'a rack env accessor' do
  let(:value) { mock('Value') }
  let(:env) { { rack_key => value } }

  it { should be(value) }
end
