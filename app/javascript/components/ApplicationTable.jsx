import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'

const ApplicationTable = ({ jobId, jobTitle, userId, userName, applicationsData, ratingsData }) => {
  const [applications, setApplications] = useState([]);
  const [message, setMessage] = useState('');

  useEffect(() => initializeRatings()
  , []);

  const handleChange = (event) => setMessage(event.target.value);

  const currentUserIncluded = () => applicationsData.filter((application) => userId == application.applicant_id).length > 0

  const sortRatings = (data) => {
    let sorted = [...data];
    sorted.sort((a, b) => {
      if (a.rating > b.rating) return -1;
      if (a.rating < b.rating) return 1;
      return 0;
    });

    setApplications(sorted);
  }

  const initializeRatings = () => {
    console.log(applicationsData);
    let userIncluded = currentUserIncluded();
    let userCount = ratingsData.length - (userIncluded ? 0 : 1);
    let count = 0;
    let average = 0;
    let ratings = new Map();

    ratingsData.forEach(rating => {
      if (ratingsData.user_id != userId && userIncluded) {
        count += rating.count;
        average += parseFloat(rating.avg);  
      }
    });

    let averageRating = userCount != 0 ? average / userCount : 0;
    let averageCount = userCount != 0 ? count / userCount : 0;

    console.log(`rating: ${averageRating}, count: ${averageCount}, included: ${userIncluded}`)
    ratingsData.forEach(rating => {
      ratings.set(rating.user_id, (rating.avg * rating.count + averageRating * averageCount) / ( rating.count + averageCount));
    });

    applicationsData.forEach((application) => application.rating = ratings.get(application.applicant_id));
    ratingsData.averageRating = averageRating;
    ratingsData.averageCount = averageCount;
    
    sortRatings(applicationsData);
  }

  const updateRatings = () => {
    let data = [...applications];

    data.push({
      applicant_id: userId,
      job_id: jobId,
      message,
      username: userName,
      rating: ratingsData.currentUserRating
    });

    const length = ratingsData.length;
    const currentUserData = ratingsData.filter((rating) => userId == rating.user_id)[0];
    const newAverage = (ratingsData.averageRating * (length-1) + currentUserData.avg) / length;
    const newCount = (ratingsData.averageCount * (length-1) + currentUserData.count) / length;

    data.forEach((application) => {
      let rating = ratingsData.filter((rating) => rating.user_id == application.applicant_id)[0];
      application.rating = (rating.avg * rating.count + newAverage * newCount) / ( rating.count + newCount);
    });

    sortRatings(data);
  }

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
      if (response.status === 200) updateRatings();
      else if (response.status === 422) alertModal();
      setMessage('');
    } catch (error) {
      console.log(error);
    }
  }

  return (
    <div className="card w-50 mx-auto mt-5 shadow">
      <h2 className="card-header text-center">{jobTitle}</h2>
      <ul className="list-group w-100 text-center">
        <div className="container-fluid">
          <div className="row p-3">
            <strong className="col">Message</strong>
            <strong className="col">Username</strong>
            <strong className="col">Rating</strong>
          </div>
        </div>
        {applications.map((application, index) => (
          application.rating ?
          <li className="list-group-item" key={index}>
            <div className="container-fluid">
              <div className="row">
                <div className="col">{application.message}</div>
                <div className="col">{application.username}</div>
                <div className="col">{Math.round(application.rating*100)/100}</div>
              </div>
            </div>
          </li>
          : null ))
        }
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
  jobId: PropTypes.number.isRequired,
  jobTitle: PropTypes.string.isRequired,
  userId: PropTypes.number.isRequired,
  userName: PropTypes.string.isRequired,
  applicationsData: PropTypes.array.isRequired,
  ratingsData: PropTypes.array.isRequired,
}

export default ApplicationTable;