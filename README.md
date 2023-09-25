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
            POSTGRES_USER
            POSTGRES_DB
            POSTGRES_HOST
            POSTGRES_PASSWORD
            POSTGRES_TEST_DB
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

You should be now be able to launch the server

## Running the server
- `cd` into the project folder
- Run `rails server` or `rails s`
- The server will launch on the local machine on port 3000
- Go to http://localhost:3000 to access
- To play around with the homepage, edit *repo_path*/app/views/welcome/index.html.erb
  
