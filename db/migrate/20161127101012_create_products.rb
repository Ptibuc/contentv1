class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :title
      t.string :photo
      t.string :client_id
      t.string :ean
      t.string :short_description
      t.text :long_description
      t.boolean :short_description_generated_by_us
      t.boolean :long_description_generated_by_us
      t.datetime :date_generation_short_description
      t.datetime :date_generation_long_description
      t.references :site, foreign_key: true

      t.timestamps
    end
  end
end
