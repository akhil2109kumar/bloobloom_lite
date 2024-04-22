# frozen_string_literal: true

class CreatePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :prices do |t|
      t.references :priceable, polymorphic: true, null: false
      t.decimal :amount, null: false
      t.string :currency, null: false

      t.timestamps
    end

    add_index :prices, %i[priceable_type priceable_id currency], unique: true
  end
end
