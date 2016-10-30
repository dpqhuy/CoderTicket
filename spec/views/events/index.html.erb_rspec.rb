require 'rails_helper'

RSpec.describe "events/index.html.erb", type: :view do
  	scenario 'Visit the root page' do
		visit root_path
   		expect(page).to have_content 'Sign In'
 	end
end


