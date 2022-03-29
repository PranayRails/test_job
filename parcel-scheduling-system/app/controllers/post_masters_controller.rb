# frozen_string_literal: true

class PostMastersController < ApplicationController
  before_action :set_post_master, only: %i[show edit update destroy]

  def index
    @post_masters = PostMaster.all
  end

  def new
    @post_master = PostMaster.new
  end

  def create
    @post_master = PostMaster.new(post_master_params)

    if @post_master.save
      flash[:success] = 'Post master is successfully created.'
      redirect_to post_master_url(@post_master)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post_master.update(post_master_params)
      flash[:success] = 'Post master is successfully updated.'
      redirect_to post_master_url(@post_master)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post_master.destroy
    flash[:success] = 'Post master is successfully destroyed.'
    redirect_to post_masters_url
  end

  private

  def set_post_master
    @post_master = PostMaster.find(params[:id])
  end

  def post_master_params
    params.fetch(:post_master, {})
  end
end
