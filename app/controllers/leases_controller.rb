class LeasesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    leases = Lease.all 
    render json: leases
  end

  def show
    lease = Lease.find(params[:id])
    if lease
      render json: lease
    else
      render_not_found_response
    end
  end

  def render_not_found_response
    render json: { error: "Lease not found" }, status: :not_found
  end

end
