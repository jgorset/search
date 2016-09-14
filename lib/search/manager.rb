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

    # Match the given terms against the haystack.
    #
    # search - A String to search for.
    #
    # Returns an Array of a String describing the file path, and an Integer
    # describing the quality of the match.
    def match(search)
      filenames_with_quality = haystacks.map do |path, haystack|
        [Search.new(haystack).match(search), path]
      end

      limit sort filenames_with_quality
    end

    # Get suggestions for narrowing the search.
    #
    # search - A String to provide suggestions for.
    #
    # Returns an Array of Strings that would narrow the search.
    def suggest(search)
      suggestions = haystacks.map do |path, haystack|
        Search.new(haystack).suggest(search)
      end.flatten

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
