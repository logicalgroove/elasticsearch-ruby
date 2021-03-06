require 'spec_helper'

describe Elasticsearch::DSL::Search::Filters::Regexp do

  let(:search) do
    described_class.new
  end

  describe '#to_hash' do

    it 'can be converted to a hash' do
      expect(search.to_hash).to eq(regexp: {})
    end
  end

  context 'when options methods are called' do

    let(:search) do
      described_class.new(:foo)
    end

    describe '#value' do

      before do
        search.value('bar')
      end

      it 'applies the option' do
        expect(search.to_hash[:regexp][:foo][:value]).to eq('bar')
      end
    end

    describe '#flags' do

      before do
        search.flags('bar')
      end

      it 'applies the option' do
        expect(search.to_hash[:regexp][:foo][:flags]).to eq('bar')
      end
    end
  end

  describe '#initialize' do

    context 'when a hash is provided' do

      let(:search) do
        described_class.new(foo: 'b.*r')
      end

      it 'applies the hash' do
        expect(search.to_hash).to eq(regexp: { foo: 'b.*r' })
      end
    end

    context 'when a block is provided' do

      let(:search) do
        described_class.new(:foo) do
          value 'b*r'
        end
      end

      it 'executes the block' do
        expect(search.to_hash).to eq(regexp: { foo: { value: 'b*r' } })
      end
    end
  end
end
