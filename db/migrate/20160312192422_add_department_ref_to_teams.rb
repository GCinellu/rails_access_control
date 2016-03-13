class AddDepartmentRefToTeams < ActiveRecord::Migration
  def change
    add_reference :teams, :department, index: true, foreign_key: true
  end
end
