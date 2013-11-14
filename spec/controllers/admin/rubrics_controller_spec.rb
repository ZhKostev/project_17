require 'spec_helper'

describe Admin::RubricsController do

  let(:valid_attributes) { FactoryGirl.attributes_for :rubric }
  sign_in_admin
  

  describe "GET index" do
    it "assigns all rubrics as @rubrics" do
      rubric =  FactoryGirl.create :rubric
      get :index, {} 
      assigns(:rubrics).should eq([rubric])
    end
  end

  describe "GET show" do
    it "assigns the requested rubric as @rubric" do
      rubric =  FactoryGirl.create :rubric
      get :show, {:id => rubric.to_param} 
      assigns(:rubric).should eq(rubric)
    end
  end

  describe "GET new" do
    it "assigns a new rubric as @rubric" do
      get :new, {} 
      assigns(:rubric).should be_a_new(Rubric)
    end
  end

  describe "GET edit" do
    it "assigns the requested rubric as @rubric" do
      rubric =  FactoryGirl.create :rubric
      get :edit, {:id => rubric.to_param} 
      assigns(:rubric).should eq(rubric)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Rubric" do
        expect {
          post :create, {:rubric => valid_attributes} 
        }.to change(Rubric, :count).by(1)
      end

      it "assigns a newly created rubric as @rubric" do
        post :create, {:rubric => valid_attributes} 
        assigns(:rubric).should be_a(Rubric)
        assigns(:rubric).should be_persisted
      end

      it "redirects to the created rubric" do
        post :create, {:rubric => valid_attributes} 
        response.should redirect_to([:admin, Rubric.last])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved rubric as @rubric" do
        # Trigger the behavior that occurs when invalid params are submitted
        Rubric.any_instance.stub(:save).and_return(false)
        post :create, {:rubric => { "title" => "invalid value" }} 
        assigns(:rubric).should be_a_new(Rubric)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Rubric.any_instance.stub(:save).and_return(false)
        post :create, {:rubric => { "title" => "invalid value" }} 
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested rubric" do
        rubric =  FactoryGirl.create :rubric
        # Assuming there are no other rubrics in the database, this
        # specifies that the Rubric created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Rubric.any_instance.should_receive(:update).with({ "title" => "MyString" })
        put :update, {:id => rubric.to_param, :rubric => { "title" => "MyString" }} 
      end

      it "assigns the requested rubric as @rubric" do
        rubric =  FactoryGirl.create :rubric
        put :update, {:id => rubric.to_param, :rubric => valid_attributes} 
        assigns(:rubric).should eq(rubric)
      end

      it "redirects to the rubric" do
        rubric =  FactoryGirl.create :rubric
        put :update, {:id => rubric.to_param, :rubric => valid_attributes} 
        response.should redirect_to([:admin, rubric])
      end
    end

    describe "with invalid params" do
      it "assigns the rubric as @rubric" do
        rubric =  FactoryGirl.create :rubric
        # Trigger the behavior that occurs when invalid params are submitted
        Rubric.any_instance.stub(:save).and_return(false)
        put :update, {:id => rubric.to_param, :rubric => { "title" => "invalid value" }} 
        assigns(:rubric).should eq(rubric)
      end

      it "re-renders the 'edit' template" do
        rubric =  FactoryGirl.create :rubric
        # Trigger the behavior that occurs when invalid params are submitted
        Rubric.any_instance.stub(:save).and_return(false)
        put :update, {:id => rubric.to_param, :rubric => { "title" => "invalid value" }} 
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested rubric" do
      rubric =  FactoryGirl.create :rubric
      expect {
        delete :destroy, {:id => rubric.to_param} 
      }.to change(Rubric, :count).by(-1)
    end

    it "redirects to the rubrics list" do
      rubric =  FactoryGirl.create :rubric
      delete :destroy, {:id => rubric.to_param} 
      response.should redirect_to(admin_rubrics_url)
    end
  end

end
