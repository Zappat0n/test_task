# Ofri.ch Test Task for Junior Developers

Build a Rails application with the following structure:
* Create a User model with the following attributes:
  * username
  * password
* Populate users table with 10 test users
* Create a Rating model with the following attributes:
  * rating_value (1 to 5)
  * user_id
* Populate rating table randomly
* Create the Job model with the following attributes:
  * title
  * timestamps
* Populate jobs table with 10 test jobs
* Create the JobApplication model with the following attributes & relationships
  * applicant_id (User)
  * job_id (Job)
  * message
## Functionality:

* Add /login page and simple authentication
  * auth fields:
    * username
    * password
  * if a user is logged in we should display the username at top of every page, otherwise, we add a link to the /login page
  * once the user is logged in, redirect it to the job index page
* Create a job index page ( /jobs ) where we have a list of jobs with URL to job show page
* Create a job show page ( /jobs/<id> ) with the following functionality:
  * preview job title
  * list of job applications for current job
  * input form for job application for the current user
    * it should have a field for the message
    * submit button
    * once a job application is submitted, it should be dynamically appended on the job application list without the need for
reloading. Note that you just need to append it on top of the list, so there is no need to order it at the moment.
* Once the job show is loaded, all job_applications for the job must be sorted
by user rating (highest first)
  * We calculate users ratings by the following formula rating = (R * v + C * m) / (v + m) where:
    * R - average rating_value of each rating for a particular user
    * v - number of ratings for a particular user
    * C - an average of all rating values of each user ( take R for each user and calculate average)
    * m - an average rating count of each user (take rating count for each user and calculate average)
## Configuration
* Clone the project to your local computer
* Run `bin/setup` to install the project locally
* The available users are in the file `db/seeds.rb`
* Run `rails server` to run the server
