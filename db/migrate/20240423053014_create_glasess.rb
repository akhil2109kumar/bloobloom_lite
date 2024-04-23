class CreateGlasess < ActiveRecord::Migration[7.0]
  def change
    create_table :glasses do |t|
      t.references :frame, null: false, foreign_key: true
      t.references :shopping_basket, null: false, foreign_key: true
      t.integer :lens_id, null: false

      t.timestamps
    end
    add_foreign_key :glasses, :lenses, column: :lens_id
  end
end
