import consumer from "channels/consumer";

consumer.subscriptions.create({ channel: "ExportChannel" }, {
  received(data) {
    if (data.action === 'download_ready') {
      const link = document.createElement('a');
      link.href = data.file_url;
      link.download = 'экспорт_вопросов.csv';
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
    }
  }
  // received(data) {
  //     if (data.message) {
  //       const output = document.getElementById('worker-output');
  //       output.innerText = data.message;
  //     }
  //   }
});