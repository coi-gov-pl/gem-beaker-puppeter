require 'spec_helper'

describe Beaker::Puppeter::Executor do
  let :subject do
    Beaker::Puppeter::Executor.new(host)
  end
  let(:logger) { double() }
  describe '#with' do
    context 'on host with nodeset config value puppeter_answers set to "alice"' do
      let :host do
        double(options: { puppeter_answers: 'alice' }, to_s: 'centos7')
      end
      before :each do
        expect(subject).to receive(:on)
          .with(host, 'puppeter --version').and_return(double(stdout: 'puppeter 0.8.0'))
        expect(subject).to receive(:logger).and_return(logger)
        expect(subject).to receive(:on)
          .with(host, /^puppeter --answers \/tmp\/puppeter-answers[a-z0-9-]+ > \/tmp\/puppeter-script\.sh$/)
        expect(subject).to receive(:on)
          .with(host, 'bash /tmp/puppeter-script.sh')
      end
      it 'executes puppeter with cecylia.yml if environment given' do
        expect(logger).to receive(:debug)
          .with('Installing Puppet via puppeter 0.8.0 on centos7 with spec/acceptance/answers/cecylia.yml')
        expect(subject).to receive(:scp_to)
          .with(host, Pathname.new('spec/acceptance/answers/cecylia.yml'), /^\/tmp\//)
        subject.with(code: 'bob', env: { set: true, answers: 'cecylia' })
      end
      it 'executes puppeter with bob.yml if no environment given' do
        expect(logger).to receive(:debug)
          .with('Installing Puppet via puppeter 0.8.0 on centos7 with spec/acceptance/answers/bob.yml')
        expect(subject).to receive(:scp_to)
          .with(host, Pathname.new('spec/acceptance/answers/bob.yml'), /^\/tmp\//)
        subject.with(code: 'bob', env: { set: false, answers: nil })
      end
      it 'executes puppeter with alice.yml if no environment and code given' do
        expect(logger).to receive(:debug)
          .with('Installing Puppet via puppeter 0.8.0 on centos7 with spec/acceptance/answers/alice.yml')
        expect(subject).to receive(:scp_to)
          .with(host, Pathname.new('spec/acceptance/answers/alice.yml'), /^\/tmp\//)
        subject.with(code: :auto, env: { set: false, answers: nil })
      end
    end


    context 'on simple host without any configuration values' do
      let(:host) { double(options: {}, to_s: 'ubuntu16') }

      before :each do
        expect(subject).to receive(:on)
          .with(host, 'puppeter --version').and_return(double(stdout: 'puppeter 0.8.1'))
        expect(subject).to receive(:logger).and_return(logger)
        expect(subject).to receive(:on)
          .with(host, /^puppeter --answers \/tmp\/puppeter-answers[a-z0-9-]+ > \/tmp\/puppeter-script\.sh$/)
        expect(subject).to receive(:on)
          .with(host, 'bash /tmp/puppeter-script.sh')
      end
      it 'executes puppeter with cecylia.yml if environment given' do
        expect(logger).to receive(:debug)
          .with('Installing Puppet via puppeter 0.8.1 on ubuntu16 with spec/acceptance/answers/cecylia.yml')
        expect(subject).to receive(:scp_to)
          .with(host, Pathname.new('spec/acceptance/answers/cecylia.yml'), /^\/tmp\//)
        subject.with(code: 'bob', env: { set: true, answers: 'cecylia' })
      end
      it 'executes puppeter with bob.yml if no environment given' do
        expect(logger).to receive(:debug)
          .with('Installing Puppet via puppeter 0.8.1 on ubuntu16 with spec/acceptance/answers/bob.yml')
        expect(subject).to receive(:scp_to)
          .with(host, Pathname.new('spec/acceptance/answers/bob.yml'), /^\/tmp\//)
        subject.with(code: 'bob', env: { set: false, answers: nil })
      end
      it 'executes puppeter with default.yml if no environment and code given' do
        expect(logger).to receive(:debug)
          .with('Installing Puppet via puppeter 0.8.1 on ubuntu16 with spec/acceptance/answers/default.yml')
        expect(subject).to receive(:scp_to)
          .with(host, Pathname.new('spec/acceptance/answers/default.yml'), /^\/tmp\//)
        subject.with(code: :auto, env: { set: false, answers: nil })
      end
    end
  end
end
