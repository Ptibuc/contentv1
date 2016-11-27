class CreateCaracteristiques < ActiveRecord::Migration[5.0]
  def change
    create_table :caracteristiques do |t|
      t.string :name
      t.references :site, foreign_key: true

      t.timestamps
    end

    create_table :has_caracteristique do |u|
      u.references :caracteristique, foreign_key: true
      u.references :product, foreign_key: true
      u.string :value

      u.timestamps
    end
  end
end
