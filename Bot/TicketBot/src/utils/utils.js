import Fs from "fs";
import Discord from "discord.js";
const {
  EmbedBuilder,
  ActionRowBuilder,
  ButtonBuilder,
  TextInputBuilder,
  ModalBuilder,
  Colors,
} = Discord;
import Config from "../config.js";
class Utils {
  static login(Bot) {
    Bot.login(Config.TOKEN ? Config.TOKEN : process.env.TOKEN)
      .then(() => console.log("Ticket Bot Running"))
      // .catch((err) => console.log("" + err));
  }

  static event(Bot) {
    Fs.readdirSync("./src/events").forEach(async (file) => {
      const Event = await import(`../events/${file}`).then((x) => x);

      Event.default(Bot);
    });
  }

  static embed(Content, Guild, Bot, User) {
    const Embed = new EmbedBuilder()
      .setAuthor({
        name: `IR.V Ticket Manager`,
        iconURL: Guild.iconURL({ dynamic: true }),
      })

      .setDescription(Content)
      // .setColor(Colors.DarkNavy)
      .setColor("#009000")
      .setFooter({
        text: `IR.V Development™ | IR.V Management | ${new Date(Date.now()).toLocaleString()}`,
        iconURL: Bot.user.avatarURL({ dynamic: true }),
      })
      // .setTimestamp()
      .setThumbnail(
        User
          ? User.avatarURL({ dynamic: true })
          : Guild.iconURL({ dynamic: true })
      );

    return Embed;
  }

  static embed2(Content, Guild, Bot, User) {
    const Embed = new EmbedBuilder()
      .setAuthor({
        name: `IR.V Ticket Manager`,
        iconURL: Guild.iconURL({ dynamic: true }),
      })

      .setDescription(Content)
      // .setColor(Colors.DarkNavy)
      .setColor("#009000")
      .setFooter({
        text: `IR.V Development™`,
        
        iconURL: Bot.user.avatarURL({ dynamic: true }),
      })
      // .setTimestamp()
      .setThumbnail('https://cdn.discordapp.com/attachments/689238583982293041/1039181009255682139/IR.V_9.png')
      .setImage('https://cdn.discordapp.com/attachments/996093699060678677/1039997591150145586/IR.V_Ticket.png')

    return Embed;
  }

  // static button(Style, Label, Emoji, Id, Disabled) {
  //   const Row = new ActionRowBuilder().addComponents(
  //     new ButtonBuilder()
  //       .setCustomId(Id)
  //       .setLabel(Label)
  //       .setStyle(Style)
  //       .setEmoji(Emoji)
  //       .setDisabled(Disabled)
  //   );

  //   return Row;
  // }

  static button() {
    let Buttons = [];

    Config.TICKET.BUTTONASLI.map((x) => {
      const Button = new ButtonBuilder()
        .setCustomId(x.ID)
        .setLabel(x.LABEL)
        .setStyle(x.STYLE)
        .setEmoji(x.EMOTE)
        .setDisabled(x.DISABLED);

      Buttons.push(Button);
    });

    let Row = new ActionRowBuilder().addComponents(Buttons);

    return Row;
  }

  static ticketButton() {
    // console.log("sdadasdasda");
    let Buttons = [];

    Config.TICKET.BUTTONS.map((x) => {
      const Button = new ButtonBuilder()
        .setCustomId(x.ID)
        .setLabel(x.LABEL)
        .setStyle(x.STYLE)
        .setEmoji(x.EMOTE)
        .setDisabled(x.DISABLED);

      Buttons.push(Button);
    });

    let Row = new ActionRowBuilder().addComponents(Buttons);

    return Row;
  }

  static modal(data) {
  
    let Inputs = [];

    Config.TICKET.QUESTIONS.map((v) => {
      const Input = new TextInputBuilder()
 
        .setCustomId(v.ID)
        .setLabel(v.LABEL)
        .setStyle(v.STYLE)
        .setMinLength(v.MIN_LENGTH)
        .setMaxLength(v.MAX_LENGTH)
        .setPlaceholder(v.PLACE_HOLDER)
        .setRequired(v.REQUIRED);

      Inputs.push(Input);
    });


    let Modals = new ModalBuilder()
      .setCustomId(data)
      .setTitle("Form Zir Ra Takmil Konid.")
    let Row = [];
    Inputs.map((x) => Row.push(new ActionRowBuilder().addComponents([x])));
    Modals.addComponents(Row);

    return Modals;
  }
}

export default Utils;
