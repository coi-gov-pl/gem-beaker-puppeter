require 'spec_helper_acceptance'

describe 'beaker::puppeter' do
  it 'should work install Puppet with no errors' do
    result = run_puppeter
    expect(result).to be_truthy
  end

  describe command('puppet --version') do
    its(:stdout) { should match /^\d+\.\d+\.\d+$/ }
  end
end
