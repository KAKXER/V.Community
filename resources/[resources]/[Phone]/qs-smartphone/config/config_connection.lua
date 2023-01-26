
--░█████╗░░█████╗░███╗░░██╗███╗░░██╗███████╗░█████╗░████████╗██╗░█████╗░███╗░░██╗
--██╔══██╗██╔══██╗████╗░██║████╗░██║██╔════╝██╔══██╗╚══██╔══╝██║██╔══██╗████╗░██║
--██║░░╚═╝██║░░██║██╔██╗██║██╔██╗██║█████╗░░██║░░╚═╝░░░██║░░░██║██║░░██║██╔██╗██║
--██║░░██╗██║░░██║██║╚████║██║╚████║██╔══╝░░██║░░██╗░░░██║░░░██║██║░░██║██║╚████║
--╚█████╔╝╚█████╔╝██║░╚███║██║░╚███║███████╗╚█████╔╝░░░██║░░░██║╚█████╔╝██║░╚███║
--░╚════╝░░╚════╝░╚═╝░░╚══╝╚═╝░░╚══╝╚══════╝░╚════╝░░░░╚═╝░░░╚═╝░╚════╝░╚═╝░░╚══╝
-- Exclusive configuration for 4G/5G signal, this will allow you to use or not use some functions of your phone, depending on the area.

Config.Signal = false -- If you want to enable this system, use true.
Config.visibleZone = false -- Leave this false whenever you are going to use the server, it is only for zone testing.

-- Mountains and zones blocked for low signal, here is the complete PolyZone.
-- Within this PolyZone, you will not be able to use certain apps or receive calls.
Config.Mountains = {
    {
        coords = {
            vector2(-331.82, 5704.55),
            vector2(1383.33, 6353.03),
            vector2(2492.42, 5231.82),
            vector2(1486.36, 5159.09),
            vector2(1413.64, 4516.67),
            vector2(771.21, 4262.12),
            vector2(-210.61, 4219.70),
            vector2(-240.91, 3759.09),
            vector2(19.70, 3334.85),
            vector2(-1331.82, 2807.58),
            vector2(-1665.15, 3365.15),
            vector2(-2307.58, 3607.58),
            vector2(-1998.48, 4334.85),
        },
        minz = 0,
        maxz = 800

    },
    {
        coords = {
            vector2(1868.18, 1656.06),
            vector2(1631.82, 831.82),
            vector2(1280.30, 425.76),
            vector2(1346.97, 25.76),
            vector2(1516.67, -901.52),
            vector2(2056.06, -453.03),
            vector2(2456.06, 365.15),
            vector2(2274.24, 1062.12)
        },
        minz = 0,
        maxz = 800
    },
    {
        coords = {
            vector2(4177.27, 50.00),
            vector2(3068.18, 1819.70),
            vector2(2734.85, 171.21),
            vector2(1322.73, -1228.79),
            vector2(1789.39, -2883.33),
            vector2(2486.36, -2780.30),
            vector2(3425.76, -2513.64),
            vector2(4165.15, -1816.67)
        },
        minz = 0,
        maxz = 800
    },

}