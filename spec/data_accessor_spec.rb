require 'spec_helper'

describe GAssign::DataAccessor do
  let(:accessor) { GAssign::DataAccessor.new(file_name, dir) }

  let(:dir) { File.dirname(__FILE__) + "/support" }
  let(:file_name) { "credentials.json" }
  let(:path) { "#{dir}/#{file_name}" }

  let(:file_contents) { File.read(path) }

  context 'when the file does not exist' do
    before do
      File.delete(path) if File.exist?(path)
    end

    describe '#save' do
      context 'when there are no credentials' do
        let(:data) { ['hello', 'world'] }

        it "creates the file" do
          accessor.save(data)
          expect(File.exist?(path)).to be == true
        end

        it "saves the data in the file" do
          accessor.save(data)
          expect(file_contents).to be == data.to_json
        end

        it "stores the data in the instance" do
          accessor.save(data)
          expect(accessor.data).to be == data
        end
      end
    end
  end

  context 'when the file already exists' do
    let(:data) { {'gerbil' => 'toss'} }

    before do
      File.delete(path) if File.exist?(path)
      GAssign::DataAccessor.new(file_name, dir).save(data)
    end

    describe '#read_credentials' do
      it "gets them from the file" do
        accessor.read_file
        expect(accessor.data).to be == data
      end
    end
  end
end
