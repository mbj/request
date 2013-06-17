shared = proc do
  let(:rack_key_value) { :Value }

  let(:default_env) do
    {
      'REQUEST_METHOD'  => 'GET',
      'SERVER_NAME'     => 'example.org',
      'SERVER_PORT'     => '80',
      'PATH_INFO'       => '/',
      'rack.url_scheme' => 'http'
    }
  end

  let(:expected_value) { rack_key_value                                }
  let(:env)            { default_env.merge(rack_key => rack_key_value) }
  let(:object)         { described_class.new(env)                      }
end

shared_examples_for 'a rack env accessor' do
  instance_eval(&shared)

  it { should eql(expected_value) }

  it 'should not freeze the input env' do
    subject
    env.frozen?.should be(false)
  end
end

shared_examples_for 'an invalid rack env accessor' do
  instance_eval(&shared)

  it 'should raise error' do
    expect { subject }.to raise_error(Request::Rack::InvalidKeyError, expected_message)
  end
end
