class Admin::ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])

    if params[:search].present?
      @pets = Pet.search(params[:search])
    end
  end

    def approve_app
        @application = Application.find(params[:id])
        @application.approve
        redirect_to "/admin/applications/#{@application.id}"
    end

    def reject_app
        @application = Application.find(params[:id])
        @application.reject
        redirect_to "/admin/applications/#{@application.id}"
    end
end