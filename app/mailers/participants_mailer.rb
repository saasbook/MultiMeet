class ParticipantsMailer < ApplicationMailer
  default "Message-ID"=>"#{Digest::SHA2.hexdigest(Time.now.to_i.to_s)}@gmail.com"

  # so we don't have > 4 arguments (CodeClimate)
  def set_project_name(project_name)
    @project_name = project_name
  end

  def availability_email(address, email_subject, email_body, rank_link)
    @body = email_body
    @subject = "MultiMeet: " + email_subject
    @rank_link = rank_link
    mail(to: address, subject: @subject)
  end

  def matching_email(address, email_subject, email_body, project_time)
    @body = email_body
    @subject = "MultiMeet: " + email_subject
    @project_time = project_time
    mail(to: address, subject: @subject)
  end
end
