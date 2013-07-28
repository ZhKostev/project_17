require "spec_helper"

describe RubricsController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/rubrics").should route_to("admin_rubrics#index")
    end

    it "routes to #new" do
      get("/admin/rubrics/new").should route_to("admin_rubrics#new")
    end

    it "routes to #show" do
      get("/admin/rubrics/1").should route_to("admin_rubrics#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/rubrics/1/edit").should route_to("admin_rubrics#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/rubrics").should route_to("admin_rubrics#create")
    end

    it "routes to #update" do
      put("/admin/rubrics/1").should route_to("admin_rubrics#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/rubrics/1").should route_to("admin_rubrics#destroy", :id => "1")
    end

  end
end
