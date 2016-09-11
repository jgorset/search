require 'spec_helper'

describe Search do
  describe '.suggestions' do
    subject { Search.new('what is the meaning of', haystack: haystack) }

    context 'when the search has a single match' do
      let(:haystack) { 'What is the meaning of life?' }

      it 'is the next few words in the matching sentence' do
        expect(subject.suggestions).to eq([
          ' life'
        ])
      end
    end

    context 'when the search has multiple matches' do
      let :haystack do
        'What is the meaning of life? And what is the meaning of lol?'
      end

      it 'is the next few words in every matching sentence' do
        expect(subject.suggestions).to eq([
          ' life', ' lol'
        ])
      end
    end
  end

  describe '.quality' do
    subject { Search.new('one two', haystack: haystack) }

    context 'when the file contains all the search terms' do
      let(:haystack) { 'one two three four' }

      it 'is 100' do
        expect(subject.quality).to eq(100)
      end
    end

    context 'when the file contains a portion of the search terms' do
      let(:haystack) { 'one three' }

      it 'is the percentage of the file that contains it' do
        expect(subject.quality).to eq(50)
      end
    end

    context 'when the file contains none of the search terms' do
      let(:haystack) { 'five six' }

      it 'is 0' do
        expect(subject.quality).to eq(0)
      end
    end
  end
end
