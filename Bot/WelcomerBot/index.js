const { token, Welcome_Channel_ID, Welcome_Embed_Color } = require('./config.json')
const { Client, GatewayIntentBits, Partials, EmbedBuilder } = require('discord.js');

const BOT = new Client({
    intents: [GatewayIntentBits.Guilds, GatewayIntentBits.GuildMembers, GatewayIntentBits.GuildMessages, GatewayIntentBits.MessageContent, GatewayIntentBits.DirectMessages],
    allowedMentions: { parse: ['users', 'roles'], repliedUser: true },
    partials: [Partials.Message, Partials.Channel, , Partials.Reaction, Partials.GuildMember]
})

BOT.on("ready", () => {
    console.log("Welcome Bot Running")
    // console.log(`${BOT.user.tag} Running!`)
})

BOT.on('guildMemberAdd', (guildmember) => {
    const Embed = new EmbedBuilder()
    Embed.setColor(Welcome_Embed_Color)
    Embed.setAuthor({ name: 'IR.V Community', iconURL: 'https://cdn.discordapp.com/attachments/689238583982293041/1039181003417194506/IR.V_10.png'})
    Embed.setTitle('Welcome')
    Embed.setDescription(`> 👋 Hi There ${guildmember} \n> ✨Welcome to IR.V Community.\n> 🎈Bar Roye Dokme \`📄Rules\` Click Konid va ghavanin discord ra moshahede konid.`)
    Embed.setThumbnail(guildmember.user.displayAvatarURL({ size: 1024 }))


    Embed.addFields(
		{ name: 'Tarikh Create Account',  value: new Date(guildmember.user.createdTimestamp).toLocaleDateString(), inline: true },
		{ name: 'Tarikh Join Server', value: `${new Date(Date.now()).toLocaleString()}`, inline: true },
        // { name: 'Vorod Bot', value: `${guildmember.user.bot}`, inline: true },
        // { name: 'Tag User', value: `${guildmember.user.tag}`, inline: true },
	)

    Embed.setFooter({
        text: `IR.V Development™`,
        iconURL: 'https://cdn.discordapp.com/attachments/689238583982293041/1039181003417194506/IR.V_10.png',
      })

      Embed.setImage('https://cdn.discordapp.com/attachments/996093699060678677/1039997837255131146/IR.V_Welcome.png')

    // Embed.setTimestamp()

    const Channel = guildmember.guild.channels.cache.get(Welcome_Channel_ID)
    Channel.send({ embeds: [Embed] })
})

BOT.login(token)