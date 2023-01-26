let playTime = 0;
setInterval(() => {
    playTime+= 60;
    $('#tedad_playing').text(calculateJoinedTime(playTime));
}, 60000);
$(document).ready(function () {
    window.addEventListener('message', function (event) {
        if (event.data.type == 'toggle') {
            if (event.data.action) {
                $("#Display").css("opacity", 1);
            } else {
                $("#Display").css("opacity", 0);
            }
        } else if (event.data.type == 'updateInfo') {
            let dt = event.data.data;
            $('#tedad_admins').text(dt.admins);
            $('#tedad_players').text(dt.players);
            $('#tedad_id').text(dt.id);
            if (dt.isadmin) {
                $("#admin_data").css("opacity", 1);
                $('#info_data').css("top", "9.792vw"); 
                $('#tedad_police').text(dt.police);
                $('#tedad_medic').text(dt.ambulance);
                $('#tedad_taxi').text(dt.taxi);
                $('#tedad_mechanic').text(dt.mecano);
            } else {
                $("#admin_data").css("opacity", 0);
                $('#info_data').css("top", "5.104vw");
            }
        }
    });
});
function calculateJoinedTime(d) {
    d = Number(d);
    var h = Math.floor(d / 3600);
    var m = Math.floor(d % 3600 / 60);
    return `${h.toString().padStart(2, 0)}:${m.toString().padStart(2, 0)}`;
}