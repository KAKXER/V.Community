$(document).ready(function() {
	$(".car-wrapper-motor").fadeOut(0);
	$(".carbox-car-logo-container").fadeOut(0);
	$(".carbox-transfer").fadeOut(0);
	$(".compenents").fadeOut(0);
	$(".carbox-sell").fadeOut(0);
	$(".out").fadeOut(0);
	$(".vale").fadeOut(0);
	$("#sell").fadeOut(0);

	var offspawnvehicle = false;
	window.addEventListener("message", function(event) {
		event.preventDefault();
		var data = event.data;
		var name = data.name;
		var carname = data.carname;
		var plate = data.plate;
		var mileageformat = data.mileageFormat;
		var garage = data.garage;
		var fuel = data.fuel;
		var logo = (`./images/logo/${garage}.png`);
		var carlogo = data.logo;
		var cardlogocheck = checkFileExist(`./images/cars/${carname}.png`);
		var damage = data.damage;
		var vehiclefuel = data.fuel;
		offspawnvehicle = true;
		if (cardlogocheck == true) {
			var cardlogo = (`./images/cars/${carname}.png`);
		} else {
			cardlogo = (`./images/cars/noimage.png`);
		}

		if (data.action == true) {
			$('#app').css('display', 'block');
			if (mileageformat == 'KM'){
				var maxspeed = parseInt(data.max) + ' KM/H'; 
			}else{
				var maxspeed = parseInt(data.max) + ' MP/H'; 
			}

			if (garage == "normal") {
				$('#headlogo').attr('src', './images/logo/logo.png');
			} else {
				$('#headlogo').attr('src', logo);
			}	

			$('#compenents').css('display', 'none');
			$('.cars').css('display', 'block')
			$('.bikes').css('display', 'block')
			$('.motor').css('display', 'block')
			$('.boat').css('display', 'none')
			$('.air').css('display', 'none')
			$('.compenents').css('display', 'none')
			$(".car-wrapper").append(` 
				<div class="vehiclemodel" data-carname="${carname.toUpperCase()}" data-acce="${vehiclefuel}%" data-price="500" data-plate="${plate}" data-max="${maxspeed}" data-damage="${damage}%"  data-garage="${garage}">
				<div class="car-wrapper-car">
				<p class="carnameee">${carname.toUpperCase()}</p>
				<img data-plate="${carname}" src="${cardlogo}" alt="">
				</div>
			`);		
		} else if (data.action == false) {
			close();
		}
	});

	function checkFileExist(urlToFile) {
		var xhr = new XMLHttpRequest();
		xhr.open('HEAD', urlToFile, false);
		xhr.send();

		if (xhr.status == "404") {
			return false;
		} else {
			return true;
		}
	}
	
	spawned = false;
	$(document).on("click", ".car-wrapper-car", function() {
		if (spawned == false && offspawnvehicle == true){
			spawned = true
			$(".car-box-details").css('display', 'flex');
			var carnamee = $(this).parent().find('.carnameee');
			var carlogoo = $(this).parent().attr("data-logo");
	
			var logo = (`./images/logo/${carlogoo}.png`);
			var defaultlogo = (`./images/logo/unmarked.png`);
			if (carlogoo == "undefined" || carlogoo == "NULL") {
				$('#crlogo').attr('src', defaultlogo);
			} else {
				$('#crlogo').attr('src', logo);
			}
			$('.car-wrapper-car').removeClass('selected');
			$(this).addClass('selected');
			$('.carnameee').removeClass('selected');
			$(carnamee).addClass('selected');
			let carname = $(this).parent().attr("data-carname");
			if (carname == undefined){
				spawned = false
			}
			let plate = $(this).parent().attr("data-plate");
			let max = $(this).parent().attr("data-max");
			let damage = $(this).parent().attr("data-damage");
			let acce = $(this).parent().attr("data-acce");
			let price = $(this).parent().attr("data-price");
			document.getElementById("svehicle").innerHTML = carname.toUpperCase();
			document.getElementById("splate").innerHTML = plate;
			document.getElementById("tvehicle").innerHTML = carname.toUpperCase();
			document.getElementById("tplate").innerHTML = plate;
			document.getElementById("acce").innerHTML = acce;
			document.getElementById("prices").innerHTML = price;
			document.getElementById("damage").innerHTML = damage;
			document.getElementById("plate").innerHTML = plate;
			document.getElementById("model").innerHTML = carname;
			document.getElementById("max").innerHTML = max;

			$.post('https://X-scripts/spawnlocalvehicle', JSON.stringify ({
				carname: carname,
				plate: plate
			}),function(cs){
				spawnlanancar = cs
				spawned = false
			});
		}
	})

	$(document).on("click", ".spawnbutton", function() {
		var carname = document.getElementById("model").innerHTML;
		var plate = document.getElementById("plate").innerHTML;
		let garage = $('.car-wrapper-car').parent().attr("data-garage");
		$.post('https://X-scripts/spawnvehicle', JSON.stringify({
			carname: carname,
			plate: plate,
			garage: garage
		}));
		close();
	})
	var livnumber = document.getElementById("livnumber");
	clivnumber = 0;

	function close() {
		$('#app').css('display', 'none');
		$('.car-box-details').fadeOut(0);
		let garage = $('.car-wrapper-car').parent().attr("data-garage");
		spawned = false
		offspawnvehicle = true
		$.post('https://X-scripts/close', JSON.stringify({
			display: false,
			garage: garage

		}));
		document.querySelectorAll(".car-wrapper-car").forEach(function(a) {
			a.remove()
		});
	}

	document.addEventListener('keyup', function(data) {
		if (data.which == 27) {
			close();
		}
	});

	let holding = false;
	document.addEventListener("mousedown", function(e) {
		holding = true;
	});
	document.addEventListener("mouseup", function(e) {
		holding = false;
	});

	var direction = "",
		oldx = 0,
		mousemovemethod = function(e) {
			if (e.pageX < oldx) {
				direction = "left";
			} else if (e.pageX > oldx) {
				direction = "right";
			}
			oldx = e.pageX;
			if (direction == "left" && holding) {
				if (e.target.classList.contains("mouse-move")) {
					$.post('https://X-scripts/rotateleft');
				}
			}
			if (direction == "right" && holding) {
				if (e.target.classList.contains("mouse-move")) {
					$.post('https://X-scripts/rotateright');
				}
			}
		};

	document.addEventListener("mousemove", mousemovemethod);

	const element = document.querySelector(".car-wrapper");
	element.addEventListener('wheel', (event) => {
		event.preventDefault();
		element.scrollBy({
			left: event.deltaY < 0 ? -30 : 30,

		});
	});
})