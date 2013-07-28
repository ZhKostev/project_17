#This module used to handle multi language for rubrics and articles
module Modules::Translation
  extend ActiveSupport::Concern

  included do
    validates :language, :inclusion => {:in => ::SUPPORTED_LANGUAGES.keys.map(&:to_s)}, :presence => true

    scope :for_language, lambda { |language| where(:language => language.to_s) }

    has_one :translation, :class_name => self.to_s, :foreign_key => :translation_id

    after_save :set_translation
  end

  private

  #Private. Method that will update translations. If one rubric have translation_id it will set translation_id for
  #         "translated" rubrics (rubric with id = translation_id).
  #
  # Example
  #   If rubric with id='101' have translation_id='5' and rubric this field was updated from '5' to '7' this method set
  #     translation_id=nil for rubric with id='5' and translation_id='101' for rubric with id='7'
  #
  # Returns nothing
  #
  def set_translation
    if self.changes && self.changes[:translation_id]
      old_model = self.class.find(self.changes[:translation_id].first) rescue nil
      new_model = self.class.find(self.changes[:translation_id].last) rescue nil
      old_model.update_column(:translation_id, nil) rescue nil
      new_model.update_column(:translation_id, self.id) rescue nil
    end
  end

end