class Article < ActiveRecord::Base
  include Modules::Translation

  validates :title, :presence => true

  has_and_belongs_to_many :rubrics
  accepts_nested_attributes_for :rubrics

  scope :with_rubric, lambda {|rubric_id| joins(:rubrics).where('rubrics.id = ?', rubric_id)}
end
