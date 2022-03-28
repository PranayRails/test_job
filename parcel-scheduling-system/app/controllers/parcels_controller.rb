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
    @parcel = current_user.parcels.build(parcel_params)

    if @parcel.save
      redirect_to parcel_url(@parcel), notice: 'Parcel was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @parcel.update(parcel_params)
      redirect_to parcel_url(@parcel), notice: 'Parcel was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @parcel.destroy
    redirect_to parcels_url, notice: 'Parcel was successfully destroyed.'
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
