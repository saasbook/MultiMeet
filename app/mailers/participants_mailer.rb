# frozen_string_literal: true

class ParticipantsMailer < ApplicationMailer
  def availability_email(email)
    @email = email
    mail(to: @email, subject: 'Choose Availabilities for project')
  end
end
