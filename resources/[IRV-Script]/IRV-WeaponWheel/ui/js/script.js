var equipSlot1 = null
var equipSlot2 = null
var equipSlot3 = null
var equipSlot4 = null
var equipSlot5 = null

var nameSlot1 = null
var nameSlot2 = null
var nameSlot3 = null
var nameSlot4 = null
var nameSlot5 = null

window.addEventListener("message", (event) => {
    switch (event.data.action) {
        case "ShowWheel":
            $("#Display").css("opacity", 1);

			if (event.data.weaponselect == 1) {
				$("#Select_Border_Aslahe_Sangin").css({ opacity: "1"});
			} else {
				$("#Select_Border_Aslahe_Sangin").css({ opacity: "0"});
			} 
			
			if (event.data.weaponselect == 2) {
				$("#Select_Border_Aslahe_Sabok").css({ opacity: "1"});
			} else {
				$("#Select_Border_Aslahe_Sabok").css({ opacity: "0"});
			} 
			
			if (event.data.weaponselect == 3) {
				$("#Select_Border_Aslahe_Mini").css({ opacity: "1"});
			} else {
				$("#Select_Border_Aslahe_Mini").css({ opacity: "0"});
			} 
			
			if (event.data.weaponselect == 4) {
				$("#Select_Border_Aslahe_Sard").css({ opacity: "1"});
			} else {
				$("#Select_Border_Aslahe_Sard").css({ opacity: "0"});
			} 

			if (event.data.weaponselect == 5) {
				$("#select_Border_Mosht").css("stroke", "rgba(255,255,255,0.859)");
			} else {
				$("#select_Border_Mosht").css({ opacity: "0"});
			} 
			break;	
		case "updateAmmo":
			if (event.data.index == 1) {
				$("#Tedad_Kheshab_Aslahe_Sangin").text(event.data.ammo);
			} else if (event.data.index == 2) {
				$("#Tedad_Kheshab_Aslahe_Sabok").text(event.data.ammo);
			} else if (event.data.index == 3) {
				$("#Tedad_Kheshab_Aslahe_Mini").text(event.data.ammo);
			} 
			break;	
		case "addWeapon":
			if (event.data.index == 1) {
				$("#Image_Aslahe_Sangin").attr("src", "./image/" + event.data.name + ".png");
				equipSlot1 = 1
				nameSlot1 = event.data.name
			} else if (event.data.index == 2) {
				$("#Image_Aslahe_Sabok").attr("src", "./image/" + event.data.name + ".png");
				equipSlot2 = 2
				nameSlot2 = event.data.name
			} else if (event.data.index == 3) {
				$("#Image_Aslahe_Mini").attr("src", "./image/" + event.data.name + ".png");
				equipSlot3 = 3
				nameSlot3 = event.data.name
			} else if (event.data.index == 4) {
				$("#Image_Aslahe_Sard").attr("src", "./image/" + event.data.name + ".png");
				equipSlot4 = 4
				nameSlot4 = event.data.name
			} else {
				equipSlot4 = 5
			} 
			break;
		case "removeWeapon":
			if (event.data.index == 1) {
				$("#Image_Aslahe_Sangin").attr("src", "./image/noweapon.png");
				$("#Tedad_Kheshab_Aslahe_Sangin").text("");
				equipSlot1 = null
				nameSlot1 = null
			} else if (event.data.index == 2) {
				$("#Image_Aslahe_Sabok").attr("src", "./image/noweapon.png");
				$("#Tedad_Kheshab_Aslahe_Sabok").text("");
				equipSlot2 = null
				nameSlot2 = null
			} else if (event.data.index == 3) {
				$("#Image_Aslahe_Mini").attr("src", "./image/noweapon.png");
				$("#Tedad_Kheshab_Aslahe_Mini").text("");
				equipSlot3 = null
				nameSlot3 = null
			} else if (event.data.index == 4) {
				$("#Image_Aslahe_Sard").attr("src", "./image/noweapon.png");
				equipSlot4 = null
				nameSlot4 = null
			} else {
				equipSlot4 = 5
			}
			break;
        }
    }    
)


