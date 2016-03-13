class AddDepartmentRefToWishes < ActiveRecord::Migration
  def change
    add_reference :wishes, :department, index: true, foreign_key: true
  end
end
