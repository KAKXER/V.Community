window.addEventListener("message", (event) => {
    switch (event.data.action) {
        case "DisplayUpdate":
            $("#Display").css("opacity", 1);
            $("#image").attr("src", event.data.imageprofile);
            $("#imagejob").attr("src", "./image/" + event.data.jobprofile + ".png");
            break;
        }
    }    
)
