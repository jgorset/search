require 'spec_helper'

describe Search::Manager do
  subject { described_class.new(limit: 10) }

  let(:just_the_word_foo) { File.new('spec/fixtures/just_the_word_foo.txt') }
  let(:foo_and_other_words) { File.new('spec/fixtures/foo_and_other_words.txt') }

  describe '.cache' do
    it 'adds a file path and its contents to the haystacks' do
      subject.cache(just_the_word_foo)

      expect(subject.haystacks).to eq({
        'spec/fixtures/just_the_word_foo.txt' => "foo\n"
      })
    end
  end

  describe '.purge' do
    before { subject.cache(just_the_word_foo) }

    it 'removes a file path and its contents from the haystacks' do
      subject.purge(just_the_word_foo)

      expect(subject.haystacks).to be_empty
    end
  end

  describe '.match' do
    context 'with a search hit' do
      before { subject.cache(just_the_word_foo) }
      before { subject.cache(foo_and_other_words) }

      it 'returns a list of files and the quality of the match in each file' do
        matches = subject.match('foo bar')

        expect(matches).to eq([
          [100, 'spec/fixtures/foo_and_other_words.txt'],
          [50, 'spec/fixtures/just_the_word_foo.txt']
        ])
      end
    end

    context 'with a search miss' do
      it 'returns an empty array' do
        matches = subject.match('foo')

        expect(matches).to be_empty
      end
    end
  end

  describe '.suggest' do
    before do
      subject.cache(just_the_word_foo)
      subject.cache(foo_and_other_words)
    end

    it 'suggests more words to narrow the search' do
      suggestions = subject.suggest('foo')

      expect(suggestions).to eq([' bar baz'])
    end
  end
end
