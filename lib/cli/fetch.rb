module GAssign
  module CLI
    class Fetch
      def initialize(*args)
      end

      def assignments
        @assignments ||= GAssign::Assignments.new
      end

      def run
        assignments.refresh_data
        assignments.clone
      end
    end
  end
end
