# frozen_string_literal: true

RSpec.describe EacRubyGemSupport::Rspec::Helpers::Filesystem do
  describe '#temp_file' do
    let(:a_temp_file) { temp_file }

    it { expect(temp_file).to be_file }
  end

  describe '#temp_dir' do
    let(:a_temp_dir) { temp_dir }

    it { expect(temp_dir).to be_directory }
  end

  describe '#temp_copy' do
    let(:source_file) { Pathname.new(__FILE__) }
    let(:source_dir) { source_file.parent }
    let(:file_copy) { temp_copy(source_file) }
    let(:dir_copy) { temp_copy(source_dir) }

    it { expect(file_copy).to be_file }
    it { expect(file_copy.read).to eq(source_file.read) }
    it { expect(file_copy).not_to eq(source_file) }

    it { expect(dir_copy).to be_directory }
    it { expect(dir_copy.join(source_file.basename).read).to eq(source_file.read) }
    it { expect(dir_copy).not_to eq(source_dir) }
  end
end
