class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end

  def new
    @message = Message.new
    @contacts = Contact.all
  end

  def create

    from = params[:from]
    body = params[:body]
    @senders = params[:to][:contact_phone_numbers]

    @senders.each do |sender|
      @sent_message = Message.new({:to => sender, :from => from, :body => body})
      if @sent_message.save
        flash[:notice] = "Your message was sent!"
      else
        flash[:notice] = "You dumb"
      end
    end
    redirect_to messages_path
  end

  def show
    @message = Message.find(params[:id])
  end

  # private
  # def message_params
  # params.require(:message).permit(:to, :from, :body)
  # end
end
