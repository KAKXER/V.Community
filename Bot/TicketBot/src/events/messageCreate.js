import Utils from "../utils/utils.js";
import Config from "../config.js";
import Discord from "discord.js";
const { ButtonStyle } = Discord;

export default (Bot) => {
  Bot.on("messageCreate", (message) => {
    const Prefix = message.content.toLowerCase().startsWith(Config.PREFIX);

    if (!Prefix && !message.guild) return;

    const Args = message.content.split(" DSA").slice(1);
    const Command = message.content.split("DSA ")[0].slice(Config.PREFIX.length);

    if (Command === "ticket") {
      if (!message.member.permissions.has("0x0000000000000008"))
        return message.reply({
          content: "Shoma **Permission Kafi** Baraye Estefade Az In **Command** Ra Nadarid!",
        });

      message.delete().catch(() => {
        return undefined;
      });

      let TicketChannel = message.guild.channels.cache.get(
        Config.TICKET.CHANNEL
      );

      if (!TicketChannel)
        return message.reply({
          content: "Lotfan `channel ID` Ra Dar File **Config** Kamel Vared Konid!",
        });

      TicketChannel.send({
        embeds: [Utils.embed2(Config.TICKET.MESSAGE, message.guild, Bot, "")],
        components: [ 
          Utils.button( ButtonStyle.Success, "1", "🎫", "ticket", false),
          Utils.button( ButtonStyle.Danger, "2", "🎫", "report", false),
          Utils.button( ButtonStyle.Secondary, "3", "🎫", "competence", false),
        ],
        
        components: [Utils.button()],
       
      });

      return;
    }
  });
};
