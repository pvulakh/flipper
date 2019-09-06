require 'rails_helper'

feature 'creating a flip', type: :feature do 
  before :each do 
    create(:user)
    log_in_user(User.last)
  end 

  scenario "takes a body" do 
    visit new_flip_url 
    # save_and_open_page 
    expect(page).to have_content "new flip alert!"
    expect(page).to have_content "Body"
  end 

  scenario "takes us back to flip show" do 
    flip_it("body")
    expect(page).to have_content("best flippin flip")
    expect(page).to have_content("body")
  end
end 

feature 'deflipping a flip', type: :feature do 
  before :each do 
    create(:user)
    log_in_user(User.last)
    flip_it("to be deleted")
    click_button("bye bye flip")
  end 

  scenario "deflips a flip" do 
    expect(page).to_not have_content("to be deleted")
    expect(page).to have_content("all flips")
  end 
end 