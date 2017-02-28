class ProfilesController < ApplicationController
  
  before_action :authenticate_user!
  before_action :only_current_user
  
  def new
    #Users already with a profile gets redirected
    if !current_user.profile
      @profile = Profile.new
    else 
      flash[:notice] = "You already have a profile"
      redirect_to root_path
    end
  end
  
  def create
    
    @user = User.find( params[:user_id])
    #build_association method comes from the "has_one" relationsship  
    @profile = @user.build_profile( profile_parameters )
    
    if @profile.save
      flash[:success] = 'Successfully created profile'
      redirect_to root_path
    else
      #Error messages
      render action: :new
      flash[:danger] = @profile.errors.full_messages.join(", ")
    end
    
  end
  
  #GET to /Users/:id/profile/edit
  def edit
    @profile = User.find( params[:user_id] ).profile
  end
  
  #PUT/PATch request to /Users/:id/profile/edit
  def update
    @profile = User.find( params[:user_id] ).profile
    if @profile.update_attributes( profile_parameters )
      flash[:success] = 'Successfully updated profile info'
      #show user
      redirect_to user_path( id: current_user.id )
    else
      flash[:danger] = @profile.errors.full_messages.join(', ')
      render action: :edit
    end
  end
  
  private 
    def profile_parameters
      params.require(:profile).permit(:fname, :lname, :avatar, :title, :description) 
    end
  
    def only_current_user
      @user = User.find( params[:user_id] )
      redirect_to root_path unless @user == current_user
    end
end