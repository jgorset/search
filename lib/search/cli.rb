class Search
  class CLI
    attr_reader :search, :glob

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

      limit sort filenames_with_quality
    end

    def suggestions
      suggestions = files.map do |file|
        Search.new(search, haystack: file.read).suggestions
      end

      limit suggestions
    end

    private

    def sort(array)
      array.sort_by(&:first).reverse
    end

    def limit(array)
      array[0, @limit]
    end
  end
end
