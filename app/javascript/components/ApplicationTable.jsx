import React, { useState } from 'react'
import PropTypes from 'prop-types'

const ApplicationTable = ({ job_id, job_title, user_id, username, applications_data }) => {
  const [applications, setApplications] = useState(applications_data);
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
          applicant_id: user_id,
          job_id,
          message
        })
      })
      if (response.status === 200) {
        let data = applications;
        data.unshift({
          applicant_id: user_id,
          job_id,
          message,
          username
        });
        setApplications(data);
        setMessage('');
      }
      
    } catch (error) {
      console.log(error);
    }
  }

  return (
    <div className="card w-50 mx-auto mt-5 shadow">
      <h2 className="card-header text-center">{job_title}</h2>
      <ul className="list-group w-100 text-center">
        {applications.map((application, index) => (
          <li className="list-group-item" key={index}>
            <div className="container-fluid">
              <div className="row">
                <div className="col">{application.message}</div>
                <div className="col">by</div>
                <div className="col">{application.username}</div>
              </div>
            </div>
          </li>
        ))}
      </ul>
      <div className="card m-2">
        <h5 className="p-1 text-center">Apply for job</h5>
        <div className="d-flex w-100 justify-content-center pb-2">
          <input type="text" value={message} onChange={handleChange} />
          <button className="btn btn-primary mx-2" onClick={handleSubmit}>Apply</button>
        </div>
      </div>
    </div>
  );
}

ApplicationTable.propTypes = {
  job_id: PropTypes.number.isRequired,
  job_title: PropTypes.string.isRequired,
  user_id: PropTypes.number.isRequired,
  username: PropTypes.string.isRequired,
  applications_data: PropTypes.array.isRequired
}

export default ApplicationTable;