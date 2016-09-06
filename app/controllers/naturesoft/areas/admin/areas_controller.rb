module Naturesoft
  module Areas
    module Admin
      class AreasController < Naturesoft::Admin::AdminController
        before_action :set_area, only: [:show, :edit, :update, :destroy]
        before_action :default_breadcrumb
            
        # add top breadcrumb
        def default_breadcrumb
          add_breadcrumb "Area", naturesoft_areas.admin_areas_path
          add_breadcrumb "Areas", naturesoft_areas.admin_areas_path
        end
    
        # GET /areas
        def index
          @areas = Area.search(params).paginate(:page => params[:page], :per_page => 10)
        end
    
        # GET /areas/1
        def show
        end
    
        # GET /areas/new
        def new
          @area = Area.new
          add_breadcrumb "New Area", nil,  class: "active"
        end
    
        # GET /areas/1/edit
        def edit
          add_breadcrumb "Edit Area", nil,  class: "active"
        end
    
        # POST /areas
        def create
          @area = Area.new(area_params)
    
          if @area.save
            redirect_to naturesoft_areas.edit_admin_area_path(@area.id), notice: 'Area was successfully created.'
          else
            render :new
          end
        end
    
        # PATCH/PUT /areas/1
        def update
          if @area.update(area_params)
            redirect_to naturesoft_areas.edit_admin_area_path(@area.id), notice: 'Area was successfully updated.'
          else
            render :edit
          end
        end
    
        # DELETE /areas/1
        def destroy
          @area.destroy
          render text: 'Area was successfully destroyed.'
        end
        
        # DELETE /areas/delete?ids=1,2,3
        def delete
          @areas = Area.where(id: params[:ids].split(","))
          @areas.destroy_all
          render text: 'Area(s) was successfully destroyed.'
        end
        
        # GET /areas/select2
        def select2
          render json: Area.select2(params)
        end
    
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_area
            @area = Area.find(params[:id])
          end
    
          # Only allow a trusted parameter "white list" through.
          def area_params
            params.fetch(:area, {}).permit(:name, :parent_id)
          end
      end    
    end
  end
end
