require_relative './useful'
class Title <ActiveRecord::Base
  has_many :figure_titles
  has_many :figures, through: :figure_titles
  extend  Useful::ClassMethods
  include Useful::InstanceMethods
end
