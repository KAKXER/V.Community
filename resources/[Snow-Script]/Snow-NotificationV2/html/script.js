var i = 100;
var visible = false
var notifs = 0
var DefSound = true
var CSound = true
var Title = true
var audioVol = 0.2
var NotifOpacity = 100
let notifications = $("#list");
let notifsinuse = [];
var notification = ``
var DocCSound = document.getElementById("CSound").dataset.numberlk
var DocDSound = document.getElementById("DSound").dataset.numberlk
var DocTitle = document.getElementById("Title").dataset.numberlk
let id = 0

function LoadNotifiction(opacity, title, description, israder, duration,type) {
	if (id < 5){
	var transformcss = `translateY(0px)`;
	id++;
notification = `<div id="ui-${id}" style="transform: ${transformcss};position: absolute;bottom: 22vh;left: 1.5%;width: 50ch;overflow: hidden;display: none;">
					<div id="notiftext-${id}" style="transform: translateX(-200%);height: 70px;">
						<div id="titlenotif-${id}" style="font-family: fantasy;color: #eff1f2;text-shadow: 0px 0px 5px #eff1f2;position: absolute;top: 0px;padding-left: 15px;font-family: 'Segoe UI';font-weight: bold;
						font-size: 18px;">NOTIFICATION</div>
						<div id="descrnotif-${id}" style = "position: absolute;top: 27px;width: 30ch;font-family: sans-serif;padding-left: 15px;line-height: 20px;color: white;">This is a test notification from a new resource</div>
					</div>
					<div id="leftnotif-${id}" style = "position: absolute;bottom: 0px;width: 7px;height: 80px;background-color: #00f5e8;border-radius: 20px;"></div>
				</div>`
notifications.append(notification);
	if (Title) {
		document.getElementById('titlenotif-'+id).style.display = "block";
		document.getElementById('descrnotif-'+id).style.top = "27px";
	} else {
		document.getElementById('titlenotif-'+id).style.display = "none";
		document.getElementById('descrnotif-'+id).style.transform = "translateY(-50%)";
		document.getElementById('descrnotif-'+id).style.top = "50%";
	}
	if (israder) {
		
		anime({
			targets: `#ui-${id}`,
			translateY: id*(-50),
			duration: 750,
			easing: "spring(1, 70, 100, 10)",
		  });
		  document.getElementById('ui-'+id).style.opacity = opacity;
		  document.getElementById('ui-'+id).style.bottom = "3vh";
		  document.getElementById('ui-'+id).style.display = "block";
  
		  document.getElementById('titlenotif-'+id).textContent = title;
		  document.getElementById('descrnotif-'+id).textContent = description;
  
		  document.getElementById('leftnotif-'+id).style.animation = "leftnotif .7s forwards";
		  document.getElementById('notiftext-'+id).style.animation = "textanim 1.3s forwards .7s";
		  setTimeout(function () {
			  document.getElementById('notiftext-'+id).style.animation = "closetextanim 1.3s forwards ";
			  document.getElementById('leftnotif-'+id).style.animation = "closeleftnotif .7s forwards .3s"; 
			  id--;			
		  }, duration)
		
		if(id == 1){
			anime({
				targets: `#ui-1`,
				translateY: 0,
				duration: 0,
				easing: "spring(1, 70, 100, 10)",
			  });

			}else if(id == 2){
			anime({
				targets: `#ui-1`,
				translateY: -100,
				duration: 750,
				easing: "spring(1, 70, 100, 10)",
			  });
			anime({
				targets: `#ui-2`,
				translateY: 0,
				duration: 750,
				easing: "spring(1, 70, 100, 10)",
			  });
		}else if(id == 3){
			anime({
				targets: `#ui-1`,
				translateY: -200,
				duration: 750,
				easing: "spring(1, 70, 100, 10)",
			  });
			anime({
				targets: `#ui-2`,
				translateY: -100,
				duration: 750,
				easing: "spring(1, 70, 100, 10)",
			  });
			  anime({
				targets: `#ui-3`,
				translateY: 0,
				duration: 750,
				easing: "spring(1, 70, 100, 10)",
			  });
		}else if(id == 4){
			anime({
				targets: `#ui-1`,
				translateY: -300,
				duration: 750,
				easing: "spring(1, 70, 100, 10)",
			  });
			anime({
				targets: `#ui-2`,
				translateY: -200,
				duration: 750,
				easing: "spring(1, 70, 100, 10)",
			  });
			  anime({
				targets: `#ui-3`,
				translateY: -100,
				duration: 750,
				easing: "spring(1, 70, 100, 10)",
			  });
			  anime({
				targets: `#ui-4`,
				translateY: 0,
				duration: 750,
				easing: "spring(1, 70, 100, 10)",
			  });
		}else if(id == 5){
			anime({
				targets: `#ui-1`,
				translateY: -400,
				duration: 750,
				easing: "spring(1, 70, 100, 10)",
			  });
			anime({
				targets: `#ui-2`,
				translateY: -300,
				duration: 750,
				easing: "spring(1, 70, 100, 10)",
			  });
			  anime({
				targets: `#ui-3`,
				translateY: -200,
				duration: 750,
				easing: "spring(1, 70, 100, 10)",
			  });
			  anime({
				targets: `#ui-4`,
				translateY: -100,
				duration: 750,
				easing: "spring(1, 70, 100, 10)",
			  });
			  anime({
				targets: `#ui-5`,
				translateY: 0,
				duration: 750,
				easing: "spring(1, 70, 100, 10)",
			  });

		}
		if (type === "CHECK") {
			document.getElementById('leftnotif-'+id).style.backgroundColor = "#eeff60";
			document.getElementById('leftnotif-'+id).style.boxShadow = "0px 0px 5px #eeff60";
		} else if (type === "INFO") {
			document.getElementById('leftnotif-'+id).style.backgroundColor = "#da7b00";
			document.getElementById('leftnotif-'+id).style.boxShadow = "0px 0px 5px #da7b00";
		} else if (type === "MESSAGE") {
			document.getElementById('leftnotif-'+id).style.backgroundColor = "#c51d70";
			document.getElementById('leftnotif-'+id).style.boxShadow = "0px 0px 5px #c51d70";
		} else if (type === "BANK") {
			document.getElementById('leftnotif-'+id).style.backgroundColor = "#40fe52";
			document.getElementById('leftnotif-'+id).style.boxShadow = "0px 0px 5px #40fe52";
		} else if (type === "SAVE") {
			document.getElementById('leftnotif-'+id).style.backgroundColor = "#35c843";
			document.getElementById('leftnotif-'+id).style.boxShadow = "0px 0px 5px #35c843";
		} else if (type === "ERROR") {
			document.getElementById('leftnotif-'+id).style.backgroundColor = "#d7003d";
			document.getElementById('leftnotif-'+id).style.boxShadow = "0px 0px 5px #d7003d";
		} else if (type === "WARNING") {
			document.getElementById('leftnotif-'+id).style.backgroundColor = "#c01c1c";
			document.getElementById('leftnotif-'+id).style.boxShadow = "0px 0px 5px #c01c1c";
		} else if (type === "SUCCESS") {
			document.getElementById('leftnotif-'+id).style.backgroundColor = "#00ff24";
			document.getElementById('leftnotif-'+id).style.boxShadow = "0px 0px 5px #00ff24";
		} else if (type === "HELP") {
			document.getElementById('leftnotif-'+id).style.backgroundColor = "#ff8400";
			document.getElementById('leftnotif-'+id).style.boxShadow = "0px 0px 5px #ff8400";
		} else if (type === "SERVER") {
			document.getElementById('leftnotif-'+id).style.backgroundColor = "#00a0da";
			document.getElementById('leftnotif-'+id).style.boxShadow = "0px 0px 5px #00a0da";
		} else {
			document.getElementById('leftnotif-'+id).style.backgroundColor = "#00a0da";
			document.getElementById('leftnotif-'+id).style.boxShadow = "0px 0px 5px #00a0da";
		}
	} else {
		if(id == 1){
			anime({
				targets: `#ui-1`,
				translateY: 0,
				duration: 0,
				easing: "spring(1, 70, 100, 10)",
			  });

			}else if(id == 2){
			anime({
				targets: `#ui-1`,
				translateY: -100,
				duration: 750,
				easing: "spring(1, 70, 100, 10)",
			  });
			anime({
				targets: `#ui-2`,
				translateY: 0,
				duration: 750,
				easing: "spring(1, 70, 100, 10)",
			  });
		}else if(id == 3){
			anime({
				targets: `#ui-1`,
				translateY: -200,
				duration: 750,
				easing: "spring(1, 70, 100, 10)",
			  });
			anime({
				targets: `#ui-2`,
				translateY: -100,
				duration: 750,
				easing: "spring(1, 70, 100, 10)",
			  });
			  anime({
				targets: `#ui-3`,
				translateY: 0,
				duration: 750,
				easing: "spring(1, 70, 100, 10)",
			  });
		}else if(id == 4){
			anime({
				targets: `#ui-1`,
				translateY: -300,
				duration: 750,
				easing: "spring(1, 70, 100, 10)",
			  });
			anime({
				targets: `#ui-2`,
				translateY: -200,
				duration: 750,
				easing: "spring(1, 70, 100, 10)",
			  });
			  anime({
				targets: `#ui-3`,
				translateY: -100,
				duration: 750,
				easing: "spring(1, 70, 100, 10)",
			  });
			  anime({
				targets: `#ui-4`,
				translateY: 0,
				duration: 750,
				easing: "spring(1, 70, 100, 10)",
			  });
		}else if(id == 5){
			anime({
				targets: `#ui-1`,
				translateY: -400,
				duration: 750,
				easing: "spring(1, 70, 100, 10)",
			  });
			anime({
				targets: `#ui-2`,
				translateY: -300,
				duration: 750,
				easing: "spring(1, 70, 100, 10)",
			  });
			  anime({
				targets: `#ui-3`,
				translateY: -200,
				duration: 750,
				easing: "spring(1, 70, 100, 10)",
			  });
			  anime({
				targets: `#ui-4`,
				translateY: -100,
				duration: 750,
				easing: "spring(1, 70, 100, 10)",
			  });
			  anime({
				targets: `#ui-5`,
				translateY: 0,
				duration: 750,
				easing: "spring(1, 70, 100, 10)",
			  });
		}
		if (type === "CHECK") {
			document.getElementById('leftnotif-'+id).style.backgroundColor = "#eeff60";
			document.getElementById('leftnotif-'+id).style.boxShadow = "0px 0px 5px #eeff60";
		} else if (type === "INFO") {
			document.getElementById('leftnotif-'+id).style.backgroundColor = "#da7b00";
			document.getElementById('leftnotif-'+id).style.boxShadow = "0px 0px 5px #da7b00";
		} else if (type === "MESSAGE") {
			document.getElementById('leftnotif-'+id).style.backgroundColor = "#c51d70";
			document.getElementById('leftnotif-'+id).style.boxShadow = "0px 0px 5px #c51d70";
		} else if (type === "BANK") {
			document.getElementById('leftnotif-'+id).style.backgroundColor = "#40fe52";
			document.getElementById('leftnotif-'+id).style.boxShadow = "0px 0px 5px #40fe52";
		} else if (type === "SAVE") {
			document.getElementById('leftnotif-'+id).style.backgroundColor = "#35c843";
			document.getElementById('leftnotif-'+id).style.boxShadow = "0px 0px 5px #35c843";
		} else if (type === "ERROR") {
			document.getElementById('leftnotif-'+id).style.backgroundColor = "#d7003d";
			document.getElementById('leftnotif-'+id).style.boxShadow = "0px 0px 5px #d7003d";
		} else if (type === "WARNING") {
			document.getElementById('leftnotif-'+id).style.backgroundColor = "#c01c1c";
			document.getElementById('leftnotif-'+id).style.boxShadow = "0px 0px 5px #c01c1c";
		} else if (type === "SUCCESS") {
			document.getElementById('leftnotif-'+id).style.backgroundColor = "#00ff24";
			document.getElementById('leftnotif-'+id).style.boxShadow = "0px 0px 5px #00ff24";
		} else if (type === "HELP") {
			document.getElementById('leftnotif-'+id).style.backgroundColor = "#ff8400";
			document.getElementById('leftnotif-'+id).style.boxShadow = "0px 0px 5px #ff8400";
		} else if (type === "SERVER") {
			document.getElementById('leftnotif-'+id).style.backgroundColor = "#00a0da";
			document.getElementById('leftnotif-'+id).style.boxShadow = "0px 0px 5px #00a0da";
		} else {
			document.getElementById('leftnotif-'+id).style.backgroundColor = "#00a0da";
			document.getElementById('leftnotif-'+id).style.boxShadow = "0px 0px 5px #00a0da";
		}
		document.getElementById('ui-'+id).style.opacity = opacity;
		document.getElementById('ui-'+id).style.bottom = "22vh";
		document.getElementById('ui-'+id).style.display = "block";
		document.getElementById('titlenotif-'+id).textContent = title;
		document.getElementById('descrnotif-'+id).textContent = description;
		document.getElementById('leftnotif-'+id).style.animation = "leftnotif .7s forwards";
		document.getElementById('notiftext-'+id).style.animation = "textanim 1.3s forwards .7s";
		setTimeout(function () {
			document.getElementById('notiftext-'+id).style.animation = "closetextanim 1.3s forwards ";
			document.getElementById('leftnotif-'+id).style.animation = "closeleftnotif .7s forwards .3s"; 
			id--;			
		}, duration)
	}
	}
}

