class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
  end

  def new

  end

  def create
    @application = Application.create(application_params)

    @application.status = 'In Progress'
    @application.save
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

