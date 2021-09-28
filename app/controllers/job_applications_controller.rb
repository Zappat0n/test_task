class JobApplicationsController < ApplicationController
  include JobApplicationsHelper

  def create
    job_application = JobApplication.new(job_application_params)
    if job_application.save
      redirect_to job_path(job_application.job_id), status: 200
    else
      flash.now[:alert] = "Error"
      redirect_to job_path(job_application_params[:job_id]), status: :unprocessable_entity
    end
  end
end
