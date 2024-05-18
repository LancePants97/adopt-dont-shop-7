class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
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

