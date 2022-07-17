# frozen_string_literal: true

require 'eac_ruby_utils/patches/hash/sym_keys_hash'

RSpec.describe ::Hash do
  let(:a_hash) { { 'a' => 'a_value', 1 => '1_value', s: 's_value' } }

  describe '#to_sym_keys_hash' do
    it 'converts all keys to symbols' do
      expect(a_hash.to_sym_keys_hash).to eq(a: 'a_value', '1': '1_value', s: 's_value')
    end
  end
end
