# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

require 'selenium-webdriver'



require 'spree/testing_support/factories'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"


  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  config.include FactoryBot::Syntax::Methods  
  
end


# Capybaraに、remote_chromeという名前のdriverを登録する
Capybara.register_driver :remote_chrome do |app|
  options = {
    browser: :remote,
    # remote browserが動作しているurlを指定
    # 今回は`chrome`という名前で`docker-compose.yml`に登録したのでhost名は`chrome`
    url: 'http://chrome:4444/wd/hub',
    capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
      # 各設定はここを参照: https://peter.sh/experiments/chromium-command-line-switches/
      'goog:chromeOptions': {
        args: %w[
          headless
          disable-gpu
          window-size=1400,2000
          no-sandbox
        ]
      }
    )
  }

  Capybara::Selenium::Driver.new(app, options)
end

# javascript_driverに上で登録したremote_chromeを指定する
Capybara.javascript_driver = :remote_chrome

# Capybaraはtestのためにサーバーを起動する。rails-rspecを用いているなら、railsが起動する。
# 以下のコマンドが実行されるイメージ
# rails s -b {Capybara.server_host} -p {Capybara.server_port}
# `Capybara.server_host`にサーバーが起動するhostを指定する。別のホストのブラウザからアクセス可能にするため、`0.0.0.0`を指定する。
# `Capybara.server_port`にサーバーがlistenするportを指定する。portを指定しないとランダムなポートで起動するので適当な値を指定する必要がある。
# ref: https://github.com/teamcapybara/capybara/blob/a5b5a04d81e1138d6904e33ac176227d04aacce9/lib/capybara.rb#L98-L99
Capybara.server_host = '0.0.0.0'
Capybara.server_port = '9999'

# `Capybara.app_host`に`chrome`コンテナで動作するブラウザにアクセスしてほしいurlを指定する
# Capybaraが立ち上げるサーバーのURLを指定すれば良い。ただし、`chrome`コンテナが解決できるようなurlを指定する必要がある。
# `visit`メソッドに相対パスが渡された時、この値がbase urlになる。
# つまり、`visit('/hoge')` = `visit("#{Capybara.app_host}/hoge")`
# ref: https://www.rubydoc.info/gems/capybara/Capybara%2FSession:visit
# `IPSocket.getaddress(Socket.gethostname)`は自身のipアドレスを返す。
# ref: https://github.com/teamcapybara/capybara/blob/a5b5a04d81e1138d6904e33ac176227d04aacce9/lib/capybara.rb#L75
Capybara.app_host = "http://#{IPSocket.getaddress(Socket.gethostname)}:#{Capybara.server_port}"
