class TrainsController < ApplicationController
  before_action :set_train, only: %i[ show edit update destroy ]

  def index
    @trains = current_user.trains.page(params[:page]).per(10)
  end

  def new
    @train = current_user.trains.build
  end

  def create
    @train = current_user.trains.build(train_params)

    if @train.save
      redirect_to train_url(@train), notice: "Train was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @train.update(train_params)
      redirect_to train_url(@train), notice: "Train was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    return unless @train.destroy
    redirect_to trains_url, notice: "Train was successfully destroyed."
  end

  private
    def set_train
      @train = Train.find(params[:id])
    end

    def train_params
      params.require(:train).permit(:source, :destination, :weight_capacity, :volume_capacity, :cost)
    end
end
