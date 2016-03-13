class Company < ActiveRecord::Base
  has_many :users

  has_many :departments
  has_many :teams,  through: :departments
  has_many :wishes, through: :departments

  validates_presence_of :name
  validates_uniqueness_of :name
end
