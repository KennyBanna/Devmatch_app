class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end 
  
  def create
    #creates contact object with mass assignment
    @contact = Contact( contact_params )
  end
  
  #Whitelisting form fields as best practice security feature 
  def contact_params
    params.require(:contacts).permit(:name, :email, :contacts)
  end
  
end