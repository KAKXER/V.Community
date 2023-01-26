window.addEventListener("message", (event) => {
  switch (event.data.action) {
      case "DisplayUpdate":
          $("#Speedometer").css("opacity", event.data.opacity);
          break;
      case "FuelUpdate":
          $("#khat_fuel").css("width", event.data.fuel + "%");
          if (event.data.fuel >= 20) {
            $("#image_fuel").attr("src", "./iamge/image_fuel.png");
          } else {
            $("#image_fuel").attr("src", "./iamge/image_fuel_khamosh.png");
          }
          break;
      case "DamageUpdate":
        $("#khat_damage").css("width", event.data.damage + "%");
        if (event.data.damage >= 50) {
          $("#image_damage").attr("src", "./iamge/image_damage.png");
        } else {
          $("#image_damage").attr("src", "./iamge/image_damage_khamosh.png");
        }
        break;
      case "EngineSpeedUpdate":
   
        let EngineSource = (event.data.EngineSpeed * 9).toFixed(2);

        if (EngineSource >= 1.90) {
          $("#sabz_1").css("fill", "rgba(18,155,18,1)");
        } else {
          $("#sabz_1").css("fill", "rgba(54,72,17,0.502)");
        }
        
        if (EngineSource >= 2) {
          $("#sabz_2").css("fill", "rgba(18,155,18,1)");
        } else {
          $("#sabz_2").css("fill", "rgba(54,72,17,0.502)");
        }

        if (EngineSource >= 3) {
          $("#sabz_3").css("fill", "rgba(18,155,18,1)");
        } else {
          $("#sabz_3").css("fill", "rgba(54,72,17,0.502)");
        }

        if (EngineSource >= 4) {
          $("#sabz_4").css("fill", "rgba(18,155,18,1)");
        } else {
          $("#sabz_4").css("fill", "rgba(54,72,17,0.502)");
        }

        if (EngineSource >= 5) {
          $("#sabz_5").css("fill", "rgba(18,155,18,1)");
        } else {
          $("#sabz_5").css("fill", "rgba(54,72,17,0.502)");
        }

        if (EngineSource >= 5.5) {
          $("#sabz_6").css("fill", "rgba(18,155,18,1)");
        } else {
          $("#sabz_6").css("fill", "rgba(54,72,17,0.502)");
        }

        if (EngineSource >= 6) {
          $("#sabz_7").css("fill", "rgba(18,155,18,1)");
        } else {
          $("#sabz_7").css("fill", "rgba(54,72,17,0.502)");
        }

        if (EngineSource >= 6.5) {
          $("#sabz_8").css("fill", "rgba(18,155,18,1)");
        } else {
          $("#sabz_8").css("fill", "rgba(54,72,17,0.502)");
        }

        if (EngineSource >= 7) {
          $("#sabz_9").css("fill", "rgba(18,155,18,1)");
        } else {
          $("#sabz_9").css("fill", "rgba(54,72,17,0.502)");
        }

        if (EngineSource >= 7.5) {
          $("#naranji_1").css("fill", "rgba(255, 111, 0, 0.502)");
        } else {
          $("#naranji_1").css("fill", "rgba(121,58,11,0.502)");
        }

        if (EngineSource >= 7.8) {
          $("#naranji_2").css("fill", "rgba(255, 111, 0, 0.502)");
        } else {
          $("#naranji_2").css("fill", "rgba(121,58,11,0.502)");
        }

        if (EngineSource >= 8) {
          $("#naranji_3").css("fill", "rgba(255, 111, 0, 0.502)");
        } else {
          $("#naranji_3").css("fill", "rgba(121,58,11,0.502)");
        }

        if (EngineSource >= 8.2) {
          $("#naranji_4").css("fill", "rgba(255, 111, 0, 0.502)");
        } else {
          $("#naranji_4").css("fill", "rgba(121,58,11,0.502)");
        }

        if (EngineSource >= 8.4) {
          $("#naranji_5").css("fill", "rgba(255, 111, 0, 0.502)");
        } else {
          $("#naranji_5").css("fill", "rgba(121,58,11,0.502)");
        }

        if (EngineSource >= 8.5) {
          $("#ghermez_1").css("fill", "rgba(255, 34, 0, 0.502)");
        } else {
          $("#ghermez_1").css("fill", "rgba(89,22,12,0.502)");
        }

        if (EngineSource >= 8.6) {
          $("#ghermez_2").css("fill", "rgba(255, 34, 0, 0.502)");
        } else {
          $("#ghermez_2").css("fill", "rgba(89,22,12,0.502)");
        }

        if (EngineSource >= 8.7) {
          $("#ghermez_3").css("fill", "rgba(255, 34, 0, 0.502)");
        } else {
          $("#ghermez_3").css("fill", "rgba(89,22,12,0.502)");
        }

        if (EngineSource >= 8.8) {
          $("#ghermez_4").css("fill", "rgba(255, 34, 0, 0.502)");
        } else {
          $("#ghermez_4").css("fill", "rgba(89,22,12,0.502)");
        }

        if (EngineSource >= 8.9) {
          $("#ghermez_5").css("fill", "rgba(255, 34, 0, 0.502)");
        } else {
          $("#ghermez_5").css("fill", "rgba(89,22,12,0.502)");
        }

        if (EngineSource >= 9) {
          $("#ghermez_6").css("fill", "rgba(255, 34, 0, 0.502)");
        } else {
          $("#ghermez_6").css("fill", "rgba(89,22,12,0.502)");
        }

        break;
      case "SpeedUpdate":
        $("#speed").text(event.data.speed);
        break;
      case "EngineUpdate":  
        if (event.data.engine == 1) {
          $("#image_engine").attr("src", "./iamge/image_engine_roshan.png");
        } else {
          $("#image_engine").attr("src", "./iamge/image_engine.png");
        }
        break;
      case "LockUpdate":  
        if (event.data.lock == 1) {
          $("#image_lock").attr("src", "./iamge/image_lock.png");
        } else {
          $("#image_lock").attr("src", "./iamge/image_lock_roshan.png");
        }
        break;
      case "LightUpdate":  
        if (event.data.light == 1) {
          $("#image_light").attr("src", "./iamge/image_light_roshan.png");
        } else {
          $("#image_light").attr("src", "./iamge/image_light.png");
        }
        break;
      case "SeatBeltUpdate":  
        if (event.data.seatbelt) {
          $("#image_seatbelt").attr("src", "./iamge/image_seatbelt.png");
        } else {
          $("#image_seatbelt").attr("src", "./iamge/image_seatbelt_roshan.png");
        }
        break;
      }
  }    
)
