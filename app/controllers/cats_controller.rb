class CatsController < ApplicationController
  before_action :assure_cat_is_yours, only: [:edit, :update]
  before_action :redirect_back_to_sign_in, only: [:index, :request_cats, :new]
  def index
    @your_cats = current_user.cats
    
    render :index
  end
  
  def request_cats
    @other_cats = Cat.all_cats_not_owned_by(current_user)
    
    render :request_cats
  end
  
  def show
    @cat = Cat.find(params[:id])
    @requests = @cat.cat_rental_requests.order_by_start_date
    render :show    
  end
  
  def new
    @cat = Cat.new
    render :new    
  end
  
  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end    
  end
  
  def edit
    @cat = Cat.find(params[:id])    
    render :edit
  end
  
  def update
    @cat = Cat.find(params[:id])
    
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    @cat = Cat.find(params[:id])
    @cat.destroy
    redirect_to cats_url
  end
  
  private
  def cat_params
    params.require(:cat).permit(:sex, :name, :color, :birth_date, :description)
  end
  
  def redirect_back_to_sign_in
    redirect_to new_session_url if current_user.nil?
  end
  
  def assure_cat_is_yours
    redirect_to cats_url unless current_user.id == params[:id]
  end
end
