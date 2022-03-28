# frozen_string_literal: true

# ParcelsController
class ParcelsController < ApplicationController
  before_action :authenicate_parcel_owner
  before_action :set_parcel, only: %i[show edit update destroy]

  def index
    @parcels = if current_user.is_post_master?
                 Parcel.all
               else
                 current_user.parcels
               end.page(params[:page]).per(10)
  end

  def new
    @parcel = Parcel.new
  end

  def create
    @parcel = Parcel.new(parcel_params)
    if @parcel.save
     flash[:success] = "Parcel is successfully created"
     redirect_to parcel_url(@parcel)
    else
      render :new
    end
  end

  def update
    if @parcel.update(parcel_params)
      flash[:success] = "Parcel is successfully updated"
      redirect_to parcel_url(@parcel)
    else
      render :edit
    end
  end

  def destroy
    return unless @parcel.destroy
    redirect_to parcel_url, success: "Parcel is successfully destroyed."
  end

  private

  def authenicate_parcel_owner
    return unless current_user.is_train_operator?
    redirect_to root_url, notice: "Unauthorised access denied."
  end

  def set_parcel
    @parcel = Parcel.find(params[:id])
  end

  def parcel_params
    params.require(:parcel).permit(:weight, :volume, :source, :destination, :status, :cost, :parcel_owner_id)
  end
end
