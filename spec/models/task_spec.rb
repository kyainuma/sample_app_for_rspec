require 'rails_helper'

RSpec.describe Task, type: :model do
#  pending "add some examples to (or delete) #{__FILE__}"

  describe 'validation' do
    it 'すべてのバリデーションが有効であること' do
      user = create(:user)
      task = build(:task)
      expect(task).to be_valid
      expect(task.errors).to be_empty
    end

    it 'タイトルが空白だと無効であること' do
      task = build(:task, title: '')
      expect(task).to_not be_valid
      expect(task_without_title.errors[:title]).to eq ["can't be blank"]
    end

    it 'ステータスが未登録だと無効であること' do
      task = build(:task, status: '')
      expect(task).to_not be_valid
      expect(task_without_status.errors[:status]).to eq ["can't be blank"]
    end

    it 'タイトルが重複している場合は無効であること' do
      task1 = create(:task, title: 'test')
      task2 = build(:task, title: 'test')
      expect(task2).to_not be_valid
      expect(task_with_duplicated_title.errors[:title]).to eq ["has already been taken"]
    end

    it 'タイトルが重複していない場合は有効であること' do
      task1 = create(:task, title: 'test1')
      task2 = build(:task, title: 'test2')
      expect(task2).to be_valid
      expect(task_with_another_title.errors).to be_empty
    end
  end
end
