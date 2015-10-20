module Profile

  def self.included(base)
    base.has_one :user, :as => :profile, :autosave => true, :dependent => :destroy
    #base.alias_method_chain :user, :autobuild
    base.extend ClassMethods
    base.define_profile_properties_accessors
  end

  def method_missing(meth, *args, &blk)
    User.send(meth, *args, &blk)
  rescue NoMethodError
    super
  end

  module ClassMethods
    def define_profile_properties_accessors
      all_attributes = User.content_columns.map(&:name)
      ignored_attributes = ["created_at", "updated_at", "profile_type"]
      attributes_to_delegate = all_attributes - ignored_attributes
      attributes_to_delegate.each do |attrib|
        class_eval <<-RUBY
          def #{attrib}
            self.user.#{attrib}
          end

          def #{attrib}=(value)
            self.user.#{attrib} = value
          end

          def #{attrib}?
            self.user.#{attrib}?
          end
        RUBY
      end
    end
  end

  protected

  def profile_properties_must_be_valid
    unless profile_properties.valid?
      profile_properties.errors.each do |attr, message|
        errors.add(attr, message)
      end
    end
  end

end
