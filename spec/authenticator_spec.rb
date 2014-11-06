require 'spec_helper'
require 'stringio'

describe GAssign::Authenticator do
  let(:authenticator) { GAssign::Authenticator.new(path, input_stream, output_stream) }

  let(:path) { File.dirname(__FILE__) + "/support/credentials.json" }
  let(:input_stream) { StringIO.new("") }
  let(:output_stream) { StringIO.new("") }

  context 'when the file does not exist' do
    before do
      File.delete(path) if File.exist?(path)
      allow(input_stream).to receive(:gets).and_return('username', 'password', 'github')
    end

    describe '#request_credentials' do
      it "gets the username and stores it" do
        authenticator.request_credentials
        expect(authenticator.username).to be == 'username'
      end

      it "gets the password and stores it" do
        authenticator.request_credentials
        expect(authenticator.password).to be == 'password'
      end

      it "gets the github name and stores it" do
        authenticator.request_credentials
        expect(authenticator.github_name).to be == 'github'
      end
    end

    describe '#save' do
      context 'when there are no credentials' do
        it "requests credentials" do
          expect(input_stream).to receive(:gets).and_return('username', 'password', 'github')
          authenticator.save
        end

        it "saves the credentials to the path" do
          authenticator.save
          expect(File.exist?(path)).to be == true
        end
      end
    end
  end

  context 'when the file already exists' do
    before do
      unless File.exist?(path)
        allow(input_stream).to receive(:gets).and_return('username', 'password', 'github')
        GAssign::Authenticator.new(path, input_stream, output_stream).save
      end
    end

    describe '#read_credentials' do
      it "gets them from the file" do
        authenticator.read_credentials
        expect(authenticator.username).to be == 'username'
        expect(authenticator.password).to be == 'password'
        expect(authenticator.github_name).to be == 'github'
      end
    end
  end
end
