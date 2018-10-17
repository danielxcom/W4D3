class CatRentalRequestsController < ApplicationController
  def approve
    current_cat_rental_request.approve!
    redirect_to cat_url(current_cat)
  end


  def create
    @rental_request = CatRentalRequest.new(cat_rental_request_params)
    # create rental, set user to be owner. This user's rental req. current_user id = rental_request id.
    @rental_request.user_id = current_user.id if current_user
    if @rental_request.save
      redirect_to cat_url(@rental_request.cat)
    else
      flash.now[:errors] = @rental_request.errors.full_messages
      render :new
    end
  end

  def deny
    current_cat_rental_request.deny!
    redirect_to cat_url(current_cat)
  end

  def new
    @rental_request = CatRentalRequest.new
    # they already populated logic for us so all we did was transport data over.

    @rental_request.cat_id = flash[:cat_id]
  end

  private

  def current_cat_rental_request
    @rental_request ||=
      CatRentalRequest.includes(:cat).find(params[:id])
  end

  def current_cat
    current_cat_rental_request.cat
  end

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :end_date, :start_date, :status)
  end
end
