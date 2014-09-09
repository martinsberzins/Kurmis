class Event < ActiveRecord::Base
  auto_strip_attributes :url
  validates :url, uniqueness: true
  validates :url, presence: true
end
