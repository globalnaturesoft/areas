module Naturesoft
  module Areas
    module Admin
      class CountriesController < Naturesoft::Admin::AdminController
        before_action :set_country, only: [:show, :edit, :update, :enable, :disable, :destroy]
        before_action :default_breadcrumb
            
        # add top breadcrumb
        def default_breadcrumb
          add_breadcrumb "Area", naturesoft_areas.admin_countries_path
          add_breadcrumb "Countries", naturesoft_areas.admin_countries_path
        end
    
        # GET /countries
        def index
          @countries = Country.search(params).paginate(:page => params[:page], :per_page => 10)
        end
    
        # GET /countries/1
        def show
        end
    
        # GET /countries/new
        def new
          @country = Country.new
          add_breadcrumb "New Country", nil,  class: "active"
        end
    
        # GET /countries/1/edit
        def edit
          add_breadcrumb "Edit Country", nil,  class: "active"
        end
    
        # POST /countries
        def create
          @country = Country.new(country_params)
          @country.user = current_user
    
          if @country.save
            redirect_to naturesoft_areas.edit_admin_country_path(@country.id), notice: 'Country was successfully created.'
          else
            render :new
          end
        end
    
        # PATCH/PUT /countries/1
        def update
          if @country.update(country_params)
            redirect_to naturesoft_areas.edit_admin_country_path(@country.id), notice: 'Country was successfully updated.'
          else
            render :edit
          end
        end
    
        # DELETE /countries/1
        def destroy
          @country.destroy
          render text: 'Country was successfully destroyed.'
        end
        
        #CHANGE STATUS /countries
        def enable
          @country.enable
          render text: 'Country was successfully active.'
        end
        
        def disable
          @country.disable
          render text: 'Country was successfully inactive.'
        end
        
        # DELETE /countries/delete?ids=1,2,3
        def delete
          @countries = Country.where(id: params[:ids].split(","))
          @countries.destroy_all
          render text: 'Country(countries) was successfully destroyed.'
        end
        
        # GET /countries/select2
        def select2
          render json: Country.select2(params)
        end
    
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_country
            @country = Country.find(params[:id])
          end
    
          # Only allow a trusted parameter "white list" through.
          def country_params
            params.fetch(:country, {}).permit(:name, :description)
          end
      end
    end
  end
end
