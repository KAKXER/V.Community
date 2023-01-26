Config = []

Config.Webhook = "https://discord.com/api/webhooks/1063948420273930251/rUc-rh34UtQRqnzFYCxVBKPHklCMkHCotQ5X1-LG9-6JfeOKEcRjthXU2yi6BfmsaVA1" // Set your own discord Webhook here.

// Ignore this line, it's just the alert for you to add your webhook.
if (Config.Webhook == '') {
    $.post('http://qs-videos/Log', JSON.stringify({
        msg: "[qs-videos] Missing webhook inside qs-videos/config/config.js."
    }))
}