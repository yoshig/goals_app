require 'spec_helper'

feature "signup & authentication" do
  feature "signing up a user" do
    before(:each) { visit new_user_url }

    it "has a new user page" do
      expect(page).to have_content("Sign Up")
    end

    it "rejects user without username entered" do
      fill_in "Password", with: "password"
      click_button "Sign Up"
      expect(page).to have_content("Username can't be blank")
    end

    it "rejects user without password entered" do
      fill_in "Username", with: "username"
      click_button "Sign Up"
      expect(page).to have_content("Password is too short")
    end

    it "shows username on the homepage after signup" do
      sign_up("foo")
      expect(page).to have_content("foo")
    end
  end

  feature "logging in" do
    before(:each) { visit new_session_url }

    it "has a login page" do
      expect(page).to have_content("Sign In")
    end

    context "with an existing user" do
      before(:each) do
        User.create(:username => "foo", :password => "password")
      end

      it "rejects user without username entered" do
        fill_in "Password", with: "password"
        click_button "Sign In"
        expect(page).to have_content("No user found")
      end

      it "rejects user without password entered" do
        fill_in "Username", with: "foo"
        click_button "Sign In"
        expect(page).to have_content("No user found")
      end

      it "does not allow login for unregistered users" do
        fill_in "Username", with: "username"
        fill_in "Password", with: "totally_legit"
        click_button "Sign In"
        expect(page).to have_content("Sign In")
      end

      it "shows username on the homepage after signup" do
        sign_in("foo")
        expect(page).to have_content("foo")
      end
    end
  end

  feature "logging out" do
    it "begins in logged-out state" do
      visit new_session_url
      expect(page).to have_content "Sign In"
    end

    context "with an existing user" do
      before(:each) do
        visit new_user_url
        sign_up("foo")
      end

      it "doesn't show username on homepage after logout" do
        click_button "Sign Out"
        expect(page).not_to have_content("foo")
      end
    end
  end
end