
// ░██████╗░███████╗███╗░░██╗███████╗██████╗░░█████╗░██╗░░░░░  ░░░░░██╗░██████╗
// ██╔════╝░██╔════╝████╗░██║██╔════╝██╔══██╗██╔══██╗██║░░░░░  ░░░░░██║██╔════╝
// ██║░░██╗░█████╗░░██╔██╗██║█████╗░░██████╔╝███████║██║░░░░░  ░░░░░██║╚█████╗░
// ██║░░╚██╗██╔══╝░░██║╚████║██╔══╝░░██╔══██╗██╔══██║██║░░░░░  ██╗░░██║░╚═══██╗
// ╚██████╔╝███████╗██║░╚███║███████╗██║░░██║██║░░██║███████╗  ╚█████╔╝██████╔╝
// ░╚═════╝░╚══════╝╚═╝░░╚══╝╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝  ░╚════╝░╚═════╝░

Config = []

Config.PreloadScreen = false // Loading screen the first time you open the phone, it helps performance as it is a preload.
Config.LockscreenFirstDay = false // if true = Saturday, 22 October, if false = Saturday, October 22 (In app store too).

Config.SmartphoneFPSMeter = false // If you enable this, you will be able to see the Smartphone FPS (ONLY FOR PERFORMANCE TEST!!!!).

Config.DefaultAlbum = 'Album' // This is the prefix for Gallery Albums.

Config.JobsBlockedToContact = [ // Skip this part.
    "police",
    "ambulance",
    "mechanic",
]

// Safari Favorites
Config.SafariFavorite_1 = "https://www.bing.com/"
Config.SafariFavorite_2 = "https://emupedia.net/beta/emuos/"
Config.SafariFavorite_3 = "https://www.elmundo.es/traductor/"
Config.SafariFavorite_4 = "https://www.quasar-store.com/"

// Images routes

 // Garage APP
Config.GarageImages = './img/garage/' // Config.GarageImgaes = 'nui://qs-images/html/img/garage_jpg/'
Config.GarageExtension = '.jpg'

 // BlackMarket
Config.DarkWebImages = 'img/darkweb_items/' // Config.DarkWebImages = 'nui://qs-images/html/img/BlackMarket/'
Config.DarkWebExtension = '.png'

// Songs that will appear by default in the YouTube App! 
// Some copyrighted videos will not play.
const VideosArray = [
    {
        url: 'https://www.youtube.com/watch?v=DZiaXEIQgkE',
    }, 
    {
        url: 'https://www.youtube.com/watch?v=2eaIxuJxxm8'
    },
    {
        url: 'https://www.youtube.com/watch?v=K5kD_vYnbe4'
    },
    {
        url: 'https://www.youtube.com/watch?v=8F2s8ivKXNY'
    },
    {
        url: 'https://www.youtube.com/watch?v=xpWIdf-tCFc'
    },
    {
        url: 'https://www.youtube.com/watch?v=ppF08KhVXIk'
    },
    {
        url: 'https://www.youtube.com/watch?v=mpHvHGMZ0jc'
    },
]

