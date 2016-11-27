class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.references :site, foreign_key: true

      t.timestamps
    end

    create_table :has_categorie do |u|
      u.references :product, foreign_key: true
      u.references :categorie, foreign_key: true

      u.timestamps
    end

  end
end
