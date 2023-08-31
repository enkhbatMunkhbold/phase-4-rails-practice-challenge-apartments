class ApartmentsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    apartments = Apartment.all 
    render json: apartments
  end

  def show
    apartment = Apartment.find(params[:id])
    if apartment
      render json: apartment
    else
      render_not_found_response
    end
  end

  def render_not_found_response
    render json: { error: "Apartment not found" }, status: :not_found
  end

end
