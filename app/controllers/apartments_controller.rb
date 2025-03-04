class ApartmentsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def index
    apartments = Apartment.all
    render json: apartments, include: :leases
  end

  def show
    apartment = get_apartment
    if apartment
      render json: apartment, include: :leases
    else
      render_not_found_response
    end
  end

  def create    
    apartments = get_list_of_apartments
    if apartments.include?(params[:number])
      render json: { error: "Apartment already created" }, status: :unprocessable_entity
    else
      new_apartment = Apartment.create(apartment_params)
      render json: new_apartment, status: :created
    end
  end

  def update
    apartment = get_apartment
    if apartment
      apartment.update(apartment_params)
      render json: apartment
    else
      render_not_found_response
    end
  end

  def destroy
    apartment = get_apartment
    if apartment
      apartment.destroy
      head :not_content
    else
      render_not_found_response
    end
  end

  def get_apartment
    Apartment.find(params[:id])
  end

  def get_list_of_apartments
    apartments = Apartment.all
    apartments.map{ |apartment| apartment.number }
  end

  private

  def apartment_params
    parans.permit(:number)
  end

  def render_not_found_response
    render json: { error: "Apartment not found" }, status: :not_found
  end

  def render_unprocessable_entity_response
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity 
  end

end
