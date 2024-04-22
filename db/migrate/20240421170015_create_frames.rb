# frozen_string_literal: true

class CreateFrames < ActiveRecord::Migration[7.0]
  def change
    create_table :frames do |t|
      t.string :name, null: false
      t.text :description
      t.integer :status, null: false, default: 0
      t.integer :stock, null: false, default: 0

      t.timestamps
    end
  end
end
