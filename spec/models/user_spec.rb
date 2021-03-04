require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end
    context '新規登録ができる時' do
      it 'パスワードは、6文字以上での入力が必須であること（6文字が入力されていれば、登録が可能なこと）' do
        @user.password = '123a56'
        @user.password_confirmation = '123a56'
        expect(@user).to be_valid
      end
      it 'ユーザー本名は、全角（漢字）での入力が必須であること' do
        @user.name_first = '山田'
        expect(@user).to be_valid
      end
      it 'ユーザー本名は、全角（ひらがな）での入力が必須であること' do
        @user.name_first = 'やまだ'
        expect(@user).to be_valid
      end
      it 'ユーザー本名は、全角（カタカナ）での入力が必須であること' do
        @user.name_first = 'ヤマダ'
        expect(@user).to be_valid
      end
      it 'ユーザー本名のフリガナは、全角（カタカナ）での入力が必須であること' do
        @user.name_first = 'ヤマダ'
        expect(@user).to be_valid
      end

    context '新規登録ができない時' do
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
      it 'パスワードは、英字のみでは登録できないこと' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'パスワードは、数字のみでは登録できないこと' do
        @user.password = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'パスワードは、全角では登録できないこと' do
        @user.password = '１１１ａａａ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
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
      it 'ユーザー本名は、半角では入力できないこと' do
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
      it 'ユーザー本名のフリガナは、全角（カタカナ）以外では入力できないこと' do
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
end
