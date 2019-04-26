# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'multimeetemailer@gmail.com'
  layout 'mailer'
end
