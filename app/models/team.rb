class Team < ActiveRecord::Base
  belongs_to :department
  has_and_belongs_to_many :users, join_table: 'teams_users'
  has_many :wishes
end
