class CatRentalRequestsController < ApplicationController
  def new
    @cat_rental_request = CatRentalRequest.new
    @cats = Cat.all
  end
  
  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)
    @cats = Cat.all
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
end
