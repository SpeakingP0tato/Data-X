# README

 環境設定
Ruby: 3.4.2
Rails: 8.0.1
Node.js: 22.14.0
Vue.js: 3.5.12

ユーザー認証機能
Devise を使用し、ユーザー登録・ログイン・ログアウト機能を実装
ログイン成功・失敗時に Flashメッセージを表示
ログイン後 トップページにリダイレクト処理（成功時に root_path へ移動）

テストコードの作成
RSpec を使用したユーザーログインに関する システムテストコード作成
Capybara を利用したブラウザテストを実施

現在発生している問題
ログイン成功・失敗時の Flash メッセージが正しく表示されない

expect(page).to have_xpath("//div[contains(@class, 'alert')]", text: 'ログインに成功しました') が失敗
実際の HTML を確認すると、Flash メッセージが存在しない、または Turbo 関連の問題が原因の可能性あり
ログイン後のページリダイレクトが正しく動作しない

expect(page).to have_current_path(root_path, ignore_query: true) が失敗
ログイン後も /users/sign_in ページに留まってしまう
Selenium WebDriver のセッション競合エラーが発生

SessionNotCreatedError: probably user data directory is already in use エラー発生
--user-data-dir オプションを使用して解決を試みたが、完全には解決できていない
