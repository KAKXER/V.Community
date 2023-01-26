let sender = false;
let serverId;
let callId;
let streaming = false;
let watching = false;
const RTCServers = {
	iceServers: [{
		urls: ["stun:stun1.l.google.com:19302", "stun:stun2.l.google.com:19302"],
	}, ],
	iceCandidatePoolSize: 10,
};

async function handleSignallingData(data) {
	switch (data.type) {
		case "offer":
			let sessionDesc = new RTCSessionDescription(data.offer);
			await peerConn.setRemoteDescription(sessionDesc);
			// peerConn.setRemoteDescription(data.offer);
			createAndSendAnswer();
			break;
		case "candidate":
			let candidate = new RTCIceCandidate(data.candidate);
			peerConn.addIceCandidate(candidate);
	}
}

async function createAndSendAnswer() {
	let candidateAnswer = await peerConn.createAnswer();
	await peerConn.setLocalDescription(candidateAnswer);

	let answerObject = {
		sdp: candidateAnswer.sdp,
		type: candidateAnswer.type
	}
	sendData({
		type: "send_answer",
		answer: answerObject,
	});
}

function sendData(data) {
	//todo global
	data.callId = parseInt(callId);
	data.serverId = parseInt(serverId);
	$.post("https://qs-videos/sendData", JSON.stringify(data));
}

let localStream;
let peerConn;

let recordedChunks = [];

function formatBytes(bytes, decimals = 2) {
	if (bytes === 0) return '0 Bytes';

	const k = 1024;
	const dm = decimals < 0 ? 0 : decimals;
	const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];

	const i = Math.floor(Math.log(bytes) / Math.log(k));

	return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
}

const bytesToMegaBytes = bytes => bytes / (1024 ** 2);

function download() {
	const blob = new Blob(recordedChunks, {
		type: "video/webm"
	});
	const size = bytesToMegaBytes(blob.size)
	if (size > 10) {
		$.post('https://qs-videos/SizeTooLarge')
		return
	}
	clearTimeout(timeOut)
	let myHeaders = new Headers();
	let formData = new FormData();
	$.post('https://qs-videos/WaitForVideo')
	formData.append("file", blob, "video.webm");
	let requestOptions = {
		method: 'POST',
		headers: myHeaders,
		body: formData,
		redirect: 'follow'
	}
	fetch(Config.Webhook, requestOptions)
		.then(response => response.text())
		.then(result => {
			/* console.log('result', result) */
			$.post('https://qs-videos/WaitForVideo')
			result = JSON.parse(result)
			if (result.attachments) {
				$.post('https://qs-videos/SaveTiktokVideo', JSON.stringify({
					url: result.attachments[0].proxy_url
				}))
			}
		}).catch(error => console.log('error', error));
}

let mediaRecorder

function joinCall() {
	$.post("https://qs-videos/addStartCall");
	watching = true;
	callId = serverId;
	peerConn = new RTCPeerConnection(RTCServers);
	let canvas = document.getElementById("local-video");
	MainRender.renderToTarget(canvas);
	let stream = canvas.captureStream();

	localStream = stream;
	document.getElementById("local-video").srcObject = localStream;

	let video = document.getElementById("remote-video");
	video.srcObject = new MediaStream(); //? create a media stream for remote stream

	peerConn.onicecandidate = (e) => {
		if (e.candidate == null) return;
		// console.log(JSON.stringify(e.candidate))
		let candidate = new RTCIceCandidate(e.candidate);
		peerConn.addIceCandidate(candidate);
		sendData({
			type: "send_candidate",
			candidate: candidate,
		});
	};

	peerConn.ontrack = (event) => {
		event.streams[0].getTracks().forEach((track) => {
			video.srcObject.addTrack(track);
		});
	};

	localStream.getTracks().forEach(function(track) {
		peerConn.addTrack(track, localStream);
	});

	sendData({
		type: "join_call",
	});
}

function handleDataAvailable(event) {
	recordedChunks = [];
	/* console.log("data-available"); */
	if (event.data.size > 0) {
		recordedChunks.push(event.data);
		download();
	}
}

let timeOut = false

async function startCall() {
	streaming = true;
	$.post("https://qs-videos/addStartCall");
}

async function startRecorder() {
	streaming = true;
	sender = true;
	let canvas = document.getElementById("local-video");
	MainRender.renderToTarget(canvas);
	let stream = canvas.captureStream();

	const options = {
		mimeType: "video/webm; codecs=vp9"
	};
	mediaRecorder = new MediaRecorder(stream, options)

	mediaRecorder.ondataavailable = handleDataAvailable;
	mediaRecorder.start()
	timeOut = setTimeout(() => {
		if (mediaRecorder.state == 'recording') {
			$.post('https://qs-videos/stopRecord')
			$.post('https://qs-videos/SizeTooLarge')
			stopCall();
		}
	}, 23000);
	localStream = stream;
	document.getElementById("local-video").srcObject = localStream;
}


window.addEventListener("keydown", function(event) {
	if (event.which == 27) { // ESC
		$.post('https://qs-videos/stopRecord')
		stopCall();
	}
})

function stopCall() {
	if (streaming) {
		streaming = false;
		sender = false;
		serverId = null
		callId = null
		$.post(
			"https://qs-videos/stopVideoCall",
			JSON.stringify({
				serverId: serverId,
				callId: callId
			})
		);
		mediaRecorder.stop();
		MainRender.stop();
		let video = document.getElementById("remote-video");
		video.pause();
		video.srcObject = null;
	}
}

window.addEventListener("message", function(e) {
	const message = e.data;
	if (message.type == 'openRecorder') {
		startCall()
	} else if (message.type == 'startRecorder') {
		startRecorder();
	} else if (message.type == 'stopRecorder') {
		stopCall();
	}
});