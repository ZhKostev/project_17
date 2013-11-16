class Article < ActiveRecord::Base
  include Modules::Translation

  validates :title, :presence => true

  has_and_belongs_to_many :rubrics
  accepts_nested_attributes_for :rubrics

  scope :with_rubric, lambda {|rubric_id| joins(:rubrics).where('rubrics.id = ?', rubric_id)}
  scope :published, -> {where(:published =>true)}

  after_save :expire_article_cache

  # Public. Method to define what would be shown on front article index
  #
  # Returns String
  def show_body
    short_description.presence || body
  end

  private
  def expire_article_cache
    CacheManager.expire_article_cache(self)
  end
end
