class Event < ApplicationRecord
  belongs_to :owner, class_name: "User"

  validates :name, length: { maximum: 50 }, presence: true
  validates :place, length: { maximum: 100 }, presence: true
  validates :content, length: { maximum: 2000 }, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true
  validate :start_at_shoud_be_before_end_at

  def created_by?(user)
    # userがfalseならばfalseを返す
    return false unless user
    # userがtrue、かつowner_idとuser.idが同じならtrueを返す
    # userがtrue、かつowner_idとuser.idが違えばfalseを返す
    owner_id == user.id
  end

  private

  def start_at_shoud_be_before_end_at
    return unless start_at && end_at

    if start_at > end_at
      errors.add(:start_at, "は終了時刻よりも早く設定してください")
    end
  end
end
