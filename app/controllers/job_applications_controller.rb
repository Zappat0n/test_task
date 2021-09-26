class JobApplicationsController < ApplicationController
  include JobApplicationsHelper

  def create
    job_application = JobApplication.new(job_application_params)
    if job_application.save
      redirect_to job_path(job_application.job_id), notice: "Application saved"
    else
      redirect_to job_path(job_application_params[:job_id]), alert: "Error saving application"
    end
  end
end
