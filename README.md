# Juicymo project manager

## About 
Juicymo project manager is open source web application written in Ruby on Rails. I have created this application as part of job interview to prove level of my knowledge in Ruby on Rails framework.

## Prerequisites 
To make this application work, you need working Ruby environment with version at least 3.1 and working Postgres database.

## Setup 
Follow these steps in order to start application:

1) create `.env` file based on [.env.example](.env.example)
2) load this file in terminal with command `source .env`
3) install dependencies with `bundle install`
4) create database (unless already exists) with `bundle exec rails db:create`
5) import database migrations with `bundle exec rails db:migrate`
6) *this step is optional*: Seed database with data by executing `bundle exec rails db:seed`
7) start server with `bundle exec rails s -p 3000`
8) you can now access web app in your browser on http://localhost:3000
