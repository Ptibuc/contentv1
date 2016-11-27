class CreatePhrases < ActiveRecord::Migration[5.0]
  def change
    create_table :phrases do |t|
      t.string :libelle
      t.string :lang
      t.references :caracteristique, foreign_key: true

      t.timestamps
    end
  end
end
