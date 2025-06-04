import consumer from "channels/consumer"

consumer.subscriptions.create("AnswerChannel", {
  connected() {
    console.log("Подключились к AnswerChannel")
  },

  disconnected() {
    console.log("Отключились от AnswerChannel")
  },

  received(data) {
    console.log("Получили данные через WebSocket:", data)

    const container = document.getElementById("answers")

    const currentUserID = window.currentUserId

    if (data.user_id === currentUserID) return

    if (container) {
      // Вставляем новый вопрос в начало списка
      container.insertAdjacentHTML("afterend", data.answer_html)
    }
  }
});
