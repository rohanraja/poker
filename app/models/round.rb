class Round < ActiveRecord::Base
	has_many :line_items
	has_many :players , :through => :line_items
end
