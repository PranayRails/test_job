class TrainBookingsController < ApplicationController
  before_action :authenticate_post_master, only: %i[update destroy create]
  before_action :set_train_booking, only: %i[ show edit update destroy ]
  before_action :check_authenication, only: %i[ new ]

  def index
    @train_bookings = if current_user.is_train_operator?
                        TrainBooking.all
                      else
                        current_user.train_bookings
                      end.page(params[:page]).per(10)
  end

  def new
    @parcel_ids = params[:parcels]
    @train_booking = current_user.train_bookings.build
    parcels = Parcel.where(id: @parcel_ids)
    @trains = Train.where(source: parcels.first.source, destination: parcels.first.destination).available_for_parcels(@parcel_ids)
  end

  def create
    @train_booking = current_user.train_bookings.build(train_booking_params)
    if @train_booking.save
      flash[:success] = "Train booking is successfully created."
      redirect_to train_booking_url(@train_booking)
    else
      @parcel_ids = train_booking_params[:parcels]
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @train_booking.update(train_booking_params)
      flash[:success] = "Train booking is successfully updated."
      redirect_to train_booking_url(@train_booking)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @train_booking.destroy
    flash[:success] = "Train booking is successfully destroyed."
    redirect_to train_bookings_url
  end

  private
    def authenticate_post_master
      return if current_user.is_post_master?
      flash[:success] = "Unauthorised access denied."
      redirect_to train_bookings_url
    end

    def set_train_booking
      @train_booking = TrainBooking.find(params[:id])
    end

    def train_booking_params
      params.required(:train_booking).permit(:train_id, :post_master_id, :parcels)
    end

    def check_authenication
      unless params[:parcels]
        flash[:error] = "Please select parcels"
        redirect_to parcels_url
      end
    end
end
