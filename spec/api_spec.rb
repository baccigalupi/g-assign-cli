require 'spec_helper'

describe GAssign::API do
  let(:api) { GAssign::API.new }

  describe 'getting all assignments' do
    it "calls RestClient correctly" do
      expect(RestClient).to receive(:get).with("http://g-assign-api.herokuapp.com/assignments")
      api.all('assignments')
    end

    it "parses the response into json" do
      allow(RestClient).to receive(:get).and_return({foo: 'bar'}.to_json)
      json = api.all('assignments')
      expect(json).to be == {'foo' => 'bar'}
    end
  end

  describe 'creating an assignment' do
    it "calls RestClient with the right url" do
      expect(RestClient).to receive(:post).with("http://g-assign-api.herokuapp.com/assignments", anything, anything)
      api.create("assignments", {foo: 'bar'})
    end

    it "calls RestClient with the right data" do
      expect(RestClient).to receive(:post).with(anything, {foo: 'bar'}.to_json, anything)
      api.create("assignments", {foo: 'bar'})
    end

    it "processes the response as json" do
      allow(RestClient).to receive(:post).and_return({baz: 'zardoz'}.to_json)
      json = api.create("assignments", {foo: 'bar'})
      expect(json).to be == {'baz' => 'zardoz'}
    end
  end
end
