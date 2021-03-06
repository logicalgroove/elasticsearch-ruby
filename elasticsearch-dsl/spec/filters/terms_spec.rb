require 'spec_helper'

describe Elasticsearch::DSL::Search::Filters::Terms do

  let(:search) do
    described_class.new
  end

  describe '#to_hash' do

    it 'can be converted to a hash' do
      expect(search.to_hash).to eq(terms: {})
    end
  end

  describe '#initialize' do

    context 'when a hash is specified' do

      let(:search) do
        described_class.new(foo: ['abc', 'xyz'])
      end

      it 'sets the value' do
        expect(search.to_hash).to eq(terms: { foo: ['abc', 'xyz'] })
      end
    end
  end
end
