fx_version 'bodacious'

game 'common'

version '2.1.9'

lua54 'yes'

files {
       "module/*.js",
       "module/animation/tracks/*.js",
       "module/animation/*.js",
       "module/audio/*js",
       "module/cameras/*.js",
       "module/core/*.js",
       "module/extras/core/*.js",
       "module/extras/curves/*.js",
       "module/extras/objects/*.js",
       "module/extras/*.js",
       "module/geometries/*.js",
       "module/helpers/*.js",
       "module/lights/*.js",
       "module/loaders/*.js",
       "module/materials/*.js",
       "module/math/interpolants/*.js",
       "module/math/*.js",
       "module/objects/*.js",
       "module/renderers/shaders/*.js",
       "module/renderers/shaders/ShaderChunk/*.js",
       "module/renderers/shaders/ShaderLib/*.js",
       "module/renderers/webgl/*.js",
       "module/renderers/webxr/*.js",
       "module/renderers/webvr/*.js",
       "module/renderers/*.js",
       "module/scenes/*.js",
       "module/textures/*.js",
       "config/config.js",
       "html/js/script.js",
       "html/index.html",
       "html/js/videoCall.js",
       "html/css/style.css",


       'nui://IRV-inventory/ui/images/*.png',
       'nui://qs-images/html/img/garage_jpg/*.jpg',
       'nui://qs-images/html/img/garage_jpg/*.jpg'
}
   

client_script {
       "client/main.lua",
       "config/config.lua",
       "config/translations.lua",
}

server_script {
       "server/main.lua",
}

ui_page "html/index.html"

escrow_ignore {
       "config/config.lua",
       "config/translations.lua",
}
dependency '/assetpacks'