// Music and configuration of the Spotify app!
const SpotifyArray = [{ // Don't touch this
    name: 'Liked Songs',
    description: 'Escucha tu musica guardada y favorita!',
    thumbnail: 'https://t.scdn.co/images/3099b3803ad9496896c43f22fe9be8c4.png',
    playlists: []
}, // Don't touch this until here
{
    name: 'Pop',
    description: 'The best pop music in English of 2022 for u!',
    thumbnail: 'https://i1.sndcdn.com/artworks-i9YJYo6ag1fpym6b-tD6LVA-t500x500.jpg',
    playlists: [{
            url: "https://www.youtube.com/watch?v=CboIIxKd12Q",
        },
        {
            url: "https://www.youtube.com/watch?v=rBG-z-vtZfI",
        },
        {
            url: "https://www.youtube.com/watch?v=Ia6NYheR8Eo",
        },
        {
            url: "https://www.youtube.com/watch?v=1qjuKXw0tC4",
        },
        {
            url: "https://www.youtube.com/watch?v=M7uof6Im6Do",
        },
        {
            url: "https://www.youtube.com/watch?v=oRUZ5AqD-Gc",
        },
        {
            url: "https://www.youtube.com/watch?v=xN5SarTkWd8",
        },
        {
            url: "https://www.youtube.com/watch?v=tg4EhjKKKco",
        },
        {
            url: "https://www.youtube.com/watch?v=C9sg8MBg-uM",
        },
    ]
},
{
    name: 'Trap',
    description: 'The best trap music in English of 2022 for u!',
    thumbnail: 'https://assets1.sharedplaylists.cdn.crowds.dk/playlists/03/09/34/sz300x300_trap-and-bass-trending-now-magic-music-c36184d472.jpeg',
    playlists: [{
            url: "https://www.youtube.com/watch?v=VDg7ATYWvjE",
        },
        {
            url: "https://www.youtube.com/watch?v=yvCYWPe8-bM"
        },
        {
            url: "https://www.youtube.com/watch?v=IcJgCuWmhlM"
        },
        {
            url: "https://www.youtube.com/watch?v=cErCZLTrLQU"
        },
        {
            url: "https://www.youtube.com/watch?v=vLZ67WT84oA"
        },
        {
            url: "https://www.youtube.com/watch?v=75k6zia27Hs"
        },
        {
            url: "https://www.youtube.com/watch?v=uemkb0PpW3c"
        },
        {
            url: "https://www.youtube.com/watch?v=rXoTj6mHHaQ"
        },
        {
            url: "https://www.youtube.com/watch?v=UJIQWLxN4j0"
        },
    ]
},
{
    name: 'Tech',
    description: 'The best tech music in English of 2022 for u!',
    thumbnail: 'https://i.scdn.co/image/ab67706c0000bebbdf7dfdf2d19db3dc458565cf',
    playlists: [{
            url: "https://www.youtube.com/watch?v=Tr_7Iu3xVvA",
        },
        {
            url: "https://www.youtube.com/watch?v=V2E2aF1qQ4E"
        },
        {
            url: "https://www.youtube.com/watch?v=m-gLFcfPCts"
        },
        {
            url: "https://www.youtube.com/watch?v=HujNQRTxrxk"
        },
        {
            url: "https://www.youtube.com/watch?v=JOzAentQ3d8"
        },
        {
            url: "https://www.youtube.com/watch?v=myU2NXvlvVU"
        },
        {
            url: "https://www.youtube.com/watch?v=Y2Lu0o3S2sU"
        },
        {
            url: "https://www.youtube.com/watch?v=vE4h9Z_tLYk"
        },
        {
            url: "https://www.youtube.com/watch?v=nNqCvnDTSDo"
        },
        {
            url: "https://www.youtube.com/watch?v=UJz6nhAPIR8"
        },
    ]
},
{
    name: 'Synthwave',
    description: 'The best synth music in English of 2022 for u!',
    thumbnail: 'https://i.scdn.co/image/ab67706c0000bebb0d93adc83a4e3bc895242d37',
    playlists: [{
            url: "https://www.youtube.com/watch?v=DxPg6YQIqWE",
        },
        {
            url: "https://www.youtube.com/watch?v=G3HT7JLcUhs"
        },
        {
            url: "https://www.youtube.com/watch?v=Gv0OSpS2ABU"
        },
        {
            url: "https://www.youtube.com/watch?v=HMojqnyB_zs"
        },
        {
            url: "https://www.youtube.com/watch?v=rKUXexTmqAQ"
        },
        {
            url: "https://www.youtube.com/watch?v=3lF8Op_3YtU"
        },
        {
            url: "https://www.youtube.com/watch?v=nQ1GVX66P-A"
        },
        {
            url: "https://www.youtube.com/watch?v=vt2JwpP3A3g"
        },
    ]
},
{
    name: 'Dubstep',
    description: 'The best dubs music in English of 2022 for u!',
    thumbnail: 'https://i.scdn.co/image/ab67706c0000bebb11a2fa646c9d882e2f52579e',
    playlists: [{
            url: "https://www.youtube.com/watch?v=49mZuZ7De58",
        },
        {
            url: "https://www.youtube.com/watch?v=dko41CQGgbE"
        },
        {
            url: "https://www.youtube.com/watch?v=zfyklFvstck"
        },
        {
            url: "https://www.youtube.com/watch?v=U0Qi6Zaxr8A"
        },
        {
            url: "https://www.youtube.com/watch?v=6ZIyvPr1lvw"
        },
        {
            url: "https://www.youtube.com/watch?v=omONxdFuntg"
        },
        {
            url: "https://www.youtube.com/watch?v=QSJljnPhiHI"
        },
        {
            url: "https://www.youtube.com/watch?v=KZ_eXk5t0r0"
        },
    ]
},
]

