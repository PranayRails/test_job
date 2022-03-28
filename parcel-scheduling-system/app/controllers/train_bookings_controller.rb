class TrainBookingsController < ApplicationController
  before_action :authenticate_post_master, only: %i[update destroy create]
  before_action :set_train_booking, only: %i[ show edit update destroy ]

  def index
    @train_bookings = if current_user.is_train_operator?
                        TrainBooking.all
                      else
                        current_user.train_bookings
                      end.page(params[:page]).per(10)
  end

  def new
    @train_booking = TrainBooking.new
  end

  def create
    @train_booking = TrainBooking.new(train_booking_params)

    if @train_booking.save
      redirect_to train_booking_url(@train_booking), success: "Train booking is successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @train_booking.update(train_booking_params)
      redirect_to train_booking_url(@train_booking), success: "Train booking is successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @train_booking.destroy
    redirect_to train_bookings_url, success: "Train booking is successfully destroyed."
  end

  private
    def authenticate_post_master
      return if current_user.is_post_master?
      redirect_to train_bookings_url, success: "Unauthorised access denied."
    end

    def set_train_booking
      @train_booking = TrainBooking.find(params[:id])
    end

    def train_booking_params
      params.fetch(:train_booking, {})
    end
end
