module GAssign
  class Assignments
    def refresh_data
      accessor.save(api.all('assignments'))
    end

    def all
      accessor.data
    end

    def clone
      Dir.chdir(GAssign::ASSIGNMENTS_DIR) do
        all.each do |assignment|
          puts "cloning assignment: #{assignment[:name]}"
          `git clone #{assignment['location']}`
        end
      end
    end

    def accessor
      @accessor ||= DataAccessor.new('assignments.json')
    end

    def auth
      @auth ||= Authenticator.new
    end

    def api
      @api ||= API.new(auth)
    end
  end
end
