class User < ActiveRecord::Base
  rolify
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, if: :new_user?
  belongs_to :profile, polymorphic: true

  private
  def new_user?
    new_record?
  end
end
