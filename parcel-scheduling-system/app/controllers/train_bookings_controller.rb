# frozen_string_literal: true

# TrainBookingsController
class TrainBookingsController < ApplicationController
  before_action :authenticate_post_master
  before_action :set_train_booking, only: %i[ show edit update destroy ]
  before_action :check_parcels, only: %i[ new ]
  before_action :get_parcels, only: %i[ new ]
  before_action :check_busy_trains, only: %i[ new ]
  before_action :get_trains, only: %i[ new ]

  def index
    @train_bookings = if current_user.train_operator?
                        TrainBooking.all
                      else
                        current_user.train_bookings
                      end.page(params[:page]).per(10)
  end

  def new
    @train_booking = current_user.train_bookings.build
  end

  def create
    @train_booking = current_user.train_bookings.build(train_booking_params)
    if @train_booking.save
      flash[:success] = 'Train booking is successfully created.'
      redirect_to @train_booking
    else
      @parcel_ids = train_booking_params[:parcels]
      render :new, status: :unprocessable_entity
    end
  end

  # def update
  #   if @train_booking.update(train_booking_params)
  #     flash[:success] = 'Train booking is successfully updated.'
  #     redirect_to train_booking_url(@train_booking)
  #   else
  #     render :edit, status: :unprocessable_entity
  #   end
  # end

  def destroy
    @train_booking.destroy
    flash[:success] = 'Train booking is successfully destroyed.'
    redirect_to train_bookings_url
  end

  private

  def authenticate_post_master
    return if current_user.post_master?

    flash[:error] = 'Unauthorised access denied.'
    redirect_to root_url
  end

  def get_parcels
    @parcels = Parcel.where(id: params[:parcels])
  end

  def check_busy_trains
    @busy_lines = TrainBooking.busy_lines?(@parcels)
    if @busy_lines.any?
      flash[:error] = "Lines busy where you want to send parcels"
      redirect_to parcels_url
    end
  end

  def get_trains
    @trains = Train.available_for_parcels(@parcels)
  end

  def set_train_booking
    @train_booking = TrainBooking.find(params[:id])
    return if @train_booking
    flash[:error] = "Train booking not found"
    redirect_to parcels_url
  end

  def train_booking_params
    params.required(:train_booking).permit(:train_id, :post_master_id, :parcel_ids)
  end

  def check_parcels
    return if params[:parcels]

    flash[:error] = 'Please select parcels'
    redirect_to parcels_url
  end
end

