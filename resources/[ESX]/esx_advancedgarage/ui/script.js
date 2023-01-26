let template = '';

$(document).ready(function() {
    template = $('#item-template').html();
    $('#item-template').remove();
});

$(function() {
    window.addEventListener('message', function(event) {
        if (event.data.type === "display") {
            $('.auto-insurance').fadeIn();
            loadShit(event.data.data.data, event.data.data.station);
        } else if (event.data.type === "close") {
            $('.auto-insurance').fadeOut();
        }
    });
});

function loadShit(vehicles, station) {
    $("#carsConteiner").html('');
    for (let key in vehicles) {
        if (vehicles.hasOwnProperty(key)) {
            var vehicle = vehicles[key];
            vehicle.vehicle.type = vehicle.vehicle.type.toUpperCase();
            vehicle.buttonText = 'DARYAFT';
            vehicle.cost = '$' + vehicle.cost;
            if (vehicle.policei == true) {
                if (station === "LosSantos") {
                    vehicle.policeAlert = 'display: block';
                    vehicle.buttonText = 'IMPOUND';
                    vehicle.cost = '';
                    vehicle.buttonClass = 'policei-button buttonDisabled';
                    vehicle.showPrice = 'display:none;';
                    vehicle.cdTime = `Contact Police!`;
                    $("#carsConteiner").append(Mustache.render(template, vehicle));
                } 
            } else if (vehicle.sheriffi == true) {
                if (station === "Paleto") {
                    vehicle.policeAlert = 'display: block';
                    vehicle.buttonText = 'IMPOUND';
                    vehicle.cost = '';
                    vehicle.buttonClass = 'sheriffi-button buttonDisabled';
                    vehicle.showPrice = 'display:none;';
                    vehicle.cdTime = `Contact Sheriff!`;
                    $("#carsConteiner").append(Mustache.render(template, vehicle));
                }
            } else if (vehicle.cooldown == 0) {
                vehicle.onclick = `Revive('${vehicle.vehicle.plate}','${vehicle.vehicle.type}','${vehicle.vehicle.name}','${vehicle.vehicle.damage}','${vehicle.vehicle.cost}','${vehicle.vehicle.vehicle1}')`;
                vehicle.buttonClass = 'retrieve-button';
                $("#carsConteiner").append(Mustache.render(template, vehicle));
            } else {
                vehicle.buttonClass = 'retrieve-chop-button buttonDisabled';
                vehicle.buttonText = 'COOLDOWN';
                vehicle.cdTime = `Cooldown ta ${vehicle.cooldown} Saat`;
                vehicle.showPrice = 'display:none;';
                $("#carsConteiner").append(Mustache.render(template, vehicle));
            }
        }
    }
}

function Revive(plate, type, model, damage, cost, vehicle1) {
    var obj = { "plate": plate, "type": type, "model": model, "damage": damage, "cost": cost, "vehicle1": vehicle1 };
    $.post("http://esx_advancedgarage/reviveCar", JSON.stringify(obj), function() {});
    Exit();
}

function Exit() {
    $('.auto-insurance').fadeOut();
    $.post("http://esx_advancedgarage/close", true, function() {});
}