require_relative './useful'
class Figure <ActiveRecord::Base
  has_many :landmarks
  has_many :figure_titles
  has_many :titles, through: :figure_titles
  extend  Useful::ClassMethods
  include Useful::InstanceMethods
end
