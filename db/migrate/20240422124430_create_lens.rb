# frozen_string_literal: true

class CreateLens < ActiveRecord::Migration[7.0]
  def change
    create_table :lenses do |t|
      t.text :description
      t.integer :prescription_type
      t.integer :lens_type
      t.string :colour
      t.integer :stock

      t.timestamps
    end
  end
end
