class Rubric < ActiveRecord::Base
  include Modules::Translation
  validates :title, :presence => true

end
