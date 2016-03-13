class Department < ActiveRecord::Base
  belongs_to :company
  has_many :teams
  has_many :wishes
end
