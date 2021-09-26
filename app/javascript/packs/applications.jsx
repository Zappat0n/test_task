import React from 'react'
import ReactDOM from 'react-dom'
import ApplicationTable from "../components/ApplicationTable"

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('application-data');
  console.log(node);
  const props = JSON.parse(node.getAttribute('data-react-props'));
  
  ReactDOM.render(
    <ApplicationTable {...props} />,
    document.getElementById('root')
  )
})
