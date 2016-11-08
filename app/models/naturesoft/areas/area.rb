module Naturesoft::Areas
  class Area < ApplicationRecord
    belongs_to :country
    belongs_to :parent, class_name: "Area", optional: true
    has_many :children, class_name: "Area", foreign_key: "parent_id"
    if Naturesoft::Core.available?("hotels")
        has_and_belongs_to_many :hotels, class_name: 'Naturesoft::Hotels::Hotel', :join_table => 'naturesoft_hotels_areas_hotels'
    end
    after_save :update_level
    
    def self.get_main_areas
			self.where(level: 1)
		end
    
    def update_level
      level = 1
			p = self.parent
			while !p.nil? do
				level += 1
				p = p.parent
			end
			self.update_column(:level, level)
    end
    
    def get_all_related_ids
			arr = []
			arr << self.id
			self.children.each do |i1|
				arr << i1.id
				i1.children.each do |i2|
					arr << i2.id
					i2.children.each do |i3|
						arr << i3.id
					end
				end 
			end
			
			return arr
		end
    
    def self.sort_by
      [
        ["Name","naturesoft_areas_areas.name"],
        ["Created At","naturesoft_areas_areas.created_at"]
      ]
    end
    
    def self.sort_orders
      [
        ["ASC","asc"],
        ["DESC","desc"]
      ]
    end
    
    #Filter, Sort
    def self.search(params)
      records = self.all
      
      #Search keyword filter
      if params[:keyword].present?
        params[:keyword].split(" ").each do |k|
          records = records.where("LOWER(CONCAT(naturesoft_areas_areas.name)) LIKE ?", "%#{k.strip.downcase}%") if k.strip.present?
        end
      end
      
      # Country
      if params[:country_id].present?
        records = records.where(country_id: params[:country_id])
      end
      
      # for sorting
      sort_by = params[:sort_by].present? ? params[:sort_by] : "naturesoft_areas_areas.name"
      sort_orders = params[:sort_orders].present? ? params[:sort_orders] : "desc"
      records = records.order("#{sort_by} #{sort_orders}")
      
      return records
    end
    
    # display name with parent
    def full_name
			names = [self.name]
			p = self.parent
			while !p.nil? do
				names << p.name
				p = p.parent
			end
			names.reverse.join(" >> ")
		end
    
    # data for select2 ajax
    def self.select2(params)
			items = self.search(params).order("level")
			if params[:excluded].present?
				items = items.where.not(id: params[:excluded].split(","))
			end
			options = [{"id" => "", "text" => "none"}]
			options += items.map { |c| {"id" => c.id, "text" => c.full_name} }
			result = {"items" => options}
		end
    
  end
end
