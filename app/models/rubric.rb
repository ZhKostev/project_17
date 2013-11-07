class Rubric < ActiveRecord::Base
  include Modules::Translation

  validates :title, :presence => true
  after_save :expire_cache

  has_and_belongs_to_many :articles

  scope :for_articles, lambda {|ids| joins(:articles).where('articles.id IN (?)', ids)  }

  private

  def expire_cache
    CacheManager.expire_rubric_cache(self)
  end
end
