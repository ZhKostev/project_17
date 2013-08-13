class Rubric < ActiveRecord::Base
  include Modules::Translation

  validates :title, :presence => true

  has_and_belongs_to_many :articles
end
