class ShiftCollection
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  include ActiveModel::AttributeMethods
  include ActiveModel::Validations
  USER_NUM = 5  # 同時にユーザーを作成する数
  attr_accessor :collection # ここに格納される

  # 初期化メソッド
  def initialize(attributes = [])
    if attributes.present?
      self.collection = attributes.map do |value|
        Shift.new(
          date: value['date'],
          shift_in: value['shift_in'],
          shift_out: value['shift_out'],
          user_id: value['user_id']
        )
      end
    else
      self.collection = USER_NUM.times.map{ Shift.new }
    end
  end

  # レコードが存在するか確認するメソッド
  def persisted?
    false
  end

  def save
    is_success = true
    ActiveRecord::Base.transaction do
      collection.each do |result|
        # バリデーションを全てかけたいからsave!ではなくsaveを使用
        is_success = false unless result.save
      end
      # バリデーションエラーがあった時は例外を発生させてロールバックさせる
      raise ActiveRecord::RecordInvalid unless is_success
    end
    rescue
      p 'エラー'
    ensure
      return is_success
  end


end