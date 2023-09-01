class TenantsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def index
    tenants = Tenant.all
    render json: tenants, include: :apartment
  end

  def show
    tenant = get_tenant
    if tenant
      render json: tenant, include: :apartment
    else
      render_not_found_response
    end
  end

  def create
    # new_tenant = Tenant.create(tenant_params)
    tenants = get_list_of_tenants 
    answer = tenants.exists?(params[:name])
    byebug
    # if tenants.include?(new_tenant.name) 
    #   new_tenant.destroy
    #   render json: { error: "Tenant already created" }, status: :unprocessable_entity              
    # else
    #   render json: new_tenant, status: :create     
    # end
  end

  def update
    tenant = get_tenant
    if tenant
      tenant.update(tenant_params)
      render json: tenant
    else
      render_not_found_response
    end
  end

  def destroy
    tenant = get_tenant
    if tenant
      tenant.destroy
      head :no_content
    else
      render_not_found_response
    end
  end

  def get_tenant
    Tenant.find(params[:id])
  end

  def get_list_of_tenants
    tenants = Tenant.all
    tenants.map{|tenant| tenant.name}
  end

  private

  def tenant_params
    params.permit(:name, :age)
  end

  def render_unprocessable_entity_response
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

  def render_not_found_response
    render json: { error: "Tenant not found" }, status: :not_found
  end

end
