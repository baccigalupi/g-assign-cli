module GAssign
  class DataAccessor
    attr_reader :dir, :file_name

    # for testing and other DI conveniences
    def initialize(dir = default_dir, file_name = default_file_name)
      @dir = path
      @file_name = file_name
    end

    def path
      "#{dir}/#{file_name}"
    end

    def default_file_name
      ""
    end

    def default_dir
      "#{ENV['HOME']}/.g-assign"
    end

    def default_data_structure
      {}
    end

    def file_exist?
      File.exist?(path)
    end

    def read_file
      return default_data_structure if !file_exist?
      contents = File.read(path)
      @data = JSON.parse(contents)
    end

    def data
      @data || read_file
    end

    def save(data_to_save)
      @data = data_to_save
      File.open(path, 'w') do |f|
        f.write(data.to_json)
      end
    end
  end
end