$(function() {
	document.onkeyup = function (data) {
        if (data.which == 27) { // Escape key
            $.post('https://IRV-WeaponWheel/close', JSON.stringify({}));
			$("#Display").css("opacity", 0);
        } else if (data.which == 9 || data.which == 17) { // Tab key
            $.post('https://IRV-WeaponWheel/close', JSON.stringify({}));
			$("#Display").css("opacity", 0);
        }
    };
	// ---------------------------------------------------------------
    $("#Image_Aslahe_Sangin").click((e) => {
		if (equipSlot1 == 1) {
			$.post('https://IRV-WeaponWheel/select', JSON.stringify({nameSlot: nameSlot1, equipSlot: equipSlot1}));
			setTimeout(() => {
				$("#Samt_Bala").css({ top: "11.25vw"});
				setTimeout(() => {
					$("#Select_Border_Aslahe_Sangin").css({ opacity: "1"});
					setTimeout(() => {
						$(".Select_Border_Aslahe_Sangin").css({ transform: "translate(-39.69vw, -14vw) matrix(1,0,0,1,906.3894,115.6672) rotate(270deg)"});
						$("#Display").css("opacity", 0);
					},20);
				}, 400);
			},50);
		}
    })

	$(".Select_Border_Aslahe_Sangin").click((e) => {
		if (equipSlot1 == 1) {
			$.post('https://IRV-WeaponWheel/select', JSON.stringify({nameSlot: nameSlot1, equipSlot: equipSlot1}));
			setTimeout(() => {
				$("#Samt_Bala").css({ top: "11.25vw"});
				setTimeout(() => {
					$("#Select_Border_Aslahe_Sangin").css({ opacity: "1"});
					setTimeout(() => {
						$(".Select_Border_Aslahe_Sangin").css({ transform: "translate(-39.69vw, -14vw) matrix(1,0,0,1,906.3894,115.6672) rotate(270deg)"});
						$("#Display").css("opacity", 0);
					},20);
				}, 400);
			},50);
		}
    })

	$(".Border_Vasat_Samt_Bala").click((e) => {
		if (equipSlot1 == 1) {
			$.post('https://IRV-WeaponWheel/select', JSON.stringify({nameSlot: nameSlot1, equipSlot: equipSlot1}));
			setTimeout(() => {
				$("#Samt_Bala").css({ top: "11.25vw"});
				setTimeout(() => {
					$("#Select_Border_Aslahe_Sangin").css({ opacity: "1"});
					setTimeout(() => {
						$(".Select_Border_Aslahe_Sangin").css({ transform: "translate(-39.69vw, -14vw) matrix(1,0,0,1,906.3894,115.6672) rotate(270deg)"});
						$("#Display").css("opacity", 0);
					},20);
				}, 400);
			},50);
		}
    })
	// ---------------------------------------------------------------
	$("#Image_Aslahe_Sabok").click((e) => {
		if (equipSlot2 == 2) {
			console.log(equipSlot2);
			$.post('https://IRV-WeaponWheel/select', JSON.stringify({nameSlot: nameSlot2, equipSlot: equipSlot2}));
			setTimeout(() => {
				$("#Samt_Chap").css({ left: "35.859vw"});
				setTimeout(() => {
					$("#Select_Border_Aslahe_Sabok").css({ opacity: "1"});
					setTimeout(() => {
						$(".Select_Border_Aslahe_Sabok").css({ left: "-0.5vw"});
						$("#Display").css("opacity", 0);
					},20);
				}, 400);
			},50);
		}
    })

	$(".Select_Border_Aslahe_Sabok").click((e) => {
		if (equipSlot2 == 2) {
			$.post('https://IRV-WeaponWheel/select', JSON.stringify({nameSlot: nameSlot2, equipSlot: equipSlot2}));
			setTimeout(() => {
				$("#Samt_Chap").css({ left: "35.859vw"});
				setTimeout(() => {
					$("#Select_Border_Aslahe_Sabok").css({ opacity: "1"});

					setTimeout(() => {
						$(".Select_Border_Aslahe_Sabok").css({ left: "-0.5vw"});
						$("#Display").css("opacity", 0);

					},20);
				}, 400);
			},50);
		}
    })


	$(".Border_Vasat_Samt_Chap").click((e) => {
		if (equipSlot2 == 2) {
			$.post('https://IRV-WeaponWheel/select', JSON.stringify({nameSlot: nameSlot2, equipSlot: equipSlot2}));
			setTimeout(() => {
				$("#Samt_Chap").css({ left: "35.859vw"});
				setTimeout(() => {
					$("#Select_Border_Aslahe_Sabok").css({ opacity: "1"});
					setTimeout(() => {
						$(".Select_Border_Aslahe_Sabok").css({ left: "-0.5vw"});
						$("#Display").css("opacity", 0);

					},20);
				}, 400);
			},50);
		}
    })
	// ---------------------------------------------------------------
	$("#Image_Aslahe_Mini").click((e) => {
		if (equipSlot3 == 3) {
			$.post('https://IRV-WeaponWheel/select', JSON.stringify({nameSlot: nameSlot3, equipSlot: equipSlot3}));
			setTimeout(() => {
				$("#Samt_Paiin").css({ 	top: "30.723vw"});
				setTimeout(() => {
					$("#Select_Border_Aslahe_Mini").css({ opacity: "1"});

					setTimeout(() => {
						$(".Select_Border_Aslahe_Mini").css({ transform: "translate(-39.746vw, -32.65vw) matrix(1,0,0,1,908.1454,571.2882) rotate(270deg)"});
						$("#Display").css("opacity", 0);

					},20);
				}, 400);
			},50);
		}
    })

	$(".Select_Border_Aslahe_Mini").click((e) => {
		if (equipSlot3 == 3) {
			$.post('https://IRV-WeaponWheel/select', JSON.stringify({nameSlot: nameSlot3, equipSlot: equipSlot3}));
			setTimeout(() => {
				$("#Samt_Paiin").css({ 	top: "30.723vw"});
				setTimeout(() => {
					$("#Select_Border_Aslahe_Mini").css({ opacity: "1"});

					setTimeout(() => {
						$(".Select_Border_Aslahe_Mini").css({ transform: "translate(-39.746vw, -32.65vw) matrix(1,0,0,1,908.1454,571.2882) rotate(270deg)"});
						$("#Display").css("opacity", 0);

					},20);
				}, 400);
			},50);
		}
    })


	$(".Border_Vasat_Samt_Paiin").click((e) => {
		if (equipSlot3 == 3) {
			$.post('https://IRV-WeaponWheel/select', JSON.stringify({nameSlot: nameSlot3, equipSlot: equipSlot3}));
			setTimeout(() => {
				$("#Samt_Paiin").css({ 	top: "30.723vw"});
				setTimeout(() => {
					$("#Select_Border_Aslahe_Mini").css({ opacity: "1"});

					setTimeout(() => {
						$(".Select_Border_Aslahe_Mini").css({ transform: "translate(-39.746vw, -32.65vw) matrix(1,0,0,1,908.1454,571.2882) rotate(270deg)"});
						$("#Display").css("opacity", 0);

					},20);
				}, 400);
			},50);
		}
    })
	// ---------------------------------------------------------------
	$("#Image_Aslahe_Sard").click((e) => {
		if (equipSlot4 == 4) {
			$.post('https://IRV-WeaponWheel/select', JSON.stringify({nameSlot: nameSlot4, equipSlot: equipSlot4}));
			setTimeout(() => {
				$("#Samt_Rast").css({ left:"55.371vw"});
				setTimeout(() => {
					$("#Select_Border_Aslahe_Sard").css({ opacity: "1"});
					setTimeout(() => {
						$(".Select_Border_Aslahe_Sard").css({ left: "4.8vw"});
						$("#Display").css("opacity", 0);

					},20);
				}, 400);
			},20);
		}
    })

	$(".Select_Border_Aslahe_Sard").click((e) => {
		if (equipSlot4 == 4) {
			$.post('https://IRV-WeaponWheel/select', JSON.stringify({nameSlot: nameSlot4, equipSlot: equipSlot4}));
			setTimeout(() => {
				$("#Samt_Rast").css({ left:"55.371vw"});
				setTimeout(() => {
					$("#Select_Border_Aslahe_Sard").css({ opacity: "1"});
					setTimeout(() => {
						$(".Select_Border_Aslahe_Sard").css({ left: "4.8vw"});
						$("#Display").css("opacity", 0);

					},20);
				}, 400);
			},20);
		}
    })

	$(".Border_Vasat_Samt_Rast").click((e) => {
		if (equipSlot4 == 4) {
			$.post('https://IRV-WeaponWheel/select', JSON.stringify({nameSlot: nameSlot4, equipSlot: equipSlot4}));
			setTimeout(() => {
				$("#Samt_Rast").css({ left:"55.371vw"});
				setTimeout(() => {
					$("#Select_Border_Aslahe_Sard").css({ opacity: "1"});
					setTimeout(() => {
						$(".Select_Border_Aslahe_Sard").css({ left: "4.8vw"});
						$("#Display").css("opacity", 0);

					},20);
				}, 400);
			},20);
		}
    })
	// ---------------------------------------------------------------
	$("#select_Border_Mosht").click((e) => {
		$.post('https://IRV-WeaponWheel/select', JSON.stringify({nameSlot: nameSlot5, equipSlot: equipSlot5}));
		setTimeout(() => {
			$("#Display").css("opacity", 0);
		},200);
    })	
});


// function calculate() {

// 	const deviceWidth = screen.width;
// 	const viewportWidth = window.innerWidth;
// 	const currentRatio = viewportWidth / deviceWidth;
// 	const angle = currentRatio * 360;
// 	console.log(currentRatio);

// 	document.querySelector('.Border_Vasat_Samt_Chap').style.transform = ` translate(-35.365vw, -17.889vw) matrix(1,0,0,1,712.132,503.3216) rotate(90deg)`;
// }

// window.addEventListener('resize', calculate);