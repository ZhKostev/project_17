require 'spec_helper'
shared_examples "an object with translation" do

  class_to_sym = described_class.name.to_s.downcase.to_sym

  context 'instance methods' do

    let(:translated_object) { FactoryGirl.create class_to_sym }

    it 'should add presence validation' do
      translated_object.should validate_presence_of :language
    end

    it 'should add presence validation' do
      translated_object.should ensure_inclusion_of(:language).in_array(::SUPPORTED_LANGUAGES.keys.map(&:to_s))
    end

    it 'should call set_translation after save' do
      translated_object.should_receive(:set_translation)
      translated_object.save
    end

    describe '.set_translation' do
      let(:translated_object_2) { FactoryGirl.create class_to_sym, :translation_id => translated_object.id }

      it 'should set translation' do
        translated_object_2.translation.id.should eq(translated_object.id)
        translated_object.translation.id.should eq(translated_object_2.id)
      end

      it 'should change translation' do
        translated_object_3  = FactoryGirl.create class_to_sym
        translated_object_2.translation_id = translated_object_3.id
        translated_object_2.save
        translated_object_2.translation.id.should eq(translated_object_3.id)
        translated_object.translation.should be_nil
      end

      it 'should be possible to unset translation' do
        translated_object_2.translation_id = nil
        translated_object_2.save
        translated_object_2.translation.should be_nil
        translated_object.translation.should be_nil
      end
    end
  end

  context 'class methods' do
    it { should have_one(:translation) }
  end

end

describe Article do
  it_behaves_like "an object with translation"
end

describe Rubric do
  it_behaves_like "an object with translation"
end
