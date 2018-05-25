require 'spec_helper'

describe Beaker::Puppeter do
  let :subject do
    Class.new { include Beaker::Puppeter }
  end
  let :hosts do
    with_answers_host = double(puppeter_answers: 'agent-pc4x')
    simple_host = double()
    [ with_answers_host, simple_host ]
  end
  after :each do
    ENV.delete('PUPPETER_ANSWERS')
  end
  before :each do
    allow(subject).to receive(:hosts).and_return(hosts)
  end

  describe '#run_puppeter' do
    context 'without any arguments' do
      it 'calls run_puppeter_on on each host' do
        expect(subject).to receive(:run_puppeter_on).with(hosts, :auto)
        subject.run_puppeter
      end
    end
    context 'with answers set to "pc45"' do
      it 'calls run_puppeter_on on each host' do
        expect(subject).to receive(:run_puppeter_on).with(hosts, 'pc45')
        subject.run_puppeter 'pc45'
      end
    end
  end

  describe '#run_puppeter_on' do
    let :executor do
      double(with: true)
    end
    before :each do
      hosts.each do |h|
        expect(Beaker::Puppeter::Executor).to receive(:new).with(h)
          .and_return(executor)
        expect(h).to receive(:check_for_package).with('curl').and_return(false)
        expect(h).to receive(:install_package).with('curl')
      end
      expect(subject).to receive(:on)
        .with(anything, 'curl -L https://raw.githubusercontent.com/coi-gov-pl/puppeter/master/setup.sh | bash').twice
    end
    context 'without any arguments' do
      context 'with environment variable PUPPETER_ANSWERS set to "puppet5"' do
        it 'calls Beaker::Puppeter::Executor on every host with { code: :auto, env: { set: true, answers: "puppet5" } }' do
          expect(executor).to receive(:with).with(code: :auto, env: { set: true, answers: 'puppet5' })
          ENV['PUPPETER_ANSWERS'] = 'puppet5'
          subject.run_puppeter_on(hosts)
        end
      end

      context 'without environment variables set' do
        it 'calls Beaker::Puppeter::Executor on every host with { code: :auto, env: { set: false, answers: nil } }' do
          expect(executor).to receive(:with).with(code: :auto, env: { set: false, answers: nil })
          subject.run_puppeter_on(hosts)
        end
      end
    end


    context 'with answers argument set to "alice"' do
      context 'with environment variable PUPPETER_ANSWERS set to "puppet4"' do
        it 'calls Beaker::Puppeter::Executor on every host with { code: "alice", env: { set: true, answers: "puppet4" } }' do
          expect(executor).to receive(:with)
            .with(code: 'alice', env: { set: true, answers: 'puppet4' })
          ENV['PUPPETER_ANSWERS'] = 'puppet4'
          subject.run_puppeter_on(hosts, 'alice')
        end
      end

      context 'without environment variables set' do
        it 'calls Beaker::Puppeter::Executor on every host with { code: "alice", env: { set: false, answers: nil } }' do
          expect(executor).to receive(:with).with(code: 'alice', env: { set: false, answers: nil })
          subject.run_puppeter_on(hosts, 'alice')
        end
      end
    end

  end
end
