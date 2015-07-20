class Message < ActiveRecord::Base
  before_create :send_sms

private
 def send_sms
   begin
    response = RestClient::Request.new(

     :method => 'post',
     :url => 'https://api.twilio.com/2010-04-01/Accounts/ACb4bc7a4c7170342f76dfe65c4fde1d91/Messages.json',
     :user => ENV['TWILIO_ACCOUNT_SID'],
     :password => ENV['TWILIO_AUTH_TOKEN'],
     :payload => { :Body => body,
                    :From => from,
                    :To => to          }
      ).execute
    rescue RestClient::BadRequest => error
      message = JSON.parse(error.response)['message']
      errors.add(:base, message)
      false
    end
  end
end
