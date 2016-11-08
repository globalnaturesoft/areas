class AddImageToNaturesoftAreasAreas < ActiveRecord::Migration[5.0]
  def change
    add_column :naturesoft_areas_areas, :image, :string
  end
end
