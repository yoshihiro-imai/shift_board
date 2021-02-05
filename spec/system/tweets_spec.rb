require 'rails_helper'

def basic_pass(path) 
  username = ENV["BASIC_AUTH_USER"]
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end


RSpec.describe '掲示板投稿', type: :system do
  before do
    @tweet = FactoryBot.build(:tweet)
    @user = FactoryBot.create(:user)
    @tweet_title = Faker::Lorem.sentence
    @tweet_context = Faker::Lorem.sentence
    
  end
  context 'ツイート投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      basic_pass root_path
      # ログインする
      visit new_user_session_path
      fill_in "メールアドレス" , with: @user.email
      fill_in "パスワード" , with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 掲示板投稿ページへのリンクがあることを確認する
      expect(page).to have_content('掲示板投稿')
      # 投稿ページに移動する
      visit new_tweet_path
      # フォームに情報を入力する
      fill_in 'tweet_title' ,with: @tweet_title
      fill_in 'tweet_context' ,with: @tweet_context
      # 送信するとTweetモデルのカウントが1上がることを確認する
      expect{
        find('input[name= "commit"]').click
      }.to change { Tweet.count}.by(1)
      # トップページに遷移する
      visit root_path
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（タイトル）
      expect(page).to have_content(@tweet_title)
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（画像）
      expect(page).to have_content(@tweet_image)
    end
  end
  context 'ツイート投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      basic_pass root_path
      # 新規投稿ページへのリンクがない
      expect(page).to have_no_content('掲示板投稿')
    end
  end
end