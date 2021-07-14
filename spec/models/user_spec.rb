require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it 'name,email,password,password_confirmationが揃っていれば登録できる' do
        expect(@user).to be_valid
      end
      it 'pictureは空でも登録できる' do
        @user.picture = ''
        expect(@user).to be_valid
      end
      it 'introduceは空でも登録できる' do
        @user.introduce = ''
        expect(@user).to be_valid
      end
    end
    context '新規登録がうまくいかないとき' do
      it 'nameが空だと登録できない' do
        @user.name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('名前が入力されていません。')
      end
      it 'passwordが空だと登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードが入力されていません。')
      end
      it 'passwordが空だと登録できない' do
        @user.password = 'aaaa1'
        @user.password_confirmation = 'aaaa1'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上に設定して下さい。')
      end
      it 'password_confirmationが空だと登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認）とパスワードの入力が一致しません')
      end
      it 'passwordとpassword_confirmationが一致しないと登録できない' do
        @user.password = 'aaaa11'
        @user.password_confirmation = 'aaaa12'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認）とパスワードの入力が一致しません')
      end
      it 'passwordに数字が1文字以上含まれていないと登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは有効でありません。')
      end
      it 'passwordに英字が1文字以上含まれていないと登録できない' do
        @user.password = '111111'
        @user.password_confirmation = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは有効でありません。')
      end
      it 'emailは@が含まれていないと登録できない' do
        @user.email = 'fooexample.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('メールアドレスは有効でありません。')
      end
      it 'emailは@が文字列間に含まれていないと登録できない' do
        @user.email = 'fooexample.com@'
        @user.valid?
        expect(@user.errors.full_messages).to include('メールアドレスは有効でありません。')
      end
      it 'emailはすでに登録されている場合、同じものを登録できない' do
        @user.save
        user2 = FactoryBot.build(:user, email: @user.email)
        user2.valid?
        expect(user2.errors.full_messages).to include('メールアドレスは既に使用されています。')
      end
    end
  end
end
