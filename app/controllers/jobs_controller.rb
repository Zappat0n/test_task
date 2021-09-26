class JobsController < ApplicationController
  def index
    @jobs = Job.all
  end

  def show
    @job = Job.find_by_id(params[:id])
    @applications = JobApplication.for_job_with_username(params[:id])
    @ratings = Job.ratings(@applications)
  end
end
