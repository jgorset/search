class Search
  class CLI
    attr_reader :search, :glob, :limit

    def initialize(search, options)
      @search = search
      @glob = options[:files]
      @limit = options[:n]
    end

    def files
      raise Error, 'You must provide files to search' if glob.nil?

      filenames.map do |filename|
        File.open(filename)
      end
    end

    def filenames
      Dir.glob(glob)
    end

    def qualities
      filenames_with_quality = files.map do |file|
        [Search.new(search, haystack: file.read).quality, file.path]
      end

      filenames_with_quality.sort_by { |x, y| x[0] <=> y[0] }

      filenames_with_quality[0, limit]
    end

    def suggestions
      files.map do |file|
        Search.new(search, haystack: file.read).suggestions
      end[0, limit]
    end
  end
end
