require 'spec_helper'

feature "comments" do
  before(:each) do
    prepare_two_users
  end

  feature "commenting on goals" do
    it "can comment on a goal" do
      fill_in "comment_text_Goal#{Goal.find_by_title("foogoal1").id}",
        with: "this is a comment on a goal"
      click_button "submit_comment_Goal#{Goal.find_by_title("foogoal1").id}"
      expect(page).to have_content("this is a comment on a goal")
      expect(Goal.find_by_title("foogoal1").comments.count).to eq(1)
    end
  end

  feature "commenting on users" do
    it "can comment on a user" do
      fill_in "comment_text_User#{User.find_by_username("foo").id}",
        with: "this is a comment on a user"
      click_button "submit_comment_User#{User.find_by_username("foo").id}"
      expect(page).to have_content("this is a comment on a user")
      expect(User.find_by_username("foo").comments.count).to eq(1)
    end
  end
end