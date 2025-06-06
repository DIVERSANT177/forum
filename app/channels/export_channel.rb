
class ExportChannel < ApplicationCable::Channel
  def subscribed
    stream_from "export_channel_#{current_user.id}"
  end
end
