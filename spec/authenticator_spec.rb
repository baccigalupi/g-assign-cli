require 'spec_helper'
require 'stringio'

describe GAssign::Authenticator do
  let(:authenticator) { GAssign::Authenticator.new(data_accessor, input_stream, output_stream) }

  let(:data_accessor) {
    double({
      read_file: data,
      save: true,
      data: data
    })
  }

  let(:data) {
    {
      'username' => 'username',
      'password' => 'password',
      'github_name' => 'github'
    }
  }

  let(:input_stream) { StringIO.new("") }
  let(:output_stream) { StringIO.new("") }

  context 'when the accessor does not have data' do
    before do
      allow(data_accessor).to receive(:read_file).and_return(nil)
      allow(input_stream).to receive(:gets).and_return('username', 'password', 'github')
    end

    it "requests credentials" do
      expect(input_stream).to receive(:gets).and_return('username', 'password', 'github')
      authenticator.credentials
    end

    it "tells the accessor to save the credentials" do
      expect(data_accessor).to receive(:save).with(data)
      authenticator.credentials
    end
  end

  context 'when the accessor has data' do
    before do
      allow(data_accessor).to receive(:read_file).and_return(data)
    end

    describe '#read_credentials' do
      it "gets them from the accessor" do
        expect(data_accessor).to receive(:read_file).and_return(data)
        authenticator.credentials
      end
    end
  end

  context 'credential accessors' do
    before do
      allow(data_accessor).to receive(:read_file).and_return(data)
    end

    it "returns the username" do
      expect(authenticator.username).to be == data['username']
    end

    it "returns the password" do
      expect(authenticator.password).to be == data['password']
    end

    it "returns the github_name" do
      expect(authenticator.github_name).to be == data['github_name']
    end
  end
end
