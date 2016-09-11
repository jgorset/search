require 'spec_helper'

describe Search do
  describe '.suggest' do
    context 'when the search has a single match' do
      subject { Search.new('What is the meaning of life?') }

      it 'is the next few words in the matching sentence' do
        expect(subject.suggest('what is the meaning of')).to eq([
          ' life'
        ])
      end
    end

    context 'when the search has multiple matches' do
      subject { Search.new('What is the meaning of life? What is the meaning of lol?') }

      it 'is the next few words in every matching sentence' do
        expect(subject.suggest('what is the meaning of')).to eq([
          ' life', ' lol'
        ])
      end
    end
  end

  describe '.match' do
    subject { Search.new('one two three') }

    context 'when the file contains all the search terms' do
      it 'is 100' do
        expect(subject.match('one two')).to eq(100)
      end
    end

    context 'when the file contains a portion of the search terms' do
      it 'is the percentage of the file that contains it' do
        expect(subject.match('three four')).to eq(50)
      end
    end

    context 'when the file contains none of the search terms' do
      it 'is 0' do
        expect(subject.match('five six')).to eq(0)
      end
    end
  end
end
