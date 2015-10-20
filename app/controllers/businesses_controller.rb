class BusinessesController < ApplicationController
  before_filter :authenticate_user!, :except => [:new, :create]
  before_filter :load_business, only: [:show, :edit, :update]
  
  def new
    @business = Business.new
    @user = @business.build_user

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @business }
    end
  end
  
  def create
    @business = Business.new(business_params)

    respond_to do |format|
      if @business.save
        @business.user.add_role :business
        sign_in @business.user
        format.html { redirect_to dashboard_index_url, notice: 'Business signup successfully completed.' }
      else
        format.html { redirect_to business_signup_path, alert: @business.errors.full_messages.join("<br />") }
      end
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    respond_to do |format|
      if @business.update_attributes(update_business_params)
        format.html { redirect_to business_path(@business), notice: 'Profile has been successfully updated.' }
      else
        format.html { redirect_to edit_business_path(@business), alert: @business.errors.full_messages.join("<br />") }
      end
    end
  end

  private
  def business_params    
    params.require(:business).permit(:name, :phone, :add1, :add2, :city, :state, :zip, :photo, :user_attributes => [:id, :email, :password, 
      :password_confirmation])
  end
  
  def update_business_params    
    params.require(:business).permit(:name, :phone, :add1, :add2, :city, :state, :zip, :photo)
  end
  
  def load_business
    @business = current_user.profile
  end
end
