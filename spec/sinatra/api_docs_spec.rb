require "spec_helper"
require "sinatra/api_docs"
require "sinatra/base"

class MockSinatraApp < Sinatra::Base
  register Sinatra::APIDocs
end

describe Sinatra::APIDocs do
  let(:app) { Class.new(MockSinatraApp) }

  before(:each) { app.reset_documentation }

  it "can add a section" do
    app.section "test_section"
    app.section.should == "test_section"
  end

  it "can set a description" do
    app.desc "test_description"
    app.desc.should == "test_description"
  end

  it "can set params" do
    app.param "test_param", "test_param_value"
    app.param("test_param").should == "test_param_value"
  end

  it "can set a request body" do
    app.request "test_request"
    app.request.should == "test_request"
  end

  it "can set a response body" do
    app.response "test_response"
    app.response.should == "test_response"
  end

  it "can define documentation" do
    app.section  "test_section"
    app.desc     "test_description"
    app.param    "test_param", "test_param_value"
    app.request  "test_request"
    app.response "test_response"
    app.get("/") do
      "root"
    end

    app.documentation.should == [{
      :url         => "GET /", 
      :section     => "test_section", 
      :description => "test_description", 
      :params      => [["test_param", "test_param_value"]],
      :request     => "test_request", 
      :response    => "test_response"
    }]
  end

end
