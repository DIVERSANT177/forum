import consumer from "channels/consumer"

consumer.subscriptions.create("QuestionChannel", {
  connected() {
    console.log("Подключились к QuestionChannel")
  },

  disconnected() {
    console.log("Отключились от QuestionChannel")
  },

  received(data) {
    console.log("Получили данные через WebSocket:", data)

    const container = document.getElementById("questions")

    if (container) {
      // Вставляем новый вопрос в начало списка
      container.insertAdjacentHTML("afterbegin", data.question_html)
    }
  }
});
