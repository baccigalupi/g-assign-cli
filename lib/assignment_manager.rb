module GAssign
  class AssignmentManager
    attr_reader :data, :system

    def initialize(data, system=System.new)
      @data = data
      @system = system
    end

    def clone
      Dir.chdir(GAssign::ASSIGNMENTS_DIR) do
        if path && !File.exist?("#{GAssign::ASSIGNMENTS_DIR}/#{path}")
          clone_and_report
          remove_git
        end
      end

      path
    end

    def path
      matches = data['location'].match(/\/([^\/]*)$/)
      matches && matches[1]
    end

    def clone_and_report
      system.puts "Cloning assignment: #{data['name']}"
      system.run "git clone #{data['location']}"
      system.puts
    end

    def remove_git
      system.run "rm -rf #{path}/.git"
    end
  end
end
