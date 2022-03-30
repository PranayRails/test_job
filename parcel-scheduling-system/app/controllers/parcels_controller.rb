# frozen_string_literal: true

# ParcelsController
class ParcelsController < ApplicationController
  before_action :authenicate_parcel_owner
  before_action :set_parcel, only: %i[show edit update destroy]
  before_action :editable_parcel?, only: %i[ edit ]

  def index
    @parcels = if current_user.post_master?
                 Parcel.booked
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
      flash[:success] = 'Parcel is successfully created'
      redirect_to parcel_url(@parcel)
    else
      render :new
    end
  end

  def update
    if @parcel.update(parcel_params)
      flash[:success] = 'Parcel is successfully updated'
      redirect_to parcel_url(@parcel)
    else
      render :edit
    end
  end

  def destroy
    return unless @parcel.destroy

    redirect_to parcels_path, success: 'Parcel is successfully destroyed.'
  end

  private

  def authenicate_parcel_owner
    return unless current_user.train_operator?

    redirect_to root_url, notice: 'Unauthorised access denied.'
  end

  def set_parcel
    @parcel = Parcel.find(params[:id])
  end

  def parcel_params
    params.require(:parcel).permit(:weight, :volume, :source, :destination, :status, :cost, :parcel_owner_id)
  end

  def editable_parcel?
    return if @parcel.booked?

    flash[:error] = "Parcel is shipped/delivered"
    redirect_to root_url
  end
end
