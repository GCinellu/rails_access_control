class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.belongs_to :company, index: true, foreign_key: true
      t.string :name
      t.text :description
      t.float :credit

      t.timestamps null: false
    end
  end
end
