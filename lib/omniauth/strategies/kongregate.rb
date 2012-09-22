require 'omniauth'
require 'net/http'
require 'uri'
require 'json'

module OmniAuth
  module Strategies
    class Kongregate
      include OmniAuth::Strategy

      args [:api_key]

      option :fields, [:user_id, :game_auth_token]
      option :uid_field, :user_id

      def request_phase
        redirect "/auth/kongregate/callback?user_id=#{request[:kongregate_user_id]}&game_auth_token=#{request[:kongregate_game_auth_token]}"
      end

      def callback_phase
        @k_response = verify_kongregate_auth(request[:user_id], request[:game_auth_token])
        return fail!(:invalid_credentials) unless authenticated?
        super
      end

      uid { @k_response['user_id'] if authenticated? }

      extra { { :username => @k_response['username'] } if authenticated? }

      private

      def authenticated?
        @k_response && @k_response['success']
      end

      def verify_kongregate_auth(user_id, game_auth_token)
        uri = URI.parse('http://www.kongregate.com/api/authenticate.json')
        uri.query = URI.encode_www_form({
          :user_id => user_id,
          :game_auth_token => game_auth_token,
          :api_key => options.api_key
        })
        begin
          response = Net::HTTP.get_response(uri)
          log :debug, "Kongregate HTTP: #{response.code} - #{response.body}"
          JSON.parse(response.body)
        rescue Exception => e
          fail!(:kongregate_query_error, e)
          nil
        end
      end

    end
  end
end
