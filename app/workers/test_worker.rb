require "csv"
class TestWorker
  include Sidekiq::Worker

  def perform(user_id)
    # puts "✅ Воркер запущен! Привет от пользователя с ID = #{user_id}"

    # sleep 3

    # puts "✅ Воркер завершил выполнение"
    # ActionCable.server.broadcast("test_channel", {
    #   message: "Задача успешно выполнена!"
    # })
    # user = User.find_by(id: user_id)
    questions = Question.all

    # Генерируем CSV
    csv_data = ::CSV.generate do |csv|
      csv << [ "ID", "Текст вопроса", "Тело вопроса", "Дата создания" ]
      questions.each do |question|
        csv << [ question.id, question.title, question.body, question.created_at ]
      end
    end

    # Сохраняем во временный файл
    file_path = Rails.root.join("tmp", "questions_export_#{user_id}_#{Time.now.to_i}.csv")
    File.write(file_path, csv_data)



    # Отправляем событие через ActionCable
    ActionCable.server.broadcast(
      "test_channel",
      {
        action: "download_ready",
        file_url: "/system/temp_csv/#{File.basename(file_path)}"
      }
    )

    # Через несколько секунд удаляем файл (опционально)
    # sleep 10
    # File.delete(file_path) if File.exist?(file_path)
  rescue => e
    Rails.logger.error "Ошибка при экспорте: #{e.message}"
  end
end
