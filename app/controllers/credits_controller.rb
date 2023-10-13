class CreditsController < ApplicationController
  before_action :set_credit, only: %i[ show edit update destroy ]

  # GET /credits
  def index
    @credits = Credit.all
  end

  # GET /credits/1
  def show
  end

  # GET /credits/new
  def new
    @credit = Credit.new
  end

  # GET /credits/1/edit
  def edit
  end

  # POST /credits
  def create
    @credit = Credit.new(credit_params)

    if @credit.save
      redirect_to @credit, notice: "Credit was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /credits/1
  def update
    if @credit.update(credit_params)
      redirect_to @credit, notice: "Credit was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /credits/1
  def destroy
    @credit.destroy
    redirect_to credits_url, notice: "Credit was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_credit
      @credit = Credit.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def credit_params
      params.require(:credit).permit(:creditID, :date, :status, :type, :credit_value, :description)
    end
end
