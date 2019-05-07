# frozen_string_literal: true

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

ENV['MAILER_EMAIL']='multimeetemailer@gmail.com'
ENV['MAILER_PASSWORD']='ilove169!'

require 'bundler/setup' # Set up gems listed in the Gemfile.
