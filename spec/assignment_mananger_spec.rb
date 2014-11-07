require 'spec_helper'

describe GAssign::AssignmentManager do
  let(:manager) { GAssign::AssignmentManager.new(data, system) }

  let(:data) { {"name" =>"temperature spread", "location" => "git@github.com:gschool-g5/temperature_spread"} }
  let(:system) { double(puts: '', run: '') }

  before do
    allow(File).to receive(:exist?).and_return(false)
  end

  describe '#path' do
    it "is the repo name" do
      expect(manager.path).to be == "temperature_spread"
    end
  end

  describe '#clone' do
    it "git clones the project and removes the .git directory" do
      command_number = 0
      expect(system).to receive(:run).exactly(2).times do |command|
        if command_number == 0
          command_number += 1
          expect(command).to be == "git clone #{data['location']}"
        else
          expect(command).to match(/rm -rf .*\.git/)
        end
      end

      manager.clone
    end
  end
end
