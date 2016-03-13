class Wish < ActiveRecord::Base
  belongs_to :team
  belongs_to :department
end
