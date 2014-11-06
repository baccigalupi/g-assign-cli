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
        `mkdir -p #{GAssign::DATA_DIR}`
        `mkdir -p #{GAssign::ASSIGNMENTS_DIR}`
      end

      def authenticate
        puts "Setting up credentials ..."
        Authenticator.new.credentials
      end
    end
  end
end
