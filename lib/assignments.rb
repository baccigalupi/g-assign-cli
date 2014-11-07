# DOH! No tests, yo!
module GAssign
  class Assignments
    def refresh_data
      puts "Retrieving latest information on exercises ..."
      accessor.save(api.all('assignments'))
    end

    def all
      accessor.data
    end

    def clone
      dirs = []

      Dir.chdir(GAssign::ASSIGNMENTS_DIR) do
        all.each do |assignment|
          dir = directory(assignment['location'])

          if dir && !File.exist?("#{GAssign::ASSIGNMENTS_DIR}/#{dir}")
            dirs << dir
            clone_assignment(assignment)
            remove_git_dir(dir)
          end
        end
      end

      puts
      puts "Fetched #{dirs.size} repositories"
      dirs.map {|d| puts "  #{d}"}
    end

    def clone_assignment(assignment)
      puts "Cloning assignment: #{assignment['name']}"
      `git clone #{assignment['location']}`
      puts
    end

    def remove_git_dir(dir)
      `rm -rf #{dir}/.git`
    end

    def directory(repo)
      matches = repo.match(/\/([^\/]*)$/)
      matches && matches[1]
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
