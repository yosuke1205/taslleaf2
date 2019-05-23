require 'rails_helper'

describe 'タスク管理機能', type: :system do
    describe '一覧表示機能' do
        before do
          user_a = FactoryBot.create(:user)
          FactoryBot.create(:task, name: '最初のタスク', user: user_a)
            end
    context 'ユーザAがログインしている時' do
        before do
        visit login_path
        fill_in 'メールアドレス', with: 'a@example.com'
        click_buttom 'ログインする'

        end

        it 'ゆーざーAが作詞したタスクが表示される' do
        expect(page).to have_content'最初のタスク'
        end
    end
end
end