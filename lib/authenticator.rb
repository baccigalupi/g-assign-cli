module GAssign
  class Authenticator
    attr_reader :accessor, :input_stream, :output_stream

    def initialize(accessor = default_accessor, input_stream = $stdin, output_stream = $stdout)
      @accessor = accessor
      @input_stream = input_stream
      @output_stream = output_stream
    end

    def default_accessor
      DataAccessor.new('credentials.json')
    end

    def request_credentials
      ['username', 'password', 'github_name'].inject({}) do |hash, key|
        puts "Enter your #{key}: "
        hash[key] = gets.chomp
        hash
      end
    end

    def credentials
      return @credentials if @credentials
      @credentials = accessor.read_file
      unless @credentials
        accessor.save(request_credentials)
        @credentials = accessor.data
      end
      @credentials
    end

    def username
      credentials['username']
    end

    def password
      credentials['password']
    end

    def github_name
      credentials['github_name']
    end

    def gets
      input_stream.gets
    end

    def puts(message)
      output_stream.puts(message)
    end
  end
end
