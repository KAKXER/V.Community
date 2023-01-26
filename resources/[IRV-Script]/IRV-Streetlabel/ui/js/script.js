window.addEventListener("message", (event) => {
    switch (event.data.action) {
        case "DisplayUpdate":
            $("#Display").css("opacity", event.data.opacity);

            if (event.data.ms == "SW" || event.data.ms == "NW") {
                $('#respansive_3S').css("left", "21.615vw"); 
            } else if (event.data.ms == "NE" || event.data.ms == "SE") {
                $('#respansive_3S').css("left", "20.313vw"); 
            } else if (event.data.ms== "S" || event.data.ms == "N" || event.data.ms == "E") {
                $('#respansive_3S').css("left", "18.646vw"); 
            } else if (event.data.ms == "W") {
                $('#respansive_3S').css("left", "19.531vw"); 
            }
            $('#S').text(event.data.ms); 
            $('#Innocence_blvd').text(event.data.zone); 
            $('#Strawberry').text(event.data.street); 
            $('#n_52').text(event.data.time); 
            break;
        }
    }    
)