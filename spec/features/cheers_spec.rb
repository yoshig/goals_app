require 'spec_helper'

feature 'cheers' do
  before(:each) do
    prepare_two_users
  end

  feature 'adding cheers' do
    let(:test_goal) { Goal.find_by_title("foogoal1") }
    let(:test_goal2) { Goal.find_by_title("foogoal2") }

    it 'can add cheers to a goal' do
      click_button "cheer_goal#{test_goal.id}"
      expect(test_goal.karma).to eq(1)
    end

    it 'should not go over the cheers limit' do
      click_button "cheer_goal#{test_goal.id}"
      click_button "cheer_goal#{test_goal2.id}"
      expect(test_goal2.karma).to eq(0)
      expect(page).to have_content("Cheers limit reached")
    end

    it 'can\'t add cheers to own goals' do
      visit user_url(User.find_by_username("bar"))
      expect(page).not_to have_button("Cheer!")
    end

    it "can't add more than one cheer to a given goal" do
      click_button "cheer_goal#{test_goal.id}"
      expect(page).not_to have_button("cheer_goal#{test_goal.id}")
    end
  end

  feature 'leader board' do
    let(:test_goal) { Goal.find_by_title("foogoal1") }
    let(:test_goal2) { Goal.find_by_title("foogoal2") }

    it "only displays public goals" do
      visit user_url(User.find_by_username("bar"))
      add_goal("Private Goal")
      visit cheers_url
      expect(page).not_to have_content("Private Goal")
    end

    it "sorts goals by cheers and tied goals alphabetically" do
      visit cheers_url
      regex  = ""
      expect(page.body).to match(/foogoal1.*foogoal2/)
      visit user_url(User.find_by_username("foo"))
      click_button "cheer_goal#{test_goal2.id}"
      visit cheers_url
      expect(page.body).to match(/foogoal2.*foogoal1/)
    end
  end
end