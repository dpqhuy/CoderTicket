require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  	describe "POST create" do
	  context "with invalid attributes" do
	    it "creates a new user" do
	      expect{
	        xhr :post, :create, user: FactoryGirl.attributes_for(:user)
	      }.to change(User,:count).by(0)
	    end
	  end
	    
	end

end
