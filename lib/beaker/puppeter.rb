require 'beaker/puppeter/version'
require 'beaker/puppeter/executor'
require 'beaker'

module Beaker
  module Puppeter
    PUPPETER_SCRIPT_KEY = 'PUPPETER_ANSWERS'

    def run_puppeter(answers = :auto)
      run_puppeter_on(hosts, answers)
    end

    def run_puppeter_on(hosts, answers = :auto)
      hosts.each do |host|
        install_puppeter_on host
        execute_puppeter_on(host)
          .with(code: answers, env: env_answers)
      end
    end

    private

    def env_answers
      answers = ENV.fetch(PUPPETER_SCRIPT_KEY, nil)
      set = !answers.nil?
      { set: set, answers: answers }
    end

    def install_puppeter_on(host)
      ensure_curl_on host
      on host, 'curl -L https://raw.githubusercontent.com/coi-gov-pl/puppeter/master/setup.sh | bash'
    end

    def execute_puppeter_on(host)
      Beaker::Puppeter::Executor.new(host)
    end

    def ensure_curl_on(host)
      pkg = 'curl'
      unless host.check_for_package pkg
        host.install_package pkg
      end
    end
  end
end

include Beaker::Puppeter
