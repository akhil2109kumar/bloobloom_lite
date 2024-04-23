class CreateShoppingBasket < ActiveRecord::Migration[7.0]
  def change
    create_table :shopping_baskets do |t|
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
