require 'search/version'
require 'search/cli'

class Search
  # Initializes a new search.
  #
  # search - A String describing the term to search for.
  # haystack - A String to search.
  def initialize(search, haystack:)
    @search = search
    @haystack = haystack
  end

  # Get suggestions for narrowing the search.
  #
  # Example
  #
  #   search = Search.new('what is the meaning of',
  #     haystack: 'What is the meaning of life? And what is the meaning of lol?'
  #   )
  #
  #   search.suggestions
  #   # => [
  #   #   [' life', ' lol']
  #   # ]
  #
  # Returns an Array of Strings that would narrow the search.
  def suggestions
    suggestions = []

    @haystack.scan /#{@search}(?<suggestion>\b[^.?!]+\b{1,5})/io do |match|
      suggestions << match.first
    end

    suggestions
  end

  # Get the match quality.
  #
  # The quality is determined by how many of the search words the haystack contains.
  #
  # Example
  #
  #   search = Search.new('one two'
  #     haystack: 'one two three four'
  #   )
  #   search.quality
  #   # => 50
  #
  # Returns an Integer describing the percentage of search words present in the haystack.
  def quality
    (search_words_present_in_haystack.count.to_f / search_words.count.to_f * 100).round
  rescue ZeroDivisionError
    0
  end

  private

  def search_words
    @search_words ||= words_in(@search)
  end

  def haystack_words
    @haystack_words ||= words_in(@haystack)
  end

  def search_words_present_in_haystack
    search_words.select do |search_word|
      haystack_words.include? search_word
    end
  end

  def words_in(string)
    string.split(/[^[[:word:]]]+/)
  end

  class Error < StandardError; end
end
