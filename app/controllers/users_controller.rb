class UsersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :check_for_profile, only: :show
  
  #GET request to users/:id
  def show
    @user = User.find(params[:id])
  end
  
  #GET request to users
  def index
    #SQL join (all Users and include all profiles)
    @users = User.includes(:profile)
  end
  
  protected 
    def check_for_profile
      if !User.find(params[:id]).profile 
        flash[:danger] = 'This user has not created a profile'
        redirect_to root_path
      end
    end
end