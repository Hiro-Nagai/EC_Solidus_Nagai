
require 'selenium-webdriver'

# リモートサーバを指定
driver = Selenium::WebDriver.for :remote

# Googleにアクセス
driver.navigate.to "http://www.google.co.jp"

# HTMLのソースを取得
puts driver.page_source
# HTMLページの操作・解析をごにょごにょ

driver.quit
