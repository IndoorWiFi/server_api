class FacilitiesController < ApplicationController
  before_action :set_facility, only: [:show]

  # GET /facilities
  def show_all
    if params[:user_id] == current_user.id.to_s
      render json: current_user.facilities
    else
      render json: 'You can not access this resources'
    end
  end

  # POST /create_facility
  # POST /create_facility.json
  def create_facility
    @facility = Facility.new(facility_params)
    @facility.user_id = current_user.id

    if Facility.where(name: @facility.name).exists?
      render json: ('Facility name "'+@facility.name+'" already exists'), status: :not_acceptable
    else
      if @facility.save
        render json: @facility, status: :created
      else
        render json: @facility.errors, status: :unprocessable_entity
      end
    end

  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_facility
    @facility = Facility.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def facility_params
    params.require(:facility).permit(:name)
  end
end
