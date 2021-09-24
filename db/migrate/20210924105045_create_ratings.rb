class CreateRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :ratings do |t|
      t.integer :rating_value
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
