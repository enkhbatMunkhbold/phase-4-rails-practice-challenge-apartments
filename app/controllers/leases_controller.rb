class LeasesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def index
    leases = get_list_of_leases
    render json: leases
  end

  def show
    lease = get_lease
    if lease
      render json: lease
    else
      render_not_found_response
    end
  end

  def create
    new_lease = Lease.create(lease_params)
    render json: new_lease, status: :created
  end

  def update
    lease = get_lease
    if lease
      lease.update(lease_params)
      render json: lease
    else
      render_unprocessable_entity_response
    end
  end

  def destroy
    lease = get_lease
    if lease
      lease.destroy
      head :not_content
    else
      render_not_found_response
    end
  end

  def get_lease
    Lease.find(params[:id])
  end

  def get_list_of_leases
    Lease.all
  end

  private

  def lease_params
    params.permit(:apartment_id, :tenant_id, :rent)
  end

  def render_not_found_response
    render json: { error: "Lease not found" }, status: :not_found
  end

  def render_unprocessable_entity_response
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

end
