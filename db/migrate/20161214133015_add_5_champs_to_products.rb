class Add5ChampsToProducts < ActiveRecord::Migration[5.0]
  def self.up
    change_table :products do |t|
      t.string :brand
      t.string :reference
      t.string :supplier_reference
      t.boolean :available, null: false, default: true
      t.string :defaut_categorie
      t.decimal :price
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
