class Customer < ActiveRecord::Base
  acts_as_profile
  accepts_nested_attributes_for :user

  validates :username, :presence => true, :uniqueness => { :case_sensitive => false }
end
