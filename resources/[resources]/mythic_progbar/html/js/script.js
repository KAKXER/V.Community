$('document').ready(function () {
    MythicProgBar = {};

    MythicProgBar.Progress = function (data) {
        $(".progress-container").css({ "display": "block" });
        $("#progress-label").text(data.label);
        $("#progress-bar").stop().css({ "width": 0, "background-color": "#ff3547", "box-shadow": "0 0 15px #ff3547", "border-radius": "100px" }).animate({
            width: '100%'
        }, {
            duration: parseInt(data.duration),
            complete: function () {
                Com();
                setTimeout(function () {
                    $(".progress-container").css({ "display": "none" });
                    $("#progress-bar").css("width", 0);
                    $.post('http://mythic_progbar/actionFinish', JSON.stringify({}));
                }, 1000);
            }
        });
    };

    MythicProgBar.ProgressCancel = function () {
        $(".progress-container").css({ "display": "block" });
        $("#progress-label").text("CANCELLED");
        $("#progress-bar").stop().css({ "width": "100%", "background-color": "#ff8820", "box-shadow": "0 0 15px #ff8820", "border-radius": "100px" });

        setTimeout(function () {
            if ($("#progress-label").text() == "CANCELLED") {
                $(".progress-container").css({ "display": "none" });
                $("#progress-bar").css("width", 0);
                $.post('http://mythic_progbar/actionCancel', JSON.stringify({
                })
                );
            }
        }, 1000);
    };

    MythicProgBar.CloseUI = function () {
        $('.main-container').css({ "display": "none" });
        $(".character-box").removeClass('active-char');
        $(".character-box").attr("data-ischar", "false")
        $("#delete").css({ "display": "none" });
    };

    Com = function () {
        setTimeout(function () {
            $(".progress-container").css({ "display": "block" });
            $("#progress-label").text("COMPLETE");
            $("#progress-bar").stop().css({ "width": "100%", "background-color": "#51ff00", "box-shadow": "0 0 15px #51ff008a", "border-radius": "100px" });
        }, 500);

        setTimeout(function () {
            $(".progress-container").css({ "display": "none" });
            $("#progress-bar").css("width", 0);
        }, 1000);
    };

    window.addEventListener('message', function (event) {
        switch (event.data.action) {
            case 'mythic_progress':
                MythicProgBar.Progress(event.data);
                break;
            case 'mythic_progress_cancel':
                MythicProgBar.ProgressCancel();
                break;
        }
    })
});