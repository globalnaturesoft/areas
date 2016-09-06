class CreateNaturesoftAreasCountries < ActiveRecord::Migration[5.0]
  def change
    create_table :naturesoft_areas_countries do |t|
      t.string :name
      t.string :status, default: "active"
      t.text :description
      t.references :user, index: true, references: :naturesoft_users

      t.timestamps
    end
  end
end