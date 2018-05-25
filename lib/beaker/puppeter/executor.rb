module Beaker
  module Puppeter
    class Executor

      def initialize(host)
        @host = host
        @puppeter_ver = nil
      end

      def with(answers)
        root = Pathname.new '.'
        answers_dir = root.join('spec')
          .join('acceptance')
          .join('answers')
        answers_file = answers_dir.join("#{answers}.yml")
        ver = infra_version
        logger.debug "Installing Puppet via #{ver} on #{@host} with #{answers_file}"
        copied = copy_answers answers_file
        on @host, "puppeter --answers #{copied} > /tmp/puppeter-script.sh"
        on @host, 'bash /tmp/puppeter-script.sh'
      end

      private

      def copy_answers(answers_file)
        target_file = Dir::Tmpname.make_tmpname('/tmp/puppeter-answers', nil)
        scp_to @host, answers_file, target_file
        target_file
      end

      def infra_version
        @puppeter_ver = on @host, 'puppeter --version' if @puppeter_ver.nil?
        @puppeter_ver.stdout.strip
      end

    end
  end
end
