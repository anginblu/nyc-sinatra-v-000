require_relative './useful'

class FigureTitle <ActiveRecord::Base
  belongs_to :figure
  belongs_to :title
  extend  Useful::ClassMethods
  include Useful::InstanceMethods
end
