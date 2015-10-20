class ActiveRecord::Base
  def self.acts_as_profile
    include Profile
  end
end