class Landmark <ActiveRecord::Base
  belongs_to :figure
  attr_accessor :year_completed
  binding.pry
end
