class TrainsController < ApplicationController
  before_action :authenicate_parcel_owner
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
      flash[:success] = "Train is successfully created."
      redirect_to train_url(@train)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @train.update(train_params)
      flash[:success] = "Train is successfully updated."
      redirect_to train_url(@train)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    return unless @train.destroy
    flash[:success] = "Train is successfully destroyed."
    redirect_to trains_url
  end

  private
    def authenicate_parcel_owner
      return if current_user.is_train_operator?
      redirect_to root_url, notice: "Unauthorised access denied."
    end

    def set_train
      @train = Train.find(params[:id])
    end

    def train_params
      params.require(:train).permit(:source, :destination, :weight_capacity, :volume_capacity, :cost)
    end
end
