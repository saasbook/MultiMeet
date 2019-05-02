Then /the user "(.*)" should receive a matching email with the correct timestamp "(.*)"/ do |user_email, timestamp|
  # this will get the first email, so we can check the email headers and body.
  email = ActionMailer::Base.deliveries.first
  email.from[0].should == "multimeetemailer@gmail.com"
  email.to[0].should == user_email
  email.body.should include(timestamp)
end