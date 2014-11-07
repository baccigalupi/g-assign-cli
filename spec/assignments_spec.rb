require 'spec_helper'

describe GAssign::Assignments do
  let(:assignments) { GAssign::Assignments.new(accessor, api, printer) }

  let(:accessor) { double(save: [], data: []) }
  let(:api) { double(all: []) }
  let(:printer) { double(puts: '', run: '') }

  before do
    allow(GAssign::CLI::Fetch).to receive(:new).and_return(double(run: true))
  end

  describe '#refresh_data' do
    it "makes an api request for all assignments" do
      expect(api).to receive(:all).with('assignments').and_return([])
      assignments.refresh_data
    end

    it "saves the data" do
      expect(accessor).to receive(:save).with(accessor.save)
      assignments.refresh_data
    end
  end

  describe '#clone' do
    let(:assignment_data) {
      [
        {"name" =>"temperature spread", "location" => "git@github.com:gschool-g5/temperature_spread"},
        {"name" => "array-exercises", "location" => "git@github.com:gschool/array-exercises"}
      ]
    }

    let(:cloner) { double }

    before do
      allow(accessor).to receive(:data).and_return(assignment_data)
    end

    it "builds and runs an assignment cloner for each" do
      expect(GAssign::AssignmentManager).to receive(:new).exactly(2).times.and_return(cloner)
      expect(cloner).to receive(:clone).exactly(2).times
      assignments.clone
    end
  end
end
