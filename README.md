# [NIKI] Continuing Education Credits Tracker

## Project Description
We intend to build a web-app that allows Professional Engineers (PEs) to track their continuing education credits every year to ensure they meet the requirements in case of an audit.

## Setup
**Instructions below were done on Ubuntu 22.04, 4GB RAM, 20GB storage**
- Install updates and build essentials
  - `sudo apt-get update`
  - `sudo apt-get upgrade`
  - `sudo apt install build-essential`
- Install Git: `sudo apt-get install git-all`
- Install prerequisites for Ruby and Ruby on Rails
  - SQLite3: `sudo apt install sqlite3`
  - Node.js
    - Follow instructions for your OS here https://github.com/nodesource/distributions
  - Yarn: `npm install --global yarn`
- Clone the GitHub repo: `git clone https://github.com/CSCE606-NIKI/niki`
- `cd` into the project folder
- Install rbenv with ruby-build: `curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash`
- Add the following lines to the ~/.bashrc file
    ```
    \# rbenv
    eval "$(/home/*your_username*/.rbenv/bin/rbenv init -bash)"
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
  
