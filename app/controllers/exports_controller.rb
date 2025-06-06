class ExportsController < ApplicationController
  before_action :authenticate_user!
  def download
    filename = params[:filename]
    file_path = Rails.root.join("tmp", filename)
    file_path = file_path.sub_ext(".#{params[:format]}")
    if File.exist?(file_path)
      send_file file_path, filename: "экспорт_вопросов_#{Time.now.strftime('%Y%m%d')}.csv", type: "text/csv"
    else
      flash[:alert] = "Файл не найден"
      redirect_to root_path
    end
  end
end
