$(function() {
    window.addEventListener('message', function(event) {
        if (event.data.type == "open") {
            IRVradio.SlideUp()
        }

        if (event.data.type == "close") {
            IRVradio.SlideDown()
        }
    });

    document.onkeyup = function (data) {
        if (data.which == 27) { // Escape key
            $.post('https://IRV-radio/escape', JSON.stringify({}));
            IRVradio.SlideDown()
        } else if (data.which == 13) { // Enter key
            $.post('https://IRV-radio/joinRadio', JSON.stringify({
                channel: $("#channel").val()
            }));
        }
    };
});

IRVradio = {}

$(document).on('click', '#submit', function(e){
    e.preventDefault();

    $.post('https://IRV-radio/joinRadio', JSON.stringify({
        channel: $("#channel").val()
    }));
});

$(document).on('click', '#disconnect', function(e){
    e.preventDefault();

    $.post('https://IRV-radio/leaveRadio');
});

$(document).on('click', '#volumeUp', function(e){
    e.preventDefault();

    $.post('https://IRV-radio/volumeUp', JSON.stringify({
        channel: $("#channel").val()
    }));
});

$(document).on('click', '#volumeDown', function(e){
    e.preventDefault();

    $.post('https://IRV-radio/volumeDown', JSON.stringify({
        channel: $("#channel").val()
    }));
});

$(document).on('click', '#decreaseradiochannel', function(e){
    e.preventDefault();

    $.post('https://IRV-radio/decreaseradiochannel', JSON.stringify({
        channel: $("#channel").val()
    }));
});

$(document).on('click', '#increaseradiochannel', function(e){
    e.preventDefault();

    $.post('https://IRV-radio/increaseradiochannel', JSON.stringify({
        channel: $("#channel").val()
    }));
});

$(document).on('click', '#poweredOff', function(e){
    e.preventDefault();

    $.post('https://IRV-radio/poweredOff', JSON.stringify({
        channel: $("#channel").val()
    }));
});

IRVradio.SlideUp = function() {
    $(".container").css("display", "block");
    $(".radio-container").animate({bottom: "6vh",}, 250);
}

IRVradio.SlideDown = function() {
    $(".radio-container").animate({bottom: "-110vh",}, 400, function(){
        $(".container").css("display", "none");
    });
}
