class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 } #名前は空を許さず50字以内
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false } #メアドは正しい配列かどうか
  has_secure_password #パスワード設定用のやつ
  
  has_many :tasks
end