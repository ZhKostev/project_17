class Rubric < ActiveRecord::Base
  include Modules::Translation

  validates :title, :presence => true

  has_and_belongs_to_many :articles

  scope :for_articles, lambda {|articles| joins(:articles).where('articles.id IN (?)', articles.except(:order).pluck(:id))  }
end
