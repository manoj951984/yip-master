class CustomersController < ApplicationController
  before_filter :authenticate_user!, :except => [:new, :create]
  before_filter :load_customer, only: [:show, :edit, :update]

  def new
    @customer = Customer.new
    @user = @customer.build_user

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @customer }
    end
  end
  
  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        @customer.user.add_role :customer
        sign_in @customer.user
        format.html { redirect_to dashboard_index_url, notice: 'Customer signup successfully completed.' }
      else
        format.html { redirect_to customer_signup_path, alert: @customer.errors.full_messages.join("<br />") }
      end
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    respond_to do |format|
      if @customer.update_attributes(update_customer_params)
        format.html { redirect_to customer_path(@customer), notice: 'Profile has been successfully updated.' }
      else
        format.html { redirect_to edit_customer_path(@customer), alert: @customer.errors.full_messages.join("<br />") }
      end
    end
  end
  
  private
  def customer_params    
    params.require(:customer).permit(:name, :username, :dob, :add1, :add2, :city, :state, :zip, :user_attributes => [:id, :email, :password, 
      :password_confirmation])
  end
  
  def update_customer_params    
    params.require(:customer).permit(:name, :username, :dob, :add1, :add2, :city, :state, :zip)
  end
  
  def load_customer
    @customer = current_user.profile
  end
end
