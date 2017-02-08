class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end 
  
  def create
    #creates contact object with mass assignment
    @contact = Contact.new( contact_params )
    
    if @contact.save
      #Save to contacts table in database
      redirect_to root_path
      flash[:success] = "Successfully sent your question"
    else
      #Redirect to empty form
      redirect_to new_contact_path
      flash[:danger] = "Error: " + @contact.errors.full_messages.join(", ")
    end
  end
  
  #Whitelisting form fields as best practice security feature 
  def contact_params
    params.require(:contact).permit(:name, :email, :comment)
  end
  
end