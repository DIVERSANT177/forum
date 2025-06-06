import consumer from "channels/consumer";

consumer.subscriptions.create("TestChannel", {
    connected() {
        console.log("Подключились к TestChannel")
    },

    disconnected() {
        console.log("Отключились от TestChannel")
    },

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
});