window.onload = function () {
	slider = document.querySelector(".SoundSlider input");
	slider.oninput = function () {
		progressBar = document.querySelector(".SoundSlider progress");
		progressBar.value = slider.value;
		if (slider.value >= 99) {
			audioVol = 1.0
		} else {
			audioVol = "0." + slider.value;
		}
	}
	slider2 = document.querySelector(".AlphaSlider input");
	slider2.oninput = function () {
		progressBar = document.querySelector(".AlphaSlider progress");
		progressBar.value = slider2.value;
		NotifOpacity = slider2.value;
	}
}

$(document).ready(function () {
	window.addEventListener("message", function (event) {
		let data = event.data;
		/* GET NUI */
		ContDown = function () {
			visible = visible
			progress(data.duration);
		}
		CloseButton = function () {
			$("#headerText").css("transform", "translateY(55px)");
			$("#headerText").css("opacity", "0");
			$("#volumeBar").css("transform", "translateX(60px)");
			$("#opacityBar").css("transform", "translateX(-60px)");
			$("#volumeBar").css("opacity", "0");
			$("#opacityBar").css("opacity", "0");
			setTimeout(() => {
				$("#CSound").css("opacity", "0");
				$("#DSound").css("opacity", "0");
				$("#Title").css("opacity", "0");
				$("#footerText").css("opacity", "0");

			}, 500);
			setTimeout(() => {
				$("#header").css("transform", "translateY(177px)");
				$("#footer").css("transform", "translateY(-177px)");
				$("#CloseButton").css("transform", "translateY(0px)");

				$("#center").css("height", "0px");
			}, 800);
			setTimeout(() => { $("#SettingMenu").css("display", "none");; }, 1200);
			$.post('http://' + GetParentResourceName() + '/focusOff');
			setTimeout(() => {
				$("#center").css("height", "353px");
				$("#header").css("transform", "translateY(0)");
				$("#footer").css("transform", "translateY(0)");
				$("#headerText").css("transform", "translateY(0px)");
				$("#volumeBar").css("transform", "translateX(0px)");
				$("#opacityBar").css("transform", "translateX(0px)");
				$("#headerText").css("opacity", "1");
				$("#volumeBar").css("opacity", "1");
				$("#opacityBar").css("opacity", "1");
				$("#CSound").css("opacity", "1");
				$("#DSound").css("opacity", "1");
				$("#Title").css("opacity", "1");
				$("#footerText").css("opacity", "1");
				$("#CloseButton").css("opacity", "1");
				$("#CloseButton").css("transform", "translateY(228px)");
			}, 2000);
		}
		CSoundClick = function () {
			if (DocCSound === "ON") {
				DocCSound = "OFF"
				CSound = false
				$("#CSound").css("background-color", "rgba(0, 0, 0, 0)");
			} else {
				DocCSound = "ON"
				CSound = true
				$("#CSound").css("background-color", "hsl(196, 88%, 46%)");
				PlaySound('CLICK');
			}
		}
		DSoundClick = function () {
			if (DocDSound === "ON") {
				DocDSound = "OFF"
				DefSound = false
				$("#DSound").css("background-color", "rgba(0, 0, 0, 0)");
			} else {
				DocDSound = "ON"
				DefSound = true
				$("#DSound").css("background-color", "hsl(196, 88%, 46%)");
				PlaySound('CLICK');
			}
		}
		TitleClick = function () {
			if (DocTitle === "ON") {
				DocTitle = "OFF"
				Title = false
				$("#Title").css("background-color", "rgba(0, 0, 0, 0)");
			} else {
				DocTitle = "ON"
				Title = true
				$("#Title").css("background-color", "hsl(196, 88%, 46%)");
				PlaySound('CLICK');
			}
		}
		if (data.action == "NOTIFICATION") {
			if (id < 5){
			LoadNotifiction(NotifOpacity + "%", "NOTIFICATION", data.text, data.IsRader, data.duration,"Deafult");
			this.setTimeout(() => { PlaySound('DEFAULT'); }, 500);
			}
		}
		if (data.action == "ADVANCENOTIFICATION") {
			if (id < 5){
				this.setTimeout(() => {
					if (data.type === "CHECK") {
						PlaySound(data.type)
						LoadNotifiction(NotifOpacity + "%", data.title, data.text, data.IsRader, data.duration,data.type);
					} else if (data.type === "INFO") {
						PlaySound(data.type)
						LoadNotifiction(NotifOpacity + "%", data.title, data.text, data.IsRader, data.duration,data.type);
					} else if (data.type === "MESSAGE") {
						PlaySound(data.type)
						LoadNotifiction(NotifOpacity + "%", data.title, data.text, data.IsRader, data.duration,data.type);
					} else if (data.type === "BANK") {
						PlaySound(data.type)
						LoadNotifiction(NotifOpacity + "%", data.title, data.text, data.IsRader, data.duration,data.type);
					} else if (data.type === "SAVE") {
						PlaySound(data.type)
						LoadNotifiction(NotifOpacity + "%", data.title, data.text, data.IsRader, data.duration,data.type);
					} else if (data.type === "ERROR") {
						PlaySound(data.type)
						LoadNotifiction(NotifOpacity + "%", data.title, data.text, data.IsRader, data.duration,data.type);
					} else if (data.type === "WARNING") {
						PlaySound(data.type)
						LoadNotifiction(NotifOpacity + "%", data.title, data.text, data.IsRader, data.duration,data.type);
					} else if (data.type === "SUCCESS") {
						PlaySound(data.type)
						LoadNotifiction(NotifOpacity + "%", data.title, data.text, data.IsRader, data.duration,data.type);
					} else if (data.type === "HELP") {
						PlaySound(data.type)
						LoadNotifiction(NotifOpacity + "%", data.title, data.text, data.IsRader, data.duration,data.type);
					} else if (data.type === "SERVER") {
						PlaySound(data.type)
						LoadNotifiction(NotifOpacity + "%", data.title, data.text, data.IsRader, data.duration,data.type);
					} else {
						PlaySound('DEFAULT')
						LoadNotifiction(NotifOpacity + "%", data.title, data.text, data.IsRader, data.duration,data.type);
					}
				}, 500);
			}
		}
		if (data.action == "RESET_NOTIFICATION") {
			ResetNotification();
		}
		/* FUNCTIONS */
		function MoveText() {
			$("#NotificationText").css("top", "4vw");
		}
		function PlaySound(name) {
			if (name != "DEFAULT") {
				if (CSound === true) {
					const audio = new Audio('sounds/' + name + '.mp3');
					audio.play();
					audio.volume = audioVol;
				} else if (CSound === false && DefSound === false) {
					const audio = new Audio('sounds/' + name + '.mp3');
					audio.volume = 0;
				} else if (CSound === false) {
					const audio = new Audio('sounds/DEFAULT.mp3');
					audio.play();
					audio.volume = audioVol;
				}
			} else {
				if (DefSound === true) {
					const audio = new Audio('sounds/DEFAULT.mp3');
					audio.play();
					audio.volume = audioVol;
				} else {
					const audio = new Audio('sounds/DEFAULT.mp3');
					audio.play();
					audio.volume = 0;
				}
			}
		}
	})
});
