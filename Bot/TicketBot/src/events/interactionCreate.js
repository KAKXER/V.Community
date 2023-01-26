import Utils from "../utils/utils.js";
import Config from "../config.js";
import Discord, { Colors } from "discord.js";
const {
  ButtonBuilder,
  ActionRowBuilder,
  PermissionFlagsBits,
  InteractionType,
  ChannelType,
} = Discord;

export default (Bot) => {
  Bot.on("interactionCreate", async (interaction) => {

    if (interaction.type === InteractionType.ModalSubmit) {
     
      if (interaction.customId === "ticket") {
        let Questions = Config.TICKET.QUESTIONS.map((x) => x.LABEL);

        let fields = [];

        [interaction.fields].map((z) =>
          z.fields.map((x) => {
            fields.push(x);
          })
        );

        let Value = fields.map((x) => x.value);
        let Output = Value.map((x, i) => ({
          Questions: Questions[i],
          Value: x,
        }));
        let Content = Output.map(
          (x, index) =>
            `\n> **${x.Questions}:** \`${x.Value}\``
        ).join("\n");
        
        const Channel = interaction.guild.channels.cache.find(
         
          (x) => x.name === Config.TICKET.BUTTONASLI[0].LABEL + "-" + interaction.user.id
        );

        await interaction.deferReply({ ephemeral: true });

        if (Channel) {
          interaction.followUp({
            content: `Shoma Ghablan Yek Ticket Create Kardid!`,
            ephemeral: true,
          });
        } else {
          let PermissionsArray = [
            {
              id: interaction.user.id,
              allow: [
                PermissionFlagsBits.ViewChannel,
                PermissionFlagsBits.ReadMessageHistory,
                PermissionFlagsBits.SendMessages,
              ],
            },
            {
              id: interaction.guild.id,
              deny: [PermissionFlagsBits.ViewChannel],
            },
          ];

          Config.TICKET.STAFF_ROLES.map((x) => {
            PermissionsArray.push({
              id: x,
              allow: [
                PermissionFlagsBits.ViewChannel,
                PermissionFlagsBits.ReadMessageHistory,
                PermissionFlagsBits.SendMessages,
              ],
            });
          });

          interaction.guild.channels
            .create({
              name: Config.TICKET.BUTTONASLI[0].LABEL + "-" + interaction.user.id,
              type: ChannelType.GuildText,
              parent: Config.TICKET.CATEGORY,
              permissionOverwrites: PermissionsArray,
            })
            .then(async (Channel) => {
              interaction.followUp({
                content:
                  "Ticket Shoma Ba movafaghiyat Sakhte shod Lotfan Mozoee Khord Ra Dar Ticket Sharh Dahid.",
                ephemeral: true,
              });

              Channel.send({
                embeds: [
                  Utils.embed(
                    `**Information Ticket Sakhte Shode:** \n> User: ${interaction.user} \n> UserID: \`${interaction.user.id}\` \n${Content}`,
                    interaction.guild,
                    Bot,
                    interaction.user
                  ),
                ],
                components: [Utils.ticketButton()],
              });
            });
        }
      } else if (interaction.customId === "report") {
        let Questions = Config.TICKET.QUESTIONS.map((x) => x.LABEL);

        let fields = [];

        [interaction.fields].map((z) =>
          z.fields.map((x) => {
            fields.push(x);
          })
        );

        let Value = fields.map((x) => x.value);
        let Output = Value.map((x, i) => ({
          Questions: Questions[i],
          Value: x,
        }));
        let Content = Output.map(
          (x, index) =>
            `\n> **${x.Questions}:** \`${x.Value}\``
        ).join("\n");
      
        const Channel = interaction.guild.channels.cache.find(
          (x) => x.name === Config.TICKET.BUTTONASLI[1].LABEL + "-" + interaction.user.id
        );
       
        await interaction.deferReply({ ephemeral: true });

       
        if (Channel) {
          interaction.followUp({
            content: `Shoma Ghablan Yek Ticket Create Kardid!`,
            ephemeral: true,
          });
        } else {
          let PermissionsArray = [
            {
              id: interaction.user.id,
              allow: [
                PermissionFlagsBits.ViewChannel,
                PermissionFlagsBits.ReadMessageHistory,
                PermissionFlagsBits.SendMessages,
              ],
            },
            {
              id: interaction.guild.id,
              deny: [PermissionFlagsBits.ViewChannel],
            },
          ];

          Config.TICKET.STAFF_ROLES.map((x) => {
            PermissionsArray.push({
              id: x,
              allow: [
                PermissionFlagsBits.ViewChannel,
                PermissionFlagsBits.ReadMessageHistory,
                PermissionFlagsBits.SendMessages,
              ],
            });
          });

          interaction.guild.channels
            .create({
              name: Config.TICKET.BUTTONASLI[1].LABEL + "-" + interaction.user.id,
              type: ChannelType.GuildText,
              parent: Config.TICKET.CATEGORY,
              permissionOverwrites: PermissionsArray,
            })
            .then(async (Channel) => {
              interaction.followUp({
                content:
                  "Ticket Shoma Ba movafaghiyat Sakhte shod Lotfan Mozoee Khord Ra Dar Ticket Sharh Dahid.",
                ephemeral: true,
              });

              Channel.send({
                embeds: [
                  Utils.embed(
                    `**Information Ticket Sakhte Shode:** \n> User: ${interaction.user} \n> UserID: \`${interaction.user.id}\` \n${Content}`,
                    interaction.guild,
                    Bot,
                    interaction.user
                  ),
                ],
                components: [Utils.ticketButton()],
              });
            });
        }
      } else if (interaction.customId === "competence") {
        let Questions = Config.TICKET.QUESTIONS.map((x) => x.LABEL);

        let fields = [];

        [interaction.fields].map((z) =>
          z.fields.map((x) => {
            fields.push(x);
          })
        );

        let Value = fields.map((x) => x.value);
        let Output = Value.map((x, i) => ({
          Questions: Questions[i],
          Value: x,
        }));
        let Content = Output.map(
          (x, index) =>
            `\n> **${x.Questions}:** \`${x.Value}\``
        ).join("\n");
        
        const Channel = interaction.guild.channels.cache.find(
         
          (x) => x.name === Config.TICKET.BUTTONASLI[2].LABEL + "-" + interaction.user.id
        );

        await interaction.deferReply({ ephemeral: true });

        if (Channel) {
          interaction.followUp({
            content: `Shoma Ghablan Yek Ticket Create Kardid!`,
            ephemeral: true,
          });
        } else {
          let PermissionsArray = [
            {
              id: interaction.user.id,
              allow: [
                PermissionFlagsBits.ViewChannel,
                PermissionFlagsBits.ReadMessageHistory,
                PermissionFlagsBits.SendMessages,
              ],
            },
            {
              id: interaction.guild.id,
              deny: [PermissionFlagsBits.ViewChannel],
            },
          ];

          Config.TICKET.STAFF_ROLES.map((x) => {
            PermissionsArray.push({
              id: x,
              allow: [
                PermissionFlagsBits.ViewChannel,
                PermissionFlagsBits.ReadMessageHistory,
                PermissionFlagsBits.SendMessages,
              ],
            });
          });

          interaction.guild.channels
            .create({
              name: Config.TICKET.BUTTONASLI[2].LABEL + "-" + interaction.user.id,
              type: ChannelType.GuildText,
              parent: Config.TICKET.CATEGORY,
              permissionOverwrites: PermissionsArray,
            })
            .then(async (Channel) => {
              interaction.followUp({
                content:
                  "Ticket Shoma Ba movafaghiyat Sakhte shod Lotfan Mozoee Khord Ra Dar Ticket Sharh Dahid.",
                ephemeral: true,
              });

              Channel.send({
                embeds: [
                  Utils.embed(
                    `**Information Ticket Sakhte Shode:** \n> User: ${interaction.user} \n> UserID: \`${interaction.user.id}\` \n${Content}`,
                    interaction.guild,
                    Bot,
                    interaction.user
                  ),
                ],
                components: [Utils.ticketButton()],
              });
            });
        }
      }
    }

    if (!interaction.isButton()) return;

    if (interaction.customId === "ticket") {
      await interaction.showModal(Utils.modal("ticket"));     
    } else if (interaction.customId === "report") {
      await interaction.showModal(Utils.modal("report"));
    } else if (interaction.customId === "competence") {
      await interaction.showModal(Utils.modal("competence"));
    }

    if (interaction.customId === "successTicket") {
      if (!Config.TICKET.STAFF_ROLES.some((x) => interaction.member.roles.cache.has(x) ) && ![interaction.guild.ownerId].includes(interaction.user.id)
      ) {
        await interaction.deferReply({ ephemeral: true });
        // console.log(interaction);
        interaction.followUp({
          content: `Faghat **Team Staff** Mitavanad Ticket Shoma Ra **Taiid** Konand.`,
          ephemeral: true,
        });

        return;
      } else {
        await interaction.update({
          components: [
            new ActionRowBuilder({
              components: [
                ButtonBuilder.from(
                  interaction.message.components[0].components[0]
                ).setDisabled(true),
                ButtonBuilder.from(
                  interaction.message.components[0].components[1]
                ),
                ButtonBuilder.from(
                  interaction.message.components[0].components[2]
                ),
              ],
            }),
          ],
        });

        interaction.followUp({
          content: `Ticket Ba Movafaghiyat Taiid Shod.`,
          ephemeral: true,
        });

        interaction.channel.send({
          content: `Ticket Ba **Movafaghiyat** tavasot **Team Staff** Taiid Shod.`,
        });

        return;
      }
    }

    if (interaction.customId === "archiveTicket") {
      await interaction.deferReply({ ephemeral: true });

      if (
        !Config.TICKET.STAFF_ROLES.some((x) =>
          interaction.member.roles.cache.has(x)
        ) &&
        ![interaction.guild.ownerId].includes(interaction.user.id)
      )
        return interaction.followUp({
          content: "Faghat **Team Staff** Mitavanad Ticket Shoma Ra **Baygani** Konad!",
          ephemeral: true,
        });

      if (interaction.channel.parentId === Config.TICKET.ARCHIVE_CATEGORY)
        return interaction.followUp({
          content: `Shoma Nemitavanid Ticket Ra **Baygani** Konid.`,
          ephemeral: true,
        });

      let Parent = interaction.guild.channels.cache.get(
        Config.TICKET.ARCHIVE_CATEGORY
      );

      // interaction.channel.permissionOverwrites.delete(
      //   interaction.channel.name.replace("ticket-", "")
      // );

      interaction.channel
        .setParent(Parent.id, { lockPermissions: false })
        .then(async (x) => {          
          x.setName(interaction.channel.name.replace("-", "-archive-"));

          interaction.message.edit({
            embeds: [
              Utils.embed(
                interaction.message.embeds.map((x) => x.description).join(""),
                interaction.guild,
                Bot,
                ""
              ),
            ],
            components: [],
          });

          interaction.followUp({
            content: `Ticket Ba **Movafaghiyat Baygani** Shod.`,
            ephemeral: true,
          });
        });
    }

    if (interaction.customId === "deleteTicket") {
      await interaction.deferReply({ ephemeral: true });

      let User1 = interaction.channel.name.replace("support-", "");
      let User2 = User1.replace("report-", "");
      let User = User2.replace("competence-", "");
      if ([User].includes(interaction.user.id)) {
  
   
        return interaction.followUp({
          content: `Shoma Nemitavanid Ticket Khod Ra Close Konid!`,
          ephemeral: true,
        });
          
      } else {

        if (
          interaction.message.components[0].components[0].data.disabled === true
        )
        if (
          !Config.TICKET.STAFF_ROLES.some((x) =>
            interaction.member.roles.cache.has(x)
          ) &&
          ![interaction.guild.ownerId].includes(interaction.user.id)
        )
          return;
      }

      interaction.followUp({
        content: `Darkhast Shoma Ta 3 Saniye Digar Anjam Mishavad Va Channel Be Sorat Khodkar Delete Khahad Shod.`,
        ephemeral: true,
      });

      setTimeout(() => {
        interaction.channel.delete().catch(() => {
          return undefined;
        });
      }, 1000 * 3);
    }
  });
};
