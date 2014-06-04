class Event < ActiveRecord::Base
  has_many :opinions
  validates_uniqueness_of :api_id
end
