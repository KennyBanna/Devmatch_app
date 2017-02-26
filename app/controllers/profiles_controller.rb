class ProfilesController < ApplicationController
  
  before_action :authenticate_user!
  before_action :only_current_user
  
  def new
    if user_signed_in?
      #Users already with a profile gets redirected
      if !current_user.profile
        @profile = Profile.new
      else 
        flash[:notice] = "You already have a profile"
        redirect_to root_path
      end
    else
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
       
      render 'new'
    end
    
  end
  
  private 
    def profile_parameters
      params.require(:profile).permit(:fname, :lname, :title, :description) 
    end
  
    def only_current_user
      @user = User.find( params[:user_id] )
      redirect_to root_path unless @user == current_user
    end
end