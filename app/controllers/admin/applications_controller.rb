class Admin::ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])

    if params[:search].present?
      @pets = Pet.where('name ILIKE ?', "%#{params[:search]}%")
    end
  end

    def approve_app
        @application = Application.find(params[:id])
        @application.approve
        redirect_to "/admin/applications/#{@application.id}"
    end
end