window.addEventListener("message", (event) => {
    switch (event.data.action) {
        case "DisplayUpdate":
            $("#Display").css("opacity", event.data.opacity);
            break;
        case "updateInfo":
            let dt = event.data.data;
            $('#ID_AND_PLAYERS').text("300/" + dt.players + " players | ID: " + event.data.id + " | Admin: " + dt.admins);
            $('#Police').text("Police: " + dt.police);
            $('#Medic').text("Medic: " + dt.ambulance);
            $('#Taxi').text("Taxi: " + dt.taxi);
            $('#Mechanic').text("Mechanic: " + dt.mecano);
            $('#Sheriff').text("Sheriff: " + dt.sheriff);
            $('#Weazel').text("Weazel: " + dt.weazel);
            $('#Doc').text("Doc: " + dt.doc);
            break;
        case "updateAdmin":
            $("#DisplayAdmin").css("opacity", event.data.onduty);
            break;
        }
    }    
)
