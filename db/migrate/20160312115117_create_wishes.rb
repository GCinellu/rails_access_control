class CreateWishes < ActiveRecord::Migration
  def change
    create_table :wishes do |t|
      t.belongs_to :team, index: true, foreign_key: true
      t.string :title
      t.text :description
      t.integer :impact_on_business
      t.integer :time_required
      t.integer :ease_of_development
      t.timestamp :deadline

      t.timestamps null: false
    end
  end
end
