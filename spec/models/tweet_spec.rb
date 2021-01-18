require 'rails_helper'

RSpec.describe Tweet, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @tweet = FactoryBot.build(:tweet, user_id: @user.id)
  end


  context '投稿ができる場合' do
   it "正しく入力されていれば登録ができる"do
    expect(@tweet).to be_valid
   end    
  end

  context '投稿ができばい場合' do
    it "タイトルが入力されていない場合投稿ができない" do
     @tweet.title = nil
     @tweet.valid?
     expect(@tweet.errors.full_messages).to include("タイトルを入力してください")
    end
    it "本文が入力されていない場合投稿ができない" do
     @tweet.context = nil
     @tweet.valid?
     expect(@tweet.errors.full_messages).to include("本文を入力してください")
    end
    it "ユーザーが紐づいていない場合投稿ができない" do
      @tweet.user = nil
      @tweet.valid?
      expect(@tweet.errors.full_messages).to include("Userを入力してください", "Userを入力してください")
        
    end

  end
end
