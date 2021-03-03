require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    it 'ニックネームが必須であること' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'メールアドレスが必須であること' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'メールアドレスが一意性であること' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end
    it 'メールアドレスは、@を含む必要があること' do
      @user.email = 'aaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end
    it 'パスワードが必須であること' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'パスワードは、6文字以上での入力が必須であること（6文字が入力されていれば、登録が可能なこと）' do
      @user.password = '123a56'
      @user.password_confirmation = '123a56'
      expect(@user).to be_valid
    end
    it 'パスワードは、半角英数字混合での入力が必須であること（半角英数字が混合されていれば、登録が可能なこと）' do
      @user.password = '111111'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'パスワードは、確認用を含めて2回入力すること' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'パスワードとパスワード（確認用）は、値の一致が必須であること' do
      @user.password_confirmation = ' '
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'ユーザー本名は、名字が必須であること' do
      @user.name_family = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Name family can't be blank")
    end
    it 'ユーザー本名は、名前が必須であること' do
      @user.name_first = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Name first can't be blank")
    end
    it 'ユーザー本名は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      @user.name_first = 'ｱｲｳｴｵ'
      @user.valid?
      expect(@user.errors.full_messages).to include('Name first is invalid')
    end
    it 'ユーザー本名のフリガナは、名字が必須であること' do
      @user.name_family_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Name family kana can't be blank")
    end
    it 'ユーザー本名のフリガナは、名前が必須であること' do
      @user.name_first_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Name first kana can't be blank")
    end
    it 'ユーザー本名のフリガナは、全角（カタカナ）での入力が必須であること' do
      @user.name_first_kana = 'あいうえお'
      @user.valid?
      expect(@user.errors.full_messages).to include('Name first kana is invalid')
    end
    it '生年月日が必須であること' do
      @user.birth_day = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth day can't be blank")
    end
  end
end
