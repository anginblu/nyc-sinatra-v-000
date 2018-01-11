require_relative './useful'
class Landmark <ActiveRecord::Base
  belongs_to :figure
  extend  Useful::ClassMethods
  include Useful::InstanceMethods
end
