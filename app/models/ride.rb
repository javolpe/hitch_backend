class Ride < ApplicationRecord
  belongs_to :user
  validates :origin, presence: true
  validates :destination, presence: true
  validates :departure_time, presence: true
  before_save {create_zipcodes}


  def self.find_matched_routes(origins, destinations)
    matched_origins = Ride.where(zipcode_origin: origins)
    matched_origins.where(zipcode_destination: destinations)
  end

  def create_zipcodes
    self.zipcode_origin = origin.split(',').map { |i| i[-5..-1] }[2]
    self.zipcode_destination = destination.split(',').map { |i| i[-5..-1] }[2]
  end
end