Config.ConnectionBypassApps = [ // Applications that you can open without a telephone signal.
    "settings",
    "help",
    "weather",
    "notes",
    "camera",
    "photos",
    "clock",
    "jump",
    "calculator",
    "meos",
    "flappy",
    "kong",
    "pacman"
]

// Don't touch this, it won't make any changes.
Config.HeaderDisabledApps = [
    "bank",
    "whatsapp",
    "meos",
    "garage",
    "racing",
    "lawyers",
    "youtube",
]

// Weather translations for your widget.
function WeatherTranslation(x) {
    if (x == "RAIN") { x = "Rain" }
    else if (x == "THUNDER") { x = "Thunder" }
    else if (x == "CLEARING") { x = "Clearing" }
    else if (x == "CLEAR") { x = "Clear" }
    else if (x == "EXTRASUNNY") { x = "Extrasunny" }
    else if (x == "CLOUDS") { x = "Clouds" }
    else if (x == "OVERCAST") { x = "Overcast" }
    else if (x == "SMOG") { x = "Smog" }
    else if (x == "FOGGY") { x = "Foggy" }
    else if (x == "XMAS") { x = "Christmas" }
    else if (x == "SNOWLIGHT") { x = "Snowlight" }
    else if (x == "BLIZZARD") { x = "Blizzard" }
    else if (x == "BILINMIYOR") { x = "Other" } else { x = "Other" }
    return x
}

// Dates of your phone.
Config.January = "January"
Config.February = "February"
Config.March = "March"
Config.April = "April"
Config.May = "May"
Config.June = "June"
Config.July = "July"
Config.August = "August"
Config.September = "September"
Config.October = "October"
Config.November = "November"
Config.December = "December"

Config.Jan = "Jan"
Config.Feb = "Feb"
Config.Mar = "Mar"
Config.Apr = "Apr"
Config.May = "May"
Config.Jun = "Jun"
Config.Jul = "Jul"
Config.Aug = "Aug"
Config.Sept = "Sept"
Config.Oct = "Oct"
Config.Nov = "Nov"
Config.Dec = "Dec"

Config.Sunday = "Sunday"
Config.Monday = "Monday"
Config.Tuesday = "Tuesday"
Config.Wednesday = "Wednesday"
Config.Thursday = "Thursday"
Config.Friday = "Friday"
Config.Saturday = "Saturday"

Config.Everyday = "Every day"
Config.Weekend = "Weekend"
Config.Weekdays = "Weekdays"

// App state, remember to edit the html too.
Config.Job1 = "police" // Default "police"
Config.Job2 = "ambulance" // Default "ambulance"
Config.Job3 = "realestate" // Default "realestate"
Config.Job4 = "taxi" // Default "taxi"

// Color of the header and home-bar of each application.
Config.HeaderColors = {
    "image-zoom": {
        "top": "#000000",
        "bottom": "#FFFFFF"
    },
    "phone": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "photos": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "messages": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "settings": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "clock": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "camera": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "mail": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "bank": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "weather": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "notes": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "calendar": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "calculator": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "store": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "ping": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "tiktok": {
        "top": "#FFFFFF",
        "bottom": "#000000"
    },
    "spotify": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "business": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "safari": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "advert": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "garage": {
        "top": "#FFFFFF",
        "bottom": "#000000"
    },
    "group-chats": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "instagram": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "tips": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "meos": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "state": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "tinder": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "twitter": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "uber": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "uberDriver": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "weazel": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "whatsapp": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "youtube": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "darkchat": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "darkweb": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "phone-call": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "rentel": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "racing": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "flappy": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "jump": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "kong": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "pacman": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "tower": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "labyrinth": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "crypto": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "radio": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "sellix": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "example": {
        "top": "#000000",
        "bottom": "#000000"
    },
}