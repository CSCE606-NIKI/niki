class CreditTypesController < ApplicationController

    def index
        @credit_types = CreditType.all
    end

    def show
         @credit_type = CreditType.find(params[:id])
    end

    def new
        @credit_type = CreditType.new
    end
    
    def create
        @credit_type = CreditType.new(credit_type_params)
        if @credit_type.save
            flash[:notice] = 'Credit type created successfully.'
            redirect_to dashboard_path
        else
            render :new
        end
    end

      private

  def credit_type_params
    params.require(:credit_type).permit(:name, :credit_limit, :carry_forward)
  end
end
