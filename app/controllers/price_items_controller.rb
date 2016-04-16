class PriceItemsController < ApplicationController
  before_action :set_price_item, only: [:show, :edit, :update, :destroy]

  # GET /price_items
  # GET /price_items.json
  def index
    @price_items = PriceItem.all
  end

  # GET /price_items/1
  # GET /price_items/1.json
  def show
  end

  # GET /price_items/new
  def new
    @price_item = PriceItem.new
  end

  # GET /price_items/1/edit
  def edit
  end

  # POST /price_items
  # POST /price_items.json
  def create
    @price_item = PriceItem.new(price_item_params)

    respond_to do |format|
      if @price_item.save
        format.html { redirect_to @price_item, notice: 'Price item was successfully created.' }
        format.json { render :show, status: :created, location: @price_item }
      else
        format.html { render :new }
        format.json { render json: @price_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /price_items/1
  # PATCH/PUT /price_items/1.json
  def update
    respond_to do |format|
      if @price_item.update(price_item_params)
        format.html { redirect_to @price_item, notice: 'Price item was successfully updated.' }
        format.json { render :show, status: :ok, location: @price_item }
      else
        format.html { render :edit }
        format.json { render json: @price_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /price_items/1
  # DELETE /price_items/1.json
  def destroy
    @price_item.destroy
    respond_to do |format|
      format.html { redirect_to price_items_url, notice: 'Price item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_price_item
      @price_item = PriceItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def price_item_params
      params.require(:price_item).permit(:type, :strike_date, :strike_description, :country, :value, :category, :status, :description, :sub_category)
    end
end
