require 'rails_helper'

RSpec.describe User, type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  describe 'ログイン前' do
    describe 'ユーザー新規作成' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの新規作成が完了する' do
          # ユーザー新規作成画面を開く
          visit sign_up_path
          
          # Emailテキストフィールドにtest@example.comと入力
          fill_in 'Email', with: 'test@example.com'

          # Passwordテキストフィールドにpasswordと入力
          fill_in 'Password', with: 'password'

          # Password confirmationテキストフィールドにpasswordと入力
          fill_in 'Password confirmation', with: 'password'

          # SignUpと記載のあるsubmitボタンをクリックする
          click_button 'SignUp'

          # login_pathへ遷移することを期待する
          expect(current_path).to eq login_path

          # 遷移後のページの期待表示文字列
          expect(page).to have_content 'User was successfully created.'
        end  
      end
      context 'メールアドレスが未入力' do
        it 'ユーザーの新規作成が失敗する' do
          visit sign_up_path
          fill_in 'Email', with: ''
          fill_in 'Password', with: 'password'
          fill_in 'Password confirmation', with: 'password'
          click_button 'SignUp'
          expect(current_path).to eq users_path
          expect(page).to have_content "Email can't be blank"
        end
      end
      context '登録済みのメールアドレスを使用' do
        it 'ユーザーの新規作成が失敗する' do
          visit sign_up_path
          fill_in 'Email', with: user.email
          fill_in 'Password', with: 'password'
          fill_in 'Password confirmation', with: 'password'
          click_button 'SignUp'
          expect(current_path).to eq users_path
          expect(page).to have_content "Email has already been taken"
        end
      end
    end

  describe 'マイページ' do
    context 'ログインしていない状態'
      it 'マイページへのアクセスが失敗する' do
        visit user_path(user)
        expect(current_path).to eq login_path
        expect(page).to have_content 'Login required'
      end
    end
  end

  describe 'ログイン後' do
    before { login(user) }
    describe 'ユーザー編集' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの編集が成功する' do
          visit edit_user_path(user)
          fill_in 'Email', with: 'test@example.com'
          fill_in 'Password', with: 'test'
          fill_in 'Password confirmation', with: 'test'
          click_button 'Update'
          expect(current_path).to eq user_path(user)
          expect(page).to have_content 'User was successfully updated.'
        end
      end

      context 'メールアドレスが未入力' do
        it 'ユーザーの編集が失敗する' do
          visit edit_user_path(user)
          fill_in 'Email', with: ''
          fill_in 'Password', with: 'test'
          fill_in 'Password confirmation', with: 'test'
          click_button 'Update'
          expect(current_path).to eq user_path(user)
          expect(page).to have_content "Email can't be blank"
        end
      end

      context '登録済みのメールアドレスを使用' do
        it 'ユーザーの編集が失敗する' do
          visit edit_user_path(user)
          fill_in 'Email', with: other_user.email
          fill_in 'Password', with: 'test'
          fill_in 'Password confirmation', with: 'test'
          click_button 'Update'
          expect(current_path).to eq user_path(user)
          expect(page).to have_content 'Email has already been taken'
        end
      end

      context '他ユーザーの編集ページにアクセスする' do
        it '編集ページへのアクセスが失敗する' do
          visit edit_user_path(other_user)
          expect(current_path).to eq user_path(user)
          expect(page).to have_content 'Forbidden access.'
        end
      end
    end
  end
end
