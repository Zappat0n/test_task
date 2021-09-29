import React, { useState } from 'react'
import PropTypes from 'prop-types'

const ApplicationTableForm = ({ userId, jobId, onSucess, onError }) => {
  const [message, setMessage] = useState('');

  const handleChange = (event) => setMessage(event.target.value);

  const handleSubmit = async () => {
    try {
      const token = document.querySelector('[name=csrf-token]').content
      const response = await fetch(`/job_applications`, {
        method: "POST",
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': token
        },
        body: JSON.stringify({
          applicant_id: userId,
          job_id: jobId,
          message
        })
      });
      if (response.status === 200) onSucess(message);
      else if (response.status === 422) onError();
      setMessage('');
    } catch (error) {
      console.log(error);
    }
  }

  return (
    <>
      <div className="card m-2">
        <h5 className="p-1 text-center">Apply for job</h5>
        <div className="d-flex w-100 justify-content-center pb-2">
          <input type="text" value={message} onChange={handleChange} />
          <button className="btn btn-primary mx-2" onClick={handleSubmit}>Apply</button>
        </div>
      </div>
    </>
  );
}

ApplicationTableForm.propTypes = {
  userId: PropTypes.number.isRequired,
  jobId: PropTypes.number.isRequired,
  onSucess: PropTypes.func.isRequired,
  onError: PropTypes.func.isRequired,
}

export default ApplicationTableForm;