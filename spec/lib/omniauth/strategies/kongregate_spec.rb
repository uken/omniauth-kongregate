require 'spec_helper'
require "net/http"
require "uri"
require "omniauth-kongregate"

describe 'Kongregate Strategy' do

  KONGREGATE_URL = 'http://www.kongregate.com/api/authenticate.json'

  let :strategy do
    app = double('app')
    app.stub(:call)
    strategy = OmniAuth::Strategies::Kongregate.new app
    strategy.stub(:request).and_return(request_params)
    strategy.options[:api_key] = 'SOME_API_KEY'
    strategy.instance_variable_set('@env',{})
    strategy
  end

  context 'request phase' do
    let :request_params do
      {
        :kongregate_user_id => '123456',
        :kongregate_game_auth_token => 'SOME_AUTH_TOKEN'
      }
    end

    it 'should forward Kongregate iframe params to callback with names expected by Kongregate' do
      strategy.should_receive(:redirect).with('/auth/kongregate/callback?user_id=123456&game_auth_token=SOME_AUTH_TOKEN')
      strategy.request_phase
    end
  end

  context 'callback phase' do
    let :request_params do
      {
        :user_id => '123456',
        :game_auth_token => 'SOME_AUTH_TOKEN',
        :api_key => 'SOME_API_KEY'
      }
    end

    before :each do
      WebMock.reset!
      @kongregate_api = stub_request(:get, KONGREGATE_URL).with(:query => hash_including(request_params))
    end

    it 'should pass the parameters and the API key when calling Kongregate' do
      strategy.callback_phase
      @kongregate_api.should have_been_requested
    end

    context 'guest access' do
      let :request_params do
        {
          :user_id => '0',
          :game_auth_token => 'SOME_AUTH_TOKEN',
          :api_key => 'SOME_API_KEY'
        }
      end

      it "should bypass kongregate authentication request" do
        strategy.callback_phase
        @kongregate_api.should_not have_been_requested
      end

      it "should set username as guest" do
        strategy.callback_phase
        strategy.extra[:username] == "guest"
      end

      it "should set the uid" do
        strategy.callback_phase
        strategy.uid.should_not be_nil
      end

      it 'should not throw an error' do
        strategy.should_not_receive(:fail!)
        strategy.callback_phase
      end
    end

    context 'valid authentication' do
      before do
        @kongregate_api.to_return(:body => '{"success":true,"username":"SOME_USERNAME","user_id":123456}')
      end

      it 'should set the uid' do
        strategy.callback_phase
        strategy.uid.should == 123456
      end

      it 'should not throw an error' do
        strategy.should_not_receive(:fail!)
        strategy.callback_phase
      end
    end

    context 'invalid authentication' do
      before do
        @kongregate_api.to_return(:body => '{"success":false,"error":403,"error_description":"Invalid credentials"}')
      end

      it 'should not set the uid' do
        strategy.callback_phase
        strategy.uid.should be_nil
      end

      it 'should throw an error' do
        strategy.should_receive(:fail!).with(:invalid_credentials)
        strategy.callback_phase
      end
    end
  end
end
