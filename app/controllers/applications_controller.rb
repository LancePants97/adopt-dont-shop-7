class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    if params[:search].present?
      @pets = Pet.where('name ILIKE ?', "%#{params[:search]}%")
    end
  end

  def new
  end

  def create
    @application = Application.new(application_params)
    @application.status = 'In Progress'

    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      flash[:error] = "All fields must be filled in."
      redirect_to "/applications/new"
    end
  end

  def add_pet
    @application = Application.find(params[:id])
    pet = Pet.find(params[:pet_id])
    @application.pets << pet
    redirect_to "/applications/#{@application.id}"
  end
  
  def application_params
    params.permit(:applicant_name, 
                  :street_address, 
                  :city, 
                  :state, 
                  :zip_code, 
                  :description, 
                  :status)
  end
  
end

