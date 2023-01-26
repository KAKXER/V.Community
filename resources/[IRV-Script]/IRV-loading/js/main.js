$(() => {
    const ImageCount = 6 // increase this if you add more images to the img folder

    const ChangeBackground = () => {
        let randomBG = Math.floor(Math.random() * ImageCount) + 1;
        if ($(".background").css("background-image").includes(`/img/${randomBG}.png`)) return ChangeBackground();
        anime({
            targets: [".curtains"],
            opacity: [0,1],
            duration: 1000,
            easing:"linear",

            complete: () => {
                $(".background").css("background-image", `url(./img/${randomBG}.png)`);
                anime({
                    targets: [".curtains"],
                    opacity: [1,0],
                    duration: 1000,
                    easing:"linear",
                });
            }
        })
    }

    const CenterAnimation = () => {
        anime({
            targets: [".header"],
            scale: [
                {value: 1.3, duration: 1},
                {value: .8, duration: 1000},
                {value: 0, duration: 1000, delay:1000, easing:"easeInOutQuad"},
            ],
            opacity: [
                {value: 0, duration: 1},
                {value: 1, duration: 1000},
                {value: 0, duration: 1000, delay:1000, easing:"easeInOutQuad"},
            ],
            duration:1000,
            easing:"easeOutQuad",

            complete: () => {
                anime({
                    targets: [".logo"],
                    scale: [1.5, 1],
                    opacity: [0,1],
                    duration:2000,
                    easing:"easeOutQuad",
                    begin: () => {
                        $(".logo").css({display:"block"}), $(".header").css({display:"none"})
                        anime({
                            targets: [".logo-footer"],
                            letterSpacing: ["0", "0.2rem"],
                            duration:2000,
                            easing:"easeOutQuad",
                        })
                    }
                })
            }
        })
    }

    const bgmusic = new Audio("./bgmusic.mp3");
    bgmusic.loop = true;
    bgmusic.autoplay = true;
    bgmusic.volume = .1;
    bgmusic.play();

    window.addEventListener("keyup", e => {
        if (e.key === " ") {
            bgmusic.paused ? bgmusic.play() : bgmusic.pause();
        }
    })

    CenterAnimation()

    setInterval(ChangeBackground, 10000);
    particlesJS("particles", {
      "particles": {
        "number": {
          "value": 80,
          "density": {
            "enable": true,
            "value_area": 800
          }
        },
        "color": {
          "value": "#35AC50"
        },
        "shape": {
          "type": "circle",
          "stroke": {
            "width": 0,
            "color": "#000000"
          },
          "polygon": {
            "nb_sides": 5
          },
          "image": {
            "src": "img/github.svg",
            "width": 100,
            "height": 100
          }
        },
        "opacity": {
          "value": 0.5,
          "random": true,
          "anim": {
            "enable": false,
            "speed": 1,
            "opacity_min": 0.1,
            "sync": false
          }
        },
        "size": {
          "value": 3,
          "random": true,
          "anim": {
            "enable": false,
            "speed": 40,
            "size_min": 0.1,
            "sync": false
          }
        },
        "line_linked": {
          "enable": false,
          "distance": 150,
          "color": "#ffffff",
          "opacity": 0.4,
          "width": 1
        },
        "move": {
          "enable": true,
          "speed": 1.5782952832645452,
          "direction": "bottom",
          "random": true,
          "straight": false,
          "out_mode": "out",
          "bounce": false,
          "attract": {
            "enable": true,
            "rotateX": 1200,
            "rotateY": 1200
          }
        }
      },
      "interactivity": {
        "detect_on": "canvas",
        "events": {
          "onhover": {
            "enable": false,
            "mode": "repulse"
          },
          "onclick": {
            "enable": false,
            "mode": "push"
          },
          "resize": true
        },
        "modes": {
          "grab": {
            "distance": 400,
            "line_linked": {
              "opacity": 1
            }
          },
          "bubble": {
            "distance": 400,
            "size": 40,
            "duration": 2,
            "opacity": 8,
            "speed": 3
          },
          "repulse": {
            "distance": 200,
            "duration": 0.4
          },
          "push": {
            "particles_nb": 4
          },
          "remove": {
            "particles_nb": 2
          }
        }
      },
      "retina_detect": true
    })

})
