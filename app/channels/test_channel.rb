# app/channels/test_channel.rb
class TestChannel < ApplicationCable::Channel
  def subscribed
    stream_from "test_channel"
  end
end
