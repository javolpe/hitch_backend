# frozen_string_literal: true

require 'rails_helper'

describe 'Rides Index Endpoint' do
  describe 'GET /rides' do
    xit 'can fetch all rides' do
      VCR.use_cassette('ride-matcher') do
        user = create(:user).id
        ride = create(:ride, origin: '1125 S Kalispell St, Aurora, CO 80017, USA', destination: '3300 S Tamarac Dr, Denver, CO 80231, USA', user_id: user)

        get "/api/v1/users/#{user}/rides?origin=#{ride.origin}&destination=#{ride.destination}&radius=2"

        expect(response).to be_successful

        rides = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(rides.count).to eq(1)

        rides.each do |ride|
          check_hash_structure(ride, :type, String)

          ride_details = ride[:attributes]

          check_hash_structure(ride_details, :origin, String)
          check_hash_structure(ride_details, :destination, String)
          check_hash_structure(ride_details, :departure_time, String)
          check_hash_structure(ride_details, :user_id, Integer)
        end
      end
    end
  end
end
