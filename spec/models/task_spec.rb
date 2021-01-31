require 'rails_helper'

RSpec.describe Task, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
require 'rails_helper'

RSpec.describe Task, type: :model do
  before do
    @project = FactoryBot.create(:project)
    @task = FactoryBot.build(:task, project_id: @project.id)
  end


  context '投稿ができる場合' do
   it "正しく入力されていれば登録ができる"do
    expect(@task).to be_valid
   end    
  end

  context '投稿ができない場合' do
    it "日付が入力されていない場合投稿ができない" do
     @task.start_time = nil
     @task.valid?
     expect(@task.errors.full_messages).to include("Start timeを入力してください")
    end
    it "入り時間がない場合投稿ができない" do
     @task.intime = nil
     @task.valid?
     expect(@task.errors.full_messages).to include("Intimeを入力してください")
    end
    it "名前の入力がない場合投稿ができない" do
      @task.project_id = nil
      @task.valid?
      expect(@task.errors.full_messages).to include("Projectを入力してください")
        
    end
    it "終了時間の入力が場合投稿ができない" do
      @task.outtime = nil
      @task.valid?
      expect(@task.errors.full_messages).to include("Outtimeを入力してください")
        
    end

    it "終了時間が入り時間よりも早い時間の場合投稿ができない" do
      @task.intime = "2021-01-31 12:00:00"
      @task.outtime = "2021-01-31 10:00:00"
      @task.valid?
      expect(@task.errors.full_messages).to include("Outtimeの日付を正しく記入してください。")  
    end
    
    it "日付が同じ日がある場合投稿ができない" do
      @task.save
      another_user = FactoryBot.build(:task, project_id: @task.project_id)
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Start timeはすでに存在します")  
    end
  end
end
