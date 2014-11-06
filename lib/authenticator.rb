module GAssign
  class Authenticator
    attr_reader :path,
      :input_stream, :output_stream

    def initialize(path = default_path, input_stream = $stdin, output_stream = $stdout)
      @path = path
      @input_stream = input_stream
      @output_stream = output_stream
    end

    def default_path
      "#{ENV['HOME']}/.g-assign-credentials.json"
    end

    def request_credentials
      @credentials = ['username', 'password', 'github_name'].inject({}) do |hash, key|
        puts "Enter your #{key}: "
        hash[key] = gets.chomp
        hash
      end
    end

    def read_credentials
      return {} unless File.exist?(path)
      contents = File.read(path)
      @credentials = JSON.parse(contents)
    end

    def credentials
      @credentials || read_credentials
    end

    def save
      request_credentials if credentials.empty?
      File.open(path, 'w') do |f|
        f.write(credentials.to_json)
      end
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
