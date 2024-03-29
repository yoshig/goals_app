# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end

def sign_up(username)
  fill_in "Username", with: username
  fill_in "Password", with: "password"
  click_button "Sign Up"
end

def sign_in(username)
  fill_in "Username", with: username
  fill_in "Password", with: "password"
  click_button "Sign In"
end

def add_goal(title)
  fill_in "Title", with: title
  click_button "Add Goal"
end

def add_public_goal(title)
  fill_in "Title", with: title
  check "Public?"
  click_button "Add Goal"
end

def switch_user(new_username)
  click_button("Sign Out")
  visit new_user_url
  sign_up(new_username)
end

def prepare_two_users
  visit new_user_url
  sign_up("foo")
  add_public_goal("foogoal1")
  add_public_goal("foogoal2")
  click_button("Sign Out")
  visit new_user_url
  sign_up("bar")
  add_public_goal("bargoal1")
  add_public_goal("bargoal2")
  visit user_url(User.find_by_username("foo"))
end
