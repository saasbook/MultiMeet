class ParticipantsMailer < ApplicationMailer
  default "Message-ID"=>"#{Digest::SHA2.hexdigest(Time.now.to_i.to_s)}@gmail.com"
  
  def availability_email(address, project_name, email_subject, email_body)
    @project_name = project_name
    @body = email_body
    @subject = "MultiMeet: " + email_subject
    mail(to: address, subject: @subject)
  end
end
