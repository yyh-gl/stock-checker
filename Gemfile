# coding: utf-8
ruby '2.5.1'

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'nokogiri'
gem 'dotenv-rails', require: 'dotenv/rails-now'
gem 'slack-notifier'
