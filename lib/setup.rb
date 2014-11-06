module GAssign
  class Setup
    def self.mkdirs
      `mkdir -p ~/Projects/gSchool/gAssign/current`
      `mkdir -p ~/Projects/gSchool/gAssign/complete`
      `mkdir -p ~/Projects/gSchool/gAssign/solutions`
    end
  end
end
