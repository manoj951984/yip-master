class Business < ActiveRecord::Base
  acts_as_profile
  accepts_nested_attributes_for :user
  
  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :photo, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]  
  validates :phone,:presence => true,
                 :numericality => true,
                 :length => { :minimum => 10, :maximum => 15 }
end
