require 'rails_helper'

RSpec.describe User, type: :model do
    before do
      @user = FactoryBot.build(:user)
  
    end
    

    context 'ユーザー登録ができる場合' do
      it "全ての情報が正しく入力すると、登録ができる"do
      expect(@user).to be_valid 
    end
    end

    context 'ユーザー登録ができない場合'do
    it "名前が空の場合は登録ができない" do
      @user.name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("名前を入力してください")
      
    end
    it "メールアドレスが空の場合は登録ができない" do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("メールアドレスを入力してください")
      
    end
    it "メールアドレスに＠がない場合は登録ができない" do
      @user.email = "123adc"
      @user.valid?
      expect(@user.errors.full_messages).to include("メールアドレスは不正な値です")
      
    end
    it "同じメールアドレスが存在する場合は登録する事ができない" do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include("メールアドレスはすでに存在します")
    end
    it "パスワードが入力されていない場合は登録ができない" do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードを入力してください")
      
    end
    it "パスワードが５文字以下の場合は登録ができない" do
      @user.password = "12345"
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません", "パスワードは6文字以上で入力してください")
      
    end
    it "パスワードとパスワード再入力が不一致の場合登録ができない" do

      @user.password = "123456"
      @user.password_confirmation = "1234567"
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      
    end

  end
end
