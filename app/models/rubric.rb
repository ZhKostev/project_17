class Rubric < ActiveRecord::Base
  include Modules::Translation

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  validates :title, :presence => true

  has_and_belongs_to_many :articles
end
