require 'spec_helper_acceptance'

describe 'beaker::puppeter' do

  def puppet_major
    case hosts.first.options[:puppeter_answers]
    when 'default'
      5
    when 'agent-pc3x'
      3
    when 'agent-pc4x'
      4
    when 'agent-pc5x'
      5
    when 'agent-system'
      3
    end
  end

  it 'should work install Puppet with no errors' do
    result = run_puppeter
    expect(result).to be_truthy
  end

  describe command('bash -lc "puppet --version"') do
    its(:stdout) { should match /^#{puppet_major}\.\d+\.\d+$/ }
  end
end
