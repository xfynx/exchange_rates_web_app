App.exchange_rate_updates = App.cable.subscriptions.create("ExchangeRateUpdatesChannel", {
    connected: function () {
        console.log('CONNECTED!')
    },

    disconnected: function () {
        return this.perform('unfollow');
    },

    received: function (data) {
        document.getElementById('exchange_rates').innerHTML = data.html;
    }
});
