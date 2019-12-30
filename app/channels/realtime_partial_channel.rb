class RealtimePartialChannel < ApplicationCable::Channel
  def subscribed
    stream_for params[:key]
  end
end