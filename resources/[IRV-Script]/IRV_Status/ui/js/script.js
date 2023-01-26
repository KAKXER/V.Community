window.addEventListener("message", (event) => {
    switch (event.data.action) {
        case "DisplayUpdate":
            $("#Display").css("opacity", event.data.opacity);
            if (event.data.opacity == 1) {
                $("#Mic").css("left", "95.885vw");
                $("#Radio").css("left", "95.885vw");
                $("#Gang").css("left", "91.771vw");
                $("#Job").css("left", "90.938vw");
                $("#Heal").css("left", "86.875vw");
                $("#Armor").css("left", "90vw");
                $("#Ghaza").css("left", "93.125vw");
                $("#Ab").css("left", "96.25vw");
            } else {
                $("#Mic").css("left", "100.885vw");
                $("#Radio").css("left", "100.885vw");
                $("#Gang").css("left", "100.885vw");
                $("#Job").css("left", "100.885vw");
                $("#Heal").css("left", "100.885vw");
                $("#Armor").css("left", "100.885vw");
                $("#Ghaza").css("left", "100.885vw");
                $("#Ab").css("left", "100.885vw");
            }
            break;
        case "Data2Update":
            $("#HealGhermez").css("width", event.data.Health + "%");
            $("#ArmorSabz").css("width", event.data.Armor + "%");
            break;
        case "talking":
            if ( event.data.data.talking ) {
                $("#AdadAntenMic").css("color", "#00ca0a");
                $("#LogoMic").attr("src", "./image/LogoMicON.png");
            } else {
                $("#AdadAntenMic").css("color", "#ffffff");
                $("#LogoMic").attr("src", "./image/LogoMic.png");
            }
            if ( event.data.data.radio ) {
                $("#AdadAntenRadio").css("color", "#00ca0a");
                $("#LogoAntenRadio").attr("src", "./image/LogoAntenRadioON.png");
            } else {
                $("#AdadAntenRadio").css("color", "#ffffff");
                $("#LogoAntenRadio").attr("src", "./image/LogoAntenRadio.png");
            }
            break;
        case "radioFreq":
            if ( event.data.data.enabled ) {
                $("#AdadAntenRadio").text(event.data.data.channel);
            } else {
                $("#AdadAntenRadio").text("OFF");
            }
            break;      
        case "DataUpdate":
            let hunger = event.data.data[0].percent;
            let thirst = event.data.data[1].percent;
            $("#GhazaNaranji").css("width", hunger + "%");
            $("#AbAbi").css("width", thirst + "%");
            break;
        case "voiceRange":
            if ( event.data.data == 1 ) {
                $("#AdadAntenMic").text("25");
            } else if ( event.data.data == 2 ) {
                $("#AdadAntenMic").text("50");
            } else if ( event.data.data == 3 ) {
                $("#AdadAntenMic").text("100");
            }
            break;            
    case "JobUpdate":
            let job = event.data.Job;
            if (job.name == "nojob") {
                $("#TextJob").css("opacity","0");
                $("#LogoJob").css("opacity","0");
                $("#BackTextJob").css("opacity","0");

                $("#TextGang").css("top","-1.75vw");
                $("#LogoGang").css("top","-2.4vw");
                $(".BackTextGang").css("top","-2.4vw");
            } else {
                $("#TextJob").css("opacity","1");
                $("#LogoJob").css("opacity","1");
                $("#BackTextJob").css("opacity","1");

                $("#TextGang").css("top","0.677vw");
                $("#LogoGang").css("top","0vw");
                $(".BackTextGang").css("top","0.104vw");
            }
            if (job.grade < 0) {
                $("#TextJob").text(job.grade_label);
                $("#LogoJob").attr("src", "./image/job/" + job.name + ".png");
        
            } else {
                $("#TextJob").text(job.grade_label);
                $("#LogoJob").attr("src", "./image/job/" + job.name + ".png");
            }
            break;
        case "GangUpdate":
            let gang = event.data.GangInfo;
            if (gang.name == "nogang") {
                $("#TextGang").css("opacity","0");
                $("#LogoGang").css("opacity","0");
                $("#BackTextGang").css("opacity","0");
            } else {
                $("#TextGang").css("opacity","1");
                $("#LogoGang").css("opacity","1");
                $("#BackTextGang").css("opacity","1");
            }
        
            $("#TextGang").text(gang.grade_label);
        
            if (gang.name == "Mafia") {
                $("#LogoGang").attr("src", "./image/gang/" + gang.name + ".png");
            } else {
                $("#LogoGang").attr("src", "./image/gang/gang.png");
            }
            break;
        }
        if (event.data.action == "UpdateGangIcon") {
            $("#LogoGang").attr("src", event.data.NewIcon);
        }
        if (event.data.action == "indicator"){
			updateIndicator(event.data.value);
	    }
        function updateIndicator(talkings){
            $('.indicator').html('');

    

            for (let [id, data] of Object.entries(talkings)) {
                $('.indicator').append(`<tr><td>${data.alias}</td><td><img class="w-100" src="./image/Radio.png"></td></tr>`);
            }
        }	
    }    
)
