class CreateSites < ActiveRecord::Migration[5.0]
  def change
    create_table :sites do |t|
      t.string :url
      t.string :system
      t.string :logo
      t.string :lang
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
