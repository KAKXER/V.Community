
// ██████╗░██╗░██████╗░█████╗░░█████╗░██████╗░██████╗░  ██████╗░░█████╗░░█████╗░███╗░░░███╗░██████╗
// ██╔══██╗██║██╔════╝██╔══██╗██╔══██╗██╔══██╗██╔══██╗  ██╔══██╗██╔══██╗██╔══██╗████╗░████║██╔════╝
// ██║░░██║██║╚█████╗░██║░░╚═╝██║░░██║██████╔╝██║░░██║  ██████╔╝██║░░██║██║░░██║██╔████╔██║╚█████╗░
// ██║░░██║██║░╚═══██╗██║░░██╗██║░░██║██╔══██╗██║░░██║  ██╔══██╗██║░░██║██║░░██║██║╚██╔╝██║░╚═══██╗
// ██████╔╝██║██████╔╝╚█████╔╝╚█████╔╝██║░░██║██████╔╝  ██║░░██║╚█████╔╝╚█████╔╝██║░╚═╝░██║██████╔╝
// ╚═════╝░╚═╝╚═════╝░░╚════╝░░╚════╝░╚═╝░░╚═╝╚═════╝░  ╚═╝░░╚═╝░╚════╝░░╚════╝░╚═╝░░░░░╚═╝╚═════╝░

RenderPinnedChatRooms = (PinnedChatRooms) => {
    let container = $("#pinned-rooms-list")
    if( ! $.isEmptyObject(PinnedChatRooms)) {
        $.each(PinnedChatRooms, function (i, Room) {
            if( ! Room.is_masked) {
                switch(Room.room_name) {
                    case "Events":
                        icon = '<i class="far fa-calendar-alt"></i>'
                    break
                    case "Social":
                        icon = '<i class="fas fa-hands-helping"></i>'
                    break
                    case "The Lounge":
                        icon = '<i class="fas fa-couch"></i>'
                    break
                }

                let element = `
                    <div class="pinned-chat-listing" data-roomID="${Room.id}">
                        <div class="pinned-chat-name">
                            ${Room.room_name}
                        </div>

                        <div class="pinned-chat-icon">
                            ${icon}
                        </div>
                    </div>
                `;

                container.append(element)
            }
        })
    }
}