class JobsController < ApplicationController
  def index
    @jobs = Job.all
  end

  def show
    @job = Job.find_by_id(params[:id])

    if @job
      @applications = JobApplication.for_job_with_username(params[:id])
      @ratings = Job.ratings(@applications, [current_user.id])
    else
      redirect_to jobs_path, alert: "I can't find that job"
    end
  end
end
