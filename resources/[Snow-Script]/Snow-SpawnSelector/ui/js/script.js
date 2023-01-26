window.addEventListener("message", (event) => {
    switch (event.data.action) {
        case "DisplayUpdate":
            let dt = event.data;
            $("#Display").css("opacity", 1.0);

            $("#Players").text("Time Play Shoma "+ dt.timeplay + "  saat ast");

            if (dt.timeplay >= 1){
            
                $("#Text_PD").text("Shoma Mitavanid Roye Police Teleport Konid");
                $("#Image_PD_").attr("src", "image/Image_Tik.png");
                $("#Police_Department").css("color", "rgba(201,201,201,1)");
            } else {
                $("#Image_Back_Police_Department").css("filter", "drop-shadow(0vw 0.156vw 20vw rgba(0, 0, 0, 1)) blur(0.26vw)");
                $("#Text_PD").text("TimePlay Shoma Paiin ast.");
                $("#Image_PD_").attr("src", "image/Image_Ghofl.png");
                $("#Police_Department").css("color", "rgb(215 47 47)");
            }

            if (dt.timeplay >= 2){
                $("#Text_Ambulance").text("Shoma Mitavanid Roye Ambulance Teleport Konid");
                $("#Image_Ambulance").attr("src", "image/Image_Tik.png");
                $("#Ambulance").css("color", "rgba(201,201,201,1)");
            } else {
                $("#Image_Back_Ambulance_").css("filter", "drop-shadow(0vw 0.156vw 20vw rgba(0, 0, 0, 1)) blur(0.26vw)");
                $("#Text_Ambulance").text("TimePlay Shoma Paiin ast.");
                $("#Image_Ambulance").attr("src", "image/Image_Ghofl.png");
                $("#Ambulance").css("color", "rgb(215 47 47)");
            }

            if (event.data.timeplay >= 3){
                $("#Text_Sandy_Shores").text("Shoma Mitavanid Roye SandyShore Teleport Konid");
                $("#Image_Sandy_Shores").attr("src", "image/Image_Tik.png");
                $("#Sandy_Shores").css("color", "rgba(201,201,201,1)");
            } else {
                $("#Image_Back_Sandy_Shores").css("filter", "drop-shadow(0vw 0.156vw 20vw rgba(0, 0, 0, 1)) blur(0.26vw)");
                $("#Text_Sandy_Shores").text("TimePlay Shoma Paiin ast.");
                $("#Image_Sandy_Shores").attr("src", "image/Image_Ghofl.png");
                $("#Sandy_Shores").css("color", "rgb(215 47 47)");
            }

            if (dt.timeplay >= 0){
                $("#Text_Hotel").text("Shoma Mitavanid Roye SandyShore Teleport Konid");
                $("#Image_Hotel").attr("src", "image/Image_Tik.png");
                $("#Hotel").css("color", "rgba(201,201,201,1)");
            } else {
                $("#Image_Back_Hotel").css("filter", "drop-shadow(0vw 0.156vw 20vw rgba(0, 0, 0, 1)) blur(0.26vw)");
                $("#Text_Hotel").text("TimePlay Shoma Paiin ast.");
                $("#Image_Hotel").attr("src", "image/Image_Ghofl.png");
                $("#Hotel").css("color", "rgb(215 47 47)");
            }

            break;
        case "close":
            $("#Display").css("opacity", 0.0);
            break;
        }
    }    
)

$(document).keyup((e) => {
    if (e.key === "Escape") {
        $.post('https://Snow-SpawnSelector/close', JSON.stringify({}));
    }
});

$(function() {
    // ambulance
    $("#Image_Back_Ambulance_").click((e) => {
        $.post('https://Snow-SpawnSelector/sendteleport', JSON.stringify("ambulance"));
    })

    $("#Text_Ambulance").click((e) => {
        $.post('https://Snow-SpawnSelector/sendteleport', JSON.stringify("ambulance"));
    })

    $("#Image_Ambulance").click((e) => {
        $.post('https://Snow-SpawnSelector/sendteleport', JSON.stringify("ambulance"));
    })

    // police
    $("#Image_Back_Police_Department").click((e) => {
        $.post('https://Snow-SpawnSelector/sendteleport', JSON.stringify("police"));
    })

    $("#Text_PD").click((e) => {
        $.post('https://Snow-SpawnSelector/sendteleport', JSON.stringify("police"));
    })

    $("#Image_PD_").click((e) => {
        $.post('https://Snow-SpawnSelector/sendteleport', JSON.stringify("police"));
    })

    // SandyShores
    $("#Image_Back_Sandy_Shores").click((e) => {
        $.post('https://Snow-SpawnSelector/sendteleport', JSON.stringify("SandyShores"));
    })

    $("#Text_Sandy_Shores").click((e) => {
        $.post('https://Snow-SpawnSelector/sendteleport', JSON.stringify("SandyShores"));
    })

    $("#Image_Sandy_Shores").click((e) => {
        $.post('https://Snow-SpawnSelector/sendteleport', JSON.stringify("SandyShores"));
    })

    // hotel
    $("#Image_Back_Hotel").click((e) => {
        $.post('https://Snow-SpawnSelector/sendteleport', JSON.stringify("hotel"));
    })

    $("#Text_Hotel").click((e) => {
        $.post('https://Snow-SpawnSelector/sendteleport', JSON.stringify("hotel"));
    })

    $("#Image_SaImage_Hotelndy_Shores").click((e) => {
        $.post('https://Snow-SpawnSelector/sendteleport', JSON.stringify("hotel"));
    })

    // Close

    $("#Dokme_Bastan").click((e) => {
        $.post('https://Snow-SpawnSelector/close', JSON.stringify({}));
    })

    // $("#SPAWN").click((e) => {
    //     $.post('https://Snow-SpawnSelector/close', JSON.stringify({}));
    // })

    // $("#Dokme_Spawn").click((e) => {
    //     $.post('https://Snow-SpawnSelector/close', JSON.stringify({}));
    // })
});