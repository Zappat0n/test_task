import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import DisplayAlert, { ALERT} from './DisplayAlert';
import ApplicationTableForm from './ApplicationTableForm';

const ApplicationTable = ({ jobId, jobTitle, userId, userName, applicationsData, ratingsData }) => {
  const [applications, setApplications] = useState([]);
  const [error, setError] = useState('');

  useEffect(() => initializeRatings(), []);

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
    let userIncluded = currentUserIncluded();
    let userCount = ratingsData.length - (userIncluded ? 0 : 1);
    let count = 0;
    let average = 0;
    let ratings = new Map();

    ratingsData.forEach(rating => {
      if (rating.user_id != userId || userIncluded) {
        count += rating.count;
        average += parseFloat(rating.avg);  
      }
    });

    let averageRating = userCount != 0 ? average / userCount : 0;
    let averageCount = userCount != 0 ? count / userCount : 0;

    ratingsData.forEach(rating => ratings.set(rating.user_id, 
      (rating.avg * rating.count + averageRating * averageCount) / ( rating.count + averageCount))
    );

    applicationsData.forEach((application) => application.rating = ratings.get(application.applicant_id));
    ratingsData.averageRating = averageRating;
    ratingsData.averageCount = averageCount;
    
    sortRatings(applicationsData);
  }

  const updateRatings = (message) => {
    let data = [...applications];

    data.push({
      applicant_id: userId,
      job_id: jobId,
      message,
      username: userName,
    });

    const length = ratingsData.length;
    const currentUserData = ratingsData.filter((rating) => userId == rating.user_id)[0];
    const newAverage = (ratingsData.averageRating * (length-1) + parseFloat(currentUserData.avg)) / length;
    const newCount = (ratingsData.averageCount * (length-1) + currentUserData.count) / length;

    data.forEach((application) => {
      let rating = ratingsData.filter((rating) => rating.user_id == application.applicant_id)[0];
      application.rating = (rating.avg * rating.count + newAverage * newCount) / ( rating.count + newCount);
    });

    sortRatings(data);
  }

  const handleError = () => {
    setError('You have already applied for this job');
    window.setInterval(() => setError(''), 2000);
  }

  return (
    <>
      <DisplayAlert type={ALERT} message={error} />
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
        <ApplicationTableForm userId={userId} jobId={jobId} onSucess={updateRatings} onError={handleError} />
      </div>
    </>
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