module GAssign
  class System
    attr_reader :stdin, :stdout

    def initialize(stdin = $stdin, stdout = $stdout)
      @stdin = stdin
      @stdout = stdout
    end

    def puts(message)
      stdout.puts(message)
    end

    def gets
      stdout.gets
    end

    def run(command)
      `#{command}`
    end
  end
end
