class UsersController < ApplicationController

  def index
    @users = User.all.where.not(admin: true).order('percent_correct_answers DESC')
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in(@user)
      flash[:success] = "Welcome to the Battle of minds"
      redirect_to @user
    else   
      render "new"
    end
  end

  def show
    @users_for_admin = User.all.paginate(page: params[:page], per_page: 5)

    @user = User.find(params[:id])
    @games = @user.gamescores
    @games_paginate = @games.paginate(page: params[:page], per_page: 5).order('created_at DESC')
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Updated"
      redirect_to @user
    else  
      flash[:danger] = "Ooops, try again"
      render "edit"
    end
  end

  def destroy
    @user = User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to root_path
  end

  def statistics
    @user = User.find(current_user.id)
    @user_results = @user.results
    @results = @user_results.select(:category).distinct.pluck(:category)
    for_statistics(@results)
  end

  def admin_true
    @user = User.find(params[:id])
    @user.update(admin: true)
    redirect_to @user
  end

  def admin_false
    @user = User.find(params[:id])
    @user.update(admin: false)
    redirect_to @user
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def for_statistics(results)
    @hash = {}

    results.each do |result|
      @category = Result.where(user_id: current_user.id, category: result)

      @sum_quest = @category.sum('quentity_questions')
      @sum_answers = @category.sum('correct_answers')
      @percent = @sum_answers.to_i * 100 / @sum_quest.to_i

      array = [
        *@sum_quest,
        *@sum_answers,
        *@percent,
      ]
      @hash[result] = array
    end
  end


end
