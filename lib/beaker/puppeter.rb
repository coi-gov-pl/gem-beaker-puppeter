require 'beaker/puppeter/version'
require 'beaker/puppeter/executor'

module Beaker
  module Puppeter
    PUPPETER_SCRIPT_KEY = 'PUPPETER_ANSWERS'
    PUPPETER_SCRIPT_DEFAULT_VALUE = 'default'

    def run_puppeter(answers = :auto)
      run_puppeter_on(hosts, answers)
    end

    def run_puppeter_on(hosts, answers = :auto)
      if answers == :auto
        answers = ENV.fetch(PUPPETER_SCRIPT_KEY, PUPPETER_SCRIPT_DEFAULT_VALUE)
      end

      install_puppeter_on hosts
      hosts.each do |host|
        execute_puppeter_on(host).with(answers)
      end
    end

    private

    def install_puppeter_on(hosts)
      hosts.each do |host|
        ensure_curl_on host
        on host, 'curl https://raw.githubusercontent.com/coi-gov-pl/puppeter/master/setup.sh | bash'
      end
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
