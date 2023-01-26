var carCategories = [];
var curCat = 0;
var pricevehicle = 0;
var namevehicletest = null;
var intv = null;
var curTest = 45;
var buyandselect = false;

$(window).ready(function() {
    window.addEventListener('message', (event) => {
        let data = event.data;
        if (data.action == "load"){
            $("#wrap").show();
            $("body").show();
			init(data);
        }
    });
});

function init(data) {
    garage = data.garage;
    carCategories = [];
    curCat = 0;
    buyandselect = garage.DealerRun.buy;

   $("#premium-info").html(`Makan Garage:<br/>${garage.name}`);
    
    $("#btn-buy-money").css("display","unset");
    $("#btn-buy-black-money").css("display","none");
    $("#vehicle-price-money").css("display", "unset");
    $("#vehicle-price-black-money").css("display", "none");

   if(garage.testDrive == true) {
	   $("#btn-test-drive").css("display","unset");
   }else {
	   $("#btn-test-drive").css("display","none");
   }

    $("#text-money").html(garage.DealerRun.text);
    $("#buy-subtext").html(garage.DealerRun.text2);

   $.each(garage.Vehicles, function (key, val) {  carCategories[carCategories.length] = key; });
   
   loadCat(curCat);
}



function categoryNext() {
   if(curCat == carCategories.length-1) {
	 curCat = 0; 
   }else {
	 curCat = curCat + 1;
   }
   
   loadCat(curCat);
}
function categoryPrev() {
   if(curCat == 0) {
	 curCat = carCategories.length-1; 
   }else {
	 curCat = curCat - 1;
   }	
   
   loadCat(curCat);
}

function loadCat(x) {
   $("#vehicle-list").html("");
   $.each(garage.Vehicles[carCategories[x]], function (key, val) {
	   var active = ``;
	    
	   if(key == 0) {
		  active = `active`;
		  $.post("https://IRV-Vehicleshop/showCar", JSON.stringify({ name: val.name }), function(x){

            $("#tank-lt").html(x.fuel + " LITRE" );
            $("#trunk-capacity").html(x.trunk + " VOL");

          });

          namevehicletest = val.name;

          setPrice(val.price);
          $("#vehicle-name").html(val.name);

          var consum = parseInt(val.consumption);
          if(consum == 3) {
             consum = "Yuksek";
          }else if(consum == 2) {
             consum = "Orta";
          }else {
             consum = "Dusuk";
          }
          $("#consumption-level").html(consum);
      
	   }
  
	   $("#vehicle-list").append(`<div class="vehicle-list-name ${active}"  data-name="${val.name}" data-price="${val.price}" data-trunk="${val.trunk}"  data-consumption="${val.consumption}" data-fuel="${val.fuel}" >[${val.label}] <span style="color:lightgreen;">${val.price}$</span></div>`);
   });
   $("#vehicle-type-category").html(carCategories[x]);
}


$(document).on('click', '.vehicle-list-name', function(e){
    $(".vehicle-list-name").removeClass("active");
    setTimeout(() => {
        $(this).addClass("active");  
    }, 100);  
    $.post("https://IRV-Vehicleshop/showCar", JSON.stringify({ name: $(this).data("name") }), function(x){

        $("#tank-lt").html(x.fuel + " LITRE" );
        $("#trunk-capacity").html(x.trunk + " VOL");
    });
    
    namevehicletest = $(this).data("name");

    $("#vehicle-name").html($(this).data("name"));

    var consum = parseInt($(this).data("consumption"));
    if(consum == 3) {
       consum = "BALA";
    }else if(consum == 2) {
       consum = "MOTAVASET";
    }else {
       consum = "ZAIF";
    }
    $("#consumption-level").html(consum);

    setPrice($(this).data("price"));
});

$(document).on('keydown', function() {
    switch(event.keyCode) {
        case 27: 
        $("#wrap").hide();
        $("body").hide();
        $.post("https://IRV-Vehicleshop/close", JSON.stringify({}), function(x){});
        break;
    }
});

function testdrive(){

    $.post("https://IRV-Vehicleshop/testdrive", JSON.stringify({namevehicle: namevehicletest}), function(x){
        if (x.ckeck) {
            $("#wrap").hide();
            $("body").hide();
        }else {
            GenerateNotification(x.text, "succes", 1500)
        }
    });
}



var startMovingRight = false;
var startMovingLeft = false;
async function moveRight(){
    startMovingRight = true;
    while (startMovingRight){
        $.post('https://IRV-Vehicleshop/moveright');
        await sleep(5);
    }
    
}

