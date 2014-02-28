require 'spec_helper'

feature "goal tracking" do
  #Log in, get to user's show page
  before(:each) do
    visit new_user_url
    sign_up("foo")
  end

  feature "creating goals" do
    let(:current_user) { User.find_by_username("foo") }

    it "doesn't create goals without a title" do
      click_button "Add Goal"
      expect(page).to have_content("Title can't be blank")
    end

    it "shows new goals upon creation" do
      add_goal("Be Awesome")
      expect(current_user.goals.first.title).to eq("Be Awesome")
    end

    it "starts goals as uncompleted" do
      add_goal("Be Awesome")
      expect(page).to have_content("In Progress")
      expect(page).to have_button("Complete")
      expect(page).not_to have_content("Completed")
    end

    it "starts goals as private" do
      add_goal("Be Awesome")
      expect(page).to have_content("Private")
      expect(page).to have_button("Make Public")
    end

    it "can complete goals" do
      add_goal("Be Awesome")
      click_button("Complete")
      expect(page).to have_content("Completed")
      expect(page).not_to have_content("In Progress")
      expect(page).to have_button("Uncomplete")
    end

    it "can make goals public" do
      add_goal("Be Awesome")
      click_button("Make Public")
      expect(page).to have_content("Public")
      expect(page).to have_button("Make Private")
    end

    it "can uncomplete goals" do
      add_goal("Be Awesome")
      click_button("Complete")
      click_button("Uncomplete")
      expect(page).to have_content("In Progress")
      expect(page).to have_button("Complete")
      expect(page).not_to have_content("Completed")
    end

    it "can make goals public" do
      add_goal("Be Awesome")
      click_button("Make Public")
      click_button("Make Private")
      expect(page).to have_content("Private")
      expect(page).to have_button("Make Public")
    end

    it "can have multiple goals" do
      add_goal("Be Awesome")
      add_goal("Have Multiple Goals")
      expect(page).to have_content("Be Awesome")
      expect(page).to have_content("Have Multiple Goals")
    end
  end

  feature "viewing others' goals" do
    before(:each) do
      add_goal("Be Awesome")
      click_button("Make Public")
      add_goal("Be Private")
      switch_user("bar")
      visit user_url(User.find_by_username("foo"))
    end

    let(:current_user) { User.find_by_username("bar") }

    it "can view others' public goals" do
      expect(page).to have_content("Be Awesome")
    end

    it "can't view others' private goals" do
      expect(page).not_to have_content("Be Private")
    end

    it "can't create goals on others' pages" do
      expect(page).not_to have_button("Add Goal")
    end

    it "can't affect status of goals on others' pages" do
      expect(page).not_to have_button("Make Private")
      expect(page).not_to have_button("Make Public")
      expect(page).not_to have_button("Complete")
      expect(page).not_to have_button("Uncomplete")
    end

    it "can't see own goals on others' pages" do
      visit user_url(current_user)
      add_goal("Be Yourself")
      visit user_url(User.find_by_username("foo"))
      expect(page).not_to have_content("Be Yourself")
    end
  end
end






































