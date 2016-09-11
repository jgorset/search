class Search
  class Manager
    attr_reader :glob, :haystacks

    def initialize(limit:)
      @limit = limit
      @haystacks = {}
    end

    # Add the file to the cache.
    #
    # file - A File object.
    def cache(file)
      @haystacks.store(file.path, file.read)
    end

    # Purge the file from the cache.
    #
    # file - A File object.
    def purge(file)
      @haystacks.delete(file.path)
    end

    def match(search)
      filenames_with_quality = haystacks.map do |path, haystack|
        [Search.new(haystack).match(search), path]
      end

      limit sort filenames_with_quality
    end

    def suggest(search)
      suggestions = haystacks.map do |path, haystack|
        Search.new(haystack).suggest(search)
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
