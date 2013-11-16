require 'spec_helper'

describe Rubric do
  it { should have_and_belong_to_many(:articles) }
  it { should validate_presence_of(:title) }

  describe '.for_articles' do
    it 'should fetch rubrics with exact article' do
      article_1 = FactoryGirl.create :article
      article_2 = FactoryGirl.create :article
      FactoryGirl.create :rubric, :articles => [article_1]
      rubric_2 = FactoryGirl.create :rubric, :articles => [article_1, article_2]
      rubric_3 = FactoryGirl.create :rubric, :articles => [article_2]
      Rubric.for_articles([article_2.id]).order('id').should eq([rubric_2, rubric_3].sort_by { |rubric| rubric.id })
    end
  end

  describe '#expire_cache' do
    it 'should be call in after save' do
      rubric = FactoryGirl.create :rubric
      rubric.should_receive(:expire_cache)
      rubric.save
    end

    it 'should call CacheManager.expire_rubric_cache' do
      rubric = stub_model Rubric
      CacheManager.should_receive(:expire_rubric_cache).with(rubric)
      rubric.send(:expire_cache)
    end
  end
end
