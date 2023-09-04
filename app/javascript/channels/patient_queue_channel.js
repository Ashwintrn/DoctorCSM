import consumer from "channels/consumer"

consumer.subscriptions.create("PatientQueueChannel", {
  connected() {
    console.log("connected to ac");
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log("in patint js: "+data.token);
    document.getElementById("current-token").innerText = data.token;
  }
});
