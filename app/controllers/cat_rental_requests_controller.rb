class CatRentalRequestsController < ApplicationController
  before_action :ensure_request_belongs_to_owner, only: [:approve, :deny]
  def new
    @cat_rental_request = CatRentalRequest.new
    @cat = Cat.find(params[:cat_id])
  end
  
  def create
    @cat = Cat.find(params[:cat_id])
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)
    @cat_rental_request.cat_id = @cat.id
    @cat_rental_request.user_id = current_user.id
    if @cat_rental_request.save
      redirect_to cat_url(@cat_rental_request.cat)
    else
      flash.now[:errors] = @cat_rental_request.errors.full_messages
      render :new
    end
  end
  
  def destroy
    @cat_rental_request = CatRentalRequest.find(params[:id])
    @cat_rental_request.destroy
    redirect_to cat_url(@cat_rental_request.cat)
  end
   
   
  def approve
    @cat_rental_request = CatRentalRequest.find(params[:cat_rental_request_id])
    @cat_rental_request.approve!
    redirect_to cat_url(@cat_rental_request.cat)
  end
  
  def deny
    @cat_rental_request = CatRentalRequest.find(params[:cat_rental_request_id])
    @cat_rental_request.deny!
    redirect_to cat_url(@cat_rental_request.cat)
  end
  
  private
  
  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
  
  def ensure_request_belongs_to_owner
    owner_id = CatRentalRequest.find(params[:cat_rental_request_id]).cat.user_id
    if current_user.nil? || owner_id != current_user.id
      redirect_to cats_url 
    end
  end
end