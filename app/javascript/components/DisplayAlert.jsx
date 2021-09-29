import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'

export const NOTICE = 0;
export const ALERT = 1;

const DisplayAlert = ({type, message}) => {
  return (
    <>
      { message != '' ?
        (type == NOTICE ? (
          <div className="alert alert-info text-center">
            {message}
          </div>
        ) : (
          <div className="alert alert-danger text-center">
            {message}
          </div>
        )) : null
      }
    </>
  );
}

DisplayAlert.propTypes = {
  type: PropTypes.string.isRequired,
  message: PropTypes.string.isRequired,
}

export default DisplayAlert;