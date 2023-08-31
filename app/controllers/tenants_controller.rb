class TenantsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    tenants = Tenant.all
    render json: tenants
  end

  def show
    tenant = Tenant.find(params[:id])
    if tenant
      render json: tenant
    else
      render_not_found_response
    end
  end

  def render_not_found_response
    render json: { error: "Tenant not found" }, status: :not_found
  end

end
