# [NIKI] Continuing Education Credits Tracker

## Project Description
We intend to build a web-app that allows Professional Engineers (PEs) to track their continuing education credits every year to ensure they meet the requirements in case of an audit.

## Setup
**Using DockerFile for installations**
- Ensure you have docker installed on your machine as per your Operating System:
    - Follow instructions on  https://docs.docker.com/engine/install/ to install docker
- Install docker-compose using https://docs.docker.com/engine/install/
- To run the project, follow the following steps:
    - To build the project and install all dependencies:
      - `docker-compose build`
    - To spin up the container and run rails server:
      - `docker-compose up`
    - Visit 'http://localhost:3001' to see the app running (port mapped to 3001 on host machine)

**Instructions below were done on Ubuntu 22.04, 4GB RAM, 20GB storage**
- Install updates and build essentials
  - `sudo apt-get update`
  - `sudo apt-get upgrade`
  - `sudo apt install build-essential`
- Install Git: `sudo apt-get install git-all`
- Install prerequisites for Ruby and Ruby on Rails
  - PostgreSQL: `sudo apt install postgresql postgresql-contrib`
    - To start the service: `sudo systemctl start postgresql.service`
    - Setup PostgreSQL on your machine: Install the latest version of PostgreSQL based on your operating system.
    - Log into the PostgreSQL account: `sudo -i -u postgres` followed by `psql`
    - Create a role (suppose 'credittrackeradmin') with the ability to create databases using `CREATE ROLE credittrackeradmin WITH CREATEDB;`
    - Allow the 'credittrackeradmin' role to log in: `ALTER ROLE credittrackeradmin WITH LOGIN;`
    - Create a .env file in the /niki directory and set the values for the following PostgreSQL environment variables:
      ```
        - POSTGRES_USER = credittrackeradmin
        - POSTGRES_DB = development
        - POSTGRES_HOST = localhost # normally localhost, could be something else if you're not accessing the local db
        - POSTGRES_PASSWORD = *insert your password*
        - POSTGRES_TEST_DB = test
      ```
    - Create database and then run migrations on it
        - rake db:create
        - rake db:migrate
    - Do `rails active_storage:install`
    - rails db:migrate
    - Run the server using the command: rails s
    - If you encounter the following error: "password authentication failed for user credittrackeradmin," you can change the user's password in PostgreSQL:
    - Alter the password for the user 'credittrackeradmin' using the following command: `ALTER USER credittrackeradmin PASSWORD 'new_password';`
  - Node.js
    - Follow instructions for your OS here https://github.com/nodesource/distributions
  - Yarn: `npm install --global yarn`
- Clone the GitHub repo: `git clone https://github.com/CSCE606-NIKI/niki`
- `cd` into the project folder
- Install rbenv with ruby-build: `curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash`
- Add the following lines to the ~/.bashrc file
    ```
    # rbenv
    eval "$(/home/*your_username*/.rbenv/bin/rbenv init - -bash)"
    ```
- Restart the terminal, `cd` back into the project repo
- Reload profile: `source ~/.bashrc`
- Install Ruby 3.x.y: `rbenv install 3.x.y`
  - 3.x.y is the version of ruby specified in the Gemfile (currently 3.2.2)
  - Takes 5-10 minutes
- Set Ruby 3.x.y as the local default version `rbenv local 3.x.y`
- Install bundler: `gem install bundler`
- Configure bundler to skip production gems: `bundle config set --local without 'production'`
- Install dependencies: `bundle install`
- Install JavaScript base files: `rails javascript:install:esbuild`
- Skip Heroku steps below if you just wanna run the Rails server locally
  - Install Heroku CLI: `curl https://cli-assets.heroku.com/install-ubuntu.sh | sh`
  - Login to Heroku: `heroku login`
- If ActionMailer doesn't work in development phase, then we need to reset SMTP credentials:
  - Run: 'EDITOR=vim rails credentials:edit'
  - Delete previous config/credential.yml.enc and config/master.key file and run the above command again either using vim or nano editor
  - Set the email and passkey for the app and save it.

You should be now be able to launch the server

## Running the server
- `cd` into the project folder
- Run `rails server` or `rails s`
- The server will launch on the local machine on port 3000
- Go to http://localhost:3000 to access
- To play around with the homepage, edit *repo_path*/app/views/welcome/index.html.erb

## To check code coverage
- Run `bundle exec cucumber` or `bundle exec rspec`
- Redirect to coverage/ , you can view index.html 

## Heroku app link and deployment process:
- `https://csce606-niki-a5715460073c.herokuapp.com/`
- To deploy our app in heroku follow the below steps:
  - Login to heroku: `heroku login``
  - check your connection to heroku with `git remote`, you should be able to see heroku along with git for successful login
  - If you are planning to deploy on a new app, create one using: `heroku create APP_NAME`
  - If you don't have a database set up on heroku, try following this: https://elements.heroku.com/addons/heroku-postgresql by selecting a Miniplan (If using our heroku app, this step is not required).
  - For deploying in an existing app, go to heroku > your app > settings, you should be able to find a heroku git URL
  - Our heroku git URL: `https://git.heroku.com/csce606-niki.git`
  - Now use command: `git remote add heroku {heroku git URL}`
  - You can now check status using `git status` and commit changes using `git add .` and `git commit -m "message"``
  - Push this change into heroku: `git push heroku main`` (you can also create a branch in heroku similar to git)
  - Once the build is successful, run:
    - `heroku run rails db:migrate`
    - `heroku run rails db:seed`
    - 'heroku config:set RAILS_MASTER_KEY=`cat config/master.key`' 

## Contact Information:
- email: nikicreditstracker@gmail.com
- If you have any questions or need troubleshooting assistance, feel free to reach out to us at above email. This email is shared among all team members, and we will respond to your inquiries as promptly as we can.
