class ParcelsController < ApplicationController
  before_action :set_parcel, only: %i[ show edit update destroy ]

  def index
    @parcels = Parcel.all
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
    def set_parcel
      @parcel = Parcel.find(params[:id])
    end

    def parcel_params
      params.require(:parcel).permit(:weight, :volume, :source, :destination, :status, :cost)
    end
end
