module GAssign
  class Assignments
    attr_reader :api, :accessor, :system

    def initialize(accessor = default_accessor, api = default_api, system = default_system)
      @api = api
      @accessor = accessor
      @system = system
    end

    def refresh_data
      system.puts "Retrieving latest information on exercises ..."
      accessor.save(api.all('assignments'))
    end

    def all
      accessor.data
    end

    def clone
      CLI::Setup.new.run unless File.exist?(GAssign::ASSIGNMENTS_DIR)

      dirs = []

      Dir.chdir(GAssign::ASSIGNMENTS_DIR) do
        all.each do |assignment|
          dirs << AssignmentManager.new(assignment).clone
        end
      end
      dirs.compact!

      system.puts
      system.puts "Fetched #{dirs.size} repositories"
      dirs.map {|d| system.puts "  #{d}"}
    end

    def default_accessor
      @accessor ||= DataAccessor.new('assignments.json')
    end

    def default_api
      @api ||= API.new(Authenticator.new)
    end

    def default_system
      @system = System.new
    end
  end
end
