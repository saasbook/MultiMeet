class ParticipantsMailer < ApplicationMailer
  default "Message-ID"=>"#{Digest::SHA2.hexdigest(Time.now.to_i.to_s)}@gmail.com"

  def availability_email(part_id, proj_id, address, secret_id, project_name, email_subject, email_body)
    @part_id = part_id
    @proj_id = proj_id
    @project_name = project_name
    @body = email_body
    @subject = "MultiMeet: " + email_subject
    @secret_id = secret_id
    mail(to: address, subject: @subject)
  end
  def matching_email(address, project_name, email_subject, email_body, project_time)
    @project_name = project_name
    @body = email_body
    @subject = "MultiMeet: " + email_subject
    @project_time = project_time
    mail(to: address, subject: @subject)
  end
end
