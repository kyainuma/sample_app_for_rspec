RSpec.configure do |config|
  config.before(:each, type: :system) do
    # テスト実行時にブラウザが起動されます。byebugやsleepで停止して画面の要素を確認できます。
    # driven_by(:selenium_chrome)
    driven_by(:selenium_chrome_headless)
  end
end
