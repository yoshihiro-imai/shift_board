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

  RSpec.describe 'ツイート編集', type: :system do
    before do
      @tweet1 = FactoryBot.create(:tweet)
      @tweet2 = FactoryBot.create(:tweet)
    end
    context 'ツイート編集ができるとき' do
      it 'ログインしたユーザーは自分が投稿したツイートの編集ができる' do
        basic_pass root_path

        # ツイート1を投稿したユーザーでログインする
        visit new_user_session_path
        fill_in 'メールアドレス', with:@tweet1.user.email
        fill_in 'パスワード', with: @tweet1.user.password
        find('input[name="commit"]').click
        expect(current_path).to eq(root_path)
         # ツイート1に「編集」ボタンがあることを確認する
         visit tweet_path(@tweet1)
    expect(
      all('.show')[0].hover
    ).to have_link '編集', href: edit_tweet_path(@tweet1)  
        # 編集ページへ遷移する
        visit edit_tweet_path(@tweet1)
        # すでに投稿済みの内容がフォームに入っていることを確認する
        expect(
          find('#tweet_title').value
        ).to eq(@tweet1.title)
        expect(
          find('#tweet_context').value
        ).to eq(@tweet1.context)
        # 投稿内容を編集する
        fill_in 'tweet_title', with: "#{@tweet1.title}+編集したタイトル"
        fill_in 'tweet_context', with: "#{@tweet1.context}+編集したテキスト"
        # 編集してもTweetモデルのカウントは変わらないことを確認する
        expect{
          find('input[name="commit"]').click
      }.to change{Tweet.count}.by(0)
        # 編集完了画面に遷移したことを確認する
        expect(current_path).to eq(tweet_path(@tweet1))
        # 「更新が完了しました」の文字があることを確認する
        expect(page).to have_content('更新が完了しました')
        # トップページに遷移する
        visit root_path
        # 先ほど変更した内容のツイートが存在することを確認する（テキスト）
        visit tweet_path(@tweet1)
        expect(page).to have_content("#{@tweet1.title}+編集したタイトル")
      end
    end
    
    context 'ツイート編集画できない時' do
    it 'ログインしたユーザーは自分以外が投稿したツイートの編集画面には遷移できない' do
      # ツイート1を投稿したユーザーでログインする
      basic_pass root_path
      visit new_user_session_path
      fill_in 'メールアドレス', with:@tweet1.user.email
      fill_in 'パスワード', with: @tweet1.user.password
      find('input[name="commit"]').click
      visit tweet_path(@tweet2)
      expect(
        all('.show')[0].hover
      ).to have_no_link '編集', href: edit_tweet_path(@tweet2)
    end
  end
end