module GAssign
  module CLI
    class Setup
      def initialize(*args)
      end

      def run
        mkdirs
        authenticate
        puts "All good!"
      end

      def mkdirs
        puts "Making directories ..."
        `mkdir -p ~/.g-assign`
        `mkdir -p ~/Project/gSchool/assignments`
      end

      def authenticate
        puts "Setting up credentials ..."
        Authenticator.new.credentials
      end
    end
  end
end
