# frozen_string_literal: true

# ParcelsController
class ParcelsController < ApplicationController
  before_action :authenicate_parcel_owner, only: [:create, :update, :destroy]
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
    if @parcel.destroy
      flash[:success] = "Parcel is successfully deleted."
    else
      flash[:error] = "Somthing went wrong with this parcel"
    end
    redirect_to parcel_url
  end

  private

  def authenicate_parcel_owner
    return if current_user.is_parcel_owner?
    redirect_to parcels_url, notice: "Unauthorised access denied."
  end

  def set_parcel
    @parcel = Parcel.find(params[:id])
  end

  def parcel_params
    params.require(:parcel).permit(:weight, :volume, :source, :destination, :status, :cost)
  end
end
