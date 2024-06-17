class RenameProductsToPatients < ActiveRecord::Migration[6.1]
  def change
    rename_table :products, :patients
  end
end
