module JobApplicationsHelper
  def job_application_params
    params.require(:job_application).permit(:applicant_id, :job_id, :message)
  end
end
