class AddCompanyRefToTeams < ActiveRecord::Migration
  def change
    add_reference :teams, :company, index: true, foreign_key: true
  end
end
