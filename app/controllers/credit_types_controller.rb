class CreditTypesController < ApplicationController
    before_action :set_user
    before_action :set_credit_type, only: [:show, :edit, :update, :destroy]

    # def index
    #   @credit_types = @user.credit_types.all
    # end
  
    def new
      @credit_type = @user.credit_types.build
    end

    # def show
    #   @credit_type = CreditType.find(params[:id])
    # end

    
    def create
        @credit_type = @user.credit_types.build(credit_type_params)
        if @credit_type.save
            flash[:notice] = 'Credit type created successfully.'
            redirect_to dashboard_path
        else
            render :new
        end
    end

    # def update
    #   if @credit_type.update(credit_type_params)
    #     flash[:notice] = 'Credit type updated successfully.'
    #     redirect_to dashboard_path
    #   else
    #     render :edit
    #   end
    # end
  
    # def destroy
    #     @credit_type = CreditType.find(params[:id])
    #     @credit_type.destroy
    #     redirect_to dashboard_path, notice: "Credit type was successfully deleted."
    # end
  
  private

  def credit_type_params
    params.require(:credit_type).permit(:name, :credit_limit, :carry_forward)
  end

  def set_user
    @user = current_user
  end

  # def set_credit_type
  #   @credit_type = @user.credit_types.find(params[:id])
  # end
end
