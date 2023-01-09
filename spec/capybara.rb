require 'capybara/rspec'
require 'selenium-webdriver'

Capybara.register_driver :remote_firefox do |app|
  # ブラウザの指定、
  # リモートサーバのURLの指定などもできるが今回は省略
  # なにも指定しないとFirefox、ローカルホストを指す
  Capybara::Selenium::Driver.new(app, {browser: :remote})
end

Capybara.default_driver = :remote_firefox
Capybara.app_host = 'http://www.google.co.jp'

RSpec.configure do |config|
  config.include Capybara::DSL
end

describe "google" do

  before do
    visit '/'
  end

  context "トップページ" do
    it { expect(page).to have_content('Google') }
  end
end
