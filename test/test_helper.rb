ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'capybara/rails'
require 'selenium/webdriver'

Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    url: 'http://selenium:4444/wd/hub',
    desired_capabilities: :chrome
  )
end

Capybara.javascript_driver = :selenium_chrome

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400], options: {
    url: "http://selenium:4444/wd/hub",
    desired_capabilities: :chrome
  }
end