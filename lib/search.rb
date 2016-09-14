require 'search/version'
require 'search/manager'

class Search
  attr_reader :haystack

  # Initializes a new search.
  #
  # haystack - A String to search in.
  def initialize(haystack)
    @haystack = haystack
  end

  # Get suggestions for narrowing the search.
  #
  # Example
  #
  #   search = Search.new(
  #     'What is the meaning of life? And what is the meaning of lol?'
  #   )
  #   search.suggestions(
  #   # => [
  #   #   [' life', ' lol']
  #   # ]
  #
  # Returns an Array of Strings that would narrow the search.
  def suggest(search)
    suggestions = []

    haystack.scan /#{search}(?<suggestion>\b[^.?!]+\b{1,5})/i do |match|
      suggestions << match.first
    end

    suggestions
  end

  # Match the given terms against the haystack.
  #
  # Example
  #
  #   search = Search.new('one two three')
  #   search.match('one five')
  #   # => 50
  #
  # Returns an Integer describing the percentage of search words present in the haystack.
  def match(search)
    search_words = words(search)
    haystack_words = words(haystack)

    (
      search_words.count { |search_word| haystack_words.include? search_word } /
      search_words.count.to_f *
      100
    ).round
  rescue ZeroDivisionError
    0
  end

  private

  def haystack_words
    @haystack_words ||= words_in(@haystack)
  end

  def search_words_present_in_haystack
    search_words.select do |search_word|
      haystack_words.include? search_word
    end
  end

  def words(string)
    string.split(/[^[[:word:]]]+/)
  end

  class Error < StandardError; end
end
