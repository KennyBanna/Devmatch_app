class ProfilesController < ApplicationController
  
  def new
    if user_signed_in?
      @profile = Profile.new
    else
      redirect_to root_path
    end
  end
  
  def create
    
    @user = current_user
    #build_association method comes from the "has_one" relationsship  
    @user.build_profile( profile_parameters )
    
    if @user.save
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
  
end