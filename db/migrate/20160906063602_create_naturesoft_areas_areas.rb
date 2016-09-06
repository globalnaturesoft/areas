class CreateNaturesoftAreasAreas < ActiveRecord::Migration[5.0]
  def change
    create_table :naturesoft_areas_areas do |t|
      t.string :name
      t.integer :parent_id
      t.references :country, index: true, references: :naturesoft_areas_countries

      t.timestamps
    end
  end
end