function stopMovingRight(){
    startMovingRight = false;
}

async function moveLeft(){
    startMovingLeft = true;
    while (startMovingLeft){
        $.post('https://IRV-Vehicleshop/moveleft');
        await sleep(5);
    }
    
}

function stopMovingLeft(){
    startMovingLeft = false;
}


function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

$(document).on('click', '.choose-color-circle', function(e){
    var rgb = RGBvalues.color($(this).css("background-color"));
    $.post("https://IRV-Vehicleshop/setcolour", JSON.stringify({rgb: rgb}), function(x){});
});

$(document).on('click', '.choose-color-circlex', function(e){
     if($(".colorpicker").css("display") == "none") {
        $(".colorpicker").css("display", "block");
     }else {
        $(".colorpicker").css("display", "none");
     }
});

function setPrice(x) { 
    $("#vehicle-price-black-money").html(`<i class="fal fa-sack-dollar"></i>`+x);
    $("#vehicle-price-money").html("$"+x);
    pricevehicle = x;
}


function plakaduzen() { 
    $(".plaka").css("display", "block");
}

function buy() {
   $.post("https://IRV-Vehicleshop/buy", JSON.stringify({pricevehicle: pricevehicle, buy: buyandselect}), function(x){ 
        if(x.ckeck == true) {  
            $("#wrap").hide();
            $("body").hide();
        }else {
            GenerateNotification(x.text, "succes", 1500)
        }
    }); 
}

function plakaiptal() {
   $(".plaka").css("display", "none");
}

var RGBvalues = (function() {

    var _hex2dec = function(v) {
        return parseInt(v, 16)
    };

    var _splitHEX = function(hex) {
        var c;
        if (hex.length === 4) {
            c = (hex.replace('#','')).split('');
            return {
                r: _hex2dec((c[0] + c[0])),
                g: _hex2dec((c[1] + c[1])),
                b: _hex2dec((c[2] + c[2]))
            };
        } else {
             return {
                r: _hex2dec(hex.slice(1,3)),
                g: _hex2dec(hex.slice(3,5)),
                b: _hex2dec(hex.slice(5))
            };
        }
    };

    var _splitRGB = function(rgb) {
        var c = (rgb.slice(rgb.indexOf('(')+1, rgb.indexOf(')'))).split(',');
        var flag = false, obj;
        c = c.map(function(n,i) {
            return (i !== 3) ? parseInt(n, 10) : flag = true, parseFloat(n);
        });
        obj = {
            r: c[0],
            g: c[1],
            b: c[2]
        };
        if (flag) obj.a = c[3];
        return obj;
    };

    var color = function(col) {
        var slc = col.slice(0,1);
        if (slc === '#') {
            return _splitHEX(col);
        } else if (slc.toLowerCase() === 'r') {
            return _splitRGB(col);
        } else {
            console.log('!Ooops! RGBvalues.color('+col+') : HEX, RGB, or RGBa strings only');
        }
    };

    return {
        color: color
    };
}());

 

$(document).ready(function() {
    $('.colorpicker').minimalColorpicker({
        color: '#4513e9',
        onUpdateColor: function(e, color) {
            $.post("https://IRV-Vehicleshop/setcolour", JSON.stringify({rgb: color.rgb}), function(x){});
        }
    });
});

