class EnemiesController < ApplicationController

  before_action :set_enemy, only: [:show, :update, :destroy]

  def index
    @enemy = Enemy.all

    if @enemy != []
      render json: @enemy, status: :ok
    else
      render json: { message: 'No enemies found' }, status: :ok
    end
  end

  def create
    if Enemy.create(enemy_params)
      render json: @enemy, status: :created
    else
      render json: { errors: @enemy.errors }, status: :unprocessable_entity
    end
  end

  def show
    @enemy = Enemy.find(params[:id])
  end

  def update
    if @enemy.update(enemy_params)
      render json: @enemy, status: :ok
    else
      render json: { errors: @enemy.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @enemy.destroy
    head 204
  end

  private

  def enemy_params
    params.permit(:name, :power_base, :power_step, :level, :kind)
  end

  def set_enemy
    @enemy = Enemy.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: e.message }, status: :not_found
  end

end