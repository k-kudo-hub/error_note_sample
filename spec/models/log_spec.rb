require 'rails_helper'

RSpec.describe Log, type: :model do
  before do
    @log = FactoryBot.build(:log)
  end

  describe 'ノート新規作成' do
    context '新規作成が成功するとき' do
      it 'user_id, title, error, solution, releaseが揃っていれば登録できる' do
        expect(@log).to be_valid
      end
      it 'solutionは空でも登録できる' do
        @log.solution = ""
        expect(@log).to be_valid
      end
      it 'releaseが不正な値だった場合、trueとして登録される' do
        @log.release = "aaa"
        expect(@log).to be_valid
      end
    end
    context '新規作成が失敗するとき' do
      it 'titleが空だと登録できない' do
        @log.title = nil
        @log.valid?
        expect(@log.errors.full_messages).to include('タイトルが入力されていません。')
      end
      it 'errorが空だと登録できない' do
        @log.error = nil
        @log.valid?
        expect(@log.errors.full_messages).to include('エラーの内容が入力されていません。')
      end
      it 'releaseが空だと登録できない' do
        @log.release = nil
        @log.valid?
        expect(@log.errors.full_messages).to include('公開状態は一覧にありません')
      end
    end
  end
end