jQuery.fn.minimalColorpicker = function(options) {

    var defaults = {
        color: '#000000'
    };

    var settings = $.extend({}, defaults, options);

    return this.each(function() {
        var self = $(this);
        var hue = $('<div />').addClass('hue');
        var hueDrag = $('<div />').addClass('drag');
        var field = $('<div />').addClass('field');
        var fieldOverlay = $('<div />').addClass('fieldOverlay');
        var fieldDrag = $('<div />').addClass('drag');
        var input = $('<input />').val('#ffffff');
        var rgbList = $('<ul />');
        rgbList.append($('<li />').html('<strong>255</strong>R'));
        rgbList.append($('<li />').html('<strong>255</strong>G'));
        rgbList.append($('<li />').html('<strong>255</strong>B'));

        if(tinycolor(settings.color).isValid()) {
            self.color = tinycolor(settings.color).toHsl();
        }

        if(tinycolor(self.data('color')).isValid()) {
            self.color = tinycolor(self.data('color')).toHsl();
        }

        hue.append(hueDrag);
        self.append(hue);
        fieldOverlay.append(fieldDrag);
        field.append(fieldOverlay);
        self.append(field);
       // self.append(input);
       // self.append(rgbList);

        self.hue = hue.get(0);
        self.hue.drag = hueDrag.get(0);

        self.fieldBase = field.get(0);
        self.field = fieldOverlay.get(0);
        self.field.drag = fieldDrag.get(0);

        self.updateHue = function(e) {
            self.setHue(e.offsetY / hue.outerHeight() * 360);
            if(self.hue.onmousemove === null) {
                self.hue.onmousemove = function(e) {
                    if(e.target === self.hue) {
                        self.setHue(e.offsetY / hue.outerHeight() * 360);
                        e.stopPropagation();
                    }
                }
            }
            self.clearMousemove('hue');
        }

        self.updateColor = function(e) {
            self.setColorPos(e.offsetX, e.offsetY);
            if(self.field.onmousemove === null) {
                self.field.onmousemove = function(e) {
                    if(e.target === self.field) {
                        self.setColorPos(e.offsetX, e.offsetY);
                        e.stopPropagation();
                    }
                }
            }
            self.clearMousemove('field');
        }

        self.setColorPos = function(x, y) {
            self.field.drag.style.setProperty('--x', x);
            self.field.drag.style.setProperty('--y', y);
            self.color = tinycolor({
                h: self.color.h,
                s: ((x / (field.outerWidth() - 1)) * 100),
                v: ((1 - y / (field.outerHeight() - 1)) * 100)
            }).toHsl();
            self.setColor();
        }

        self.setHue = function(a) {
            self.color.h = a;
            self.setColor();
        }

        self.setColor = function(e) {
            var c = tinycolor(self.color);
            chsv = c.toHsv();
            c = c.toHslString();
            self.field.drag.style.setProperty('--x', Math.round((chsv.s) * (field.outerWidth() - 1)) + 'px');
            self.field.drag.style.setProperty('--y', Math.round((1 - chsv.v) * (field.outerHeight())) + 'px');
            self.hue.drag.style.setProperty('--y', self.color.h / 360 * hue.outerHeight() + 'px');
            self.fieldBase.style.setProperty('--backgroundHue', self.color.h);
            if(options.onUpdateColor !== undefined) {
                options.onUpdateColor(e, {
                    hex: tinycolor(self.color).toHex(),
                    rgb: tinycolor(self.color).toRgb(),
                    rgbString: tinycolor(self.color).toRgbString()
                });
            }
            self.setOutput();
        }

        self.setOutput = function(e) {
            input.val('#' + tinycolor(self.color).toHex());
            rgbList.find('li:nth-child(1) strong').text(tinycolor(self.color).toRgb().r);
            rgbList.find('li:nth-child(2) strong').text(tinycolor(self.color).toRgb().g);
            rgbList.find('li:nth-child(3) strong').text(tinycolor(self.color).toRgb().b);
        }

        self.updateOutput = function(e) {
            if(input.val().length == 7 && tinycolor(input.val()).isValid()) {
                var c = tinycolor(input.val());
                self.color = c.toHsl();
                self.setColorPos(Math.round((c.toHsv().s) * (field.outerWidth() - 1)), Math.round((1 - c.toHsv().v) * (field.outerHeight())));
                self.setColor();
                self.setOutput();
            }
        }

        self.clearMousemove = function(m) {
            if(document.onmouseup === null) {
                document.onmouseup = function(e) {
                    self[m].onmousemove = null;
                    document.onmouseup = null;
                }
            }
        }

        //input.on('change keyup', self.updateOutput);
        field.on('mousedown', self.updateColor);
        hue.on('mousedown', self.updateHue);

        self.setColor();
        self.setHue(self.color.h);
        self.setOutput();

    });

}

let notifications = []
function GenerateNotification(message, type, timeout) {
  let id = notifications.length + 1;
  if(type == null){
      type = "succes";
  }
  if(timeout == null){
      timeout = 5000;
  }
  if(message == null){
      message = "UNKOWN";
  }
  let html = `
      <div style="transform: translateX(-165px)" class="notify" id="notify-${id}">
      <h1 class="notify-title">${type.toUpperCase()}</h1>
      <P class="notify-text">${message}</P>
      <div class="top-line"></div>
      <div class="notify-dots-${type}"></div>
    </div>
  `
  $('.notify-container').append(html)
  anime({
      targets: `#notify-${id}`,
      translateX: "0",
      duration: 550,
      easing: "spring(1, 70, 100, 10)",
    });
     notifications[id] = setTimeout(() => {
       anime({
           targets: `#notify-${id}`,
           translateX: "-165px",
           duration: 550,
           easing: "spring(1, 70, 100, 10)",
         });
       setTimeout(() => {
           $("#notify-" + id).remove();
           notifications[id] = null;
         }, 150);
   }, timeout)
}