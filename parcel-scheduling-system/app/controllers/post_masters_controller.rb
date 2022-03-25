class PostMastersController < ApplicationController
  before_action :set_post_master, only: %i[ show edit update destroy ]

  # GET /post_masters or /post_masters.json
  def index
    @post_masters = PostMaster.all
  end

  # GET /post_masters/1 or /post_masters/1.json
  def show
  end

  # GET /post_masters/new
  def new
    @post_master = PostMaster.new
  end

  # GET /post_masters/1/edit
  def edit
  end

  # POST /post_masters or /post_masters.json
  def create
    @post_master = PostMaster.new(post_master_params)

    respond_to do |format|
      if @post_master.save
        format.html { redirect_to post_master_url(@post_master), notice: "Post master was successfully created." }
        format.json { render :show, status: :created, location: @post_master }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post_master.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /post_masters/1 or /post_masters/1.json
  def update
    respond_to do |format|
      if @post_master.update(post_master_params)
        format.html { redirect_to post_master_url(@post_master), notice: "Post master was successfully updated." }
        format.json { render :show, status: :ok, location: @post_master }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post_master.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /post_masters/1 or /post_masters/1.json
  def destroy
    @post_master.destroy

    respond_to do |format|
      format.html { redirect_to post_masters_url, notice: "Post master was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post_master
      @post_master = PostMaster.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_master_params
      params.fetch(:post_master, {})
    end
end
