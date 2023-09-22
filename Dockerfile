#base-image as ruby version 3.2.2
FROM ruby:3.2.2 

#install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

#create a folder niki and set that as our working directory
RUN mkdir /niki
WORKDIR /niki

#Add all of them to our container
ADD . /niki


#Copy the Gemfile & Gemfile.lock from our directory to the working directory in our container
ADD Gemfile /niki/Gemfile
ADD Gemfile.lock /niki/Gemfile.lock

#Run bundle install to install all dependencies
RUN bundle install

