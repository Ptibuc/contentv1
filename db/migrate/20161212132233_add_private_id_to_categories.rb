class AddPrivateIdToCategories < ActiveRecord::Migration[5.0]
  def self.up
    change_table :categories do |t|
      t.string :private_id
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
