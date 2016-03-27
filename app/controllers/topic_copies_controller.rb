class TopicCopiesController < ApplicationController
  before_action :set_topic_copy, only: [:show, :edit, :update, :destroy]

  # GET /topic_copies
  # GET /topic_copies.json
  def index
    @topic_copies = TopicCopy.all
  end

  # GET /topic_copies/1
  # GET /topic_copies/1.json
  def show
  end

  # GET /topic_copies/new
  def new
    @topic_copy = TopicCopy.new
  end

  # GET /topic_copies/1/edit
  def edit
  end

  # POST /topic_copies
  # POST /topic_copies.json
  def create
    @topic_copy = TopicCopy.new(topic_copy_params)

    respond_to do |format|
      if @topic_copy.save
        format.html { redirect_to @topic_copy, notice: 'Topic copy was successfully created.' }
        format.json { render :show, status: :created, location: @topic_copy }
      else
        format.html { render :new }
        format.json { render json: @topic_copy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topic_copies/1
  # PATCH/PUT /topic_copies/1.json
  def update
    respond_to do |format|
      if @topic_copy.update(topic_copy_params)
        format.html { redirect_to @topic_copy, notice: 'Topic copy was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic_copy }
      else
        format.html { render :edit }
        format.json { render json: @topic_copy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topic_copies/1
  # DELETE /topic_copies/1.json
  def destroy
    @topic_copy.destroy
    respond_to do |format|
      format.html { redirect_to topic_copies_url, notice: 'Topic copy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic_copy
      @topic_copy = TopicCopy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_copy_params
      params.require(:topic_copy).permit(:headline_1, :headline_2, :headline_3, :topic_id)
    end
end
