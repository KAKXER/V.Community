import discord
from discord.ext import commands

intents = discord.Intents.all()
discord.member = false

client = commands.Bot(command_prefix = '>', intents = intents)

client.remove_command("help")

@client.event
async def on_ready():
    print('Annonuce Bot Runing')

@client.command()
@commands.has_any_role(938893789852991561, 939907106692276304, 939812814120439809, 1037865236683825172, 939906925439619123, 939906718761123911, 939906501374537883)
async def announce(ctx, *, message):
    await ctx.message.delete()
    my_embed = discord.Embed(
        title = '',
        description = str(message),
        colour = 0x004707
    )
    my_embed.set_author(name="V. Community", icon_url="https://media.discordapp.net/attachments/991462378917085244/1043176759991996546/IR.V_11.png")
    my_embed.set_footer(icon_url = ctx.author.avatar.url, text = 'Sent by ' + ctx.author.name + '#' + ctx.author.discriminator)
    await ctx.send('@everyone', embed = my_embed)

@client.command()
@commands.has_any_role(938893789852991561, 939907106692276304, 939812814120439809, 1037865236683825172, 939906925439619123, 939906718761123911, 939906501374537883)
async def announce2(ctx, *, message):
    await ctx.message.delete()
    my_embed = discord.Embed(
        title = '',
        description = str(message),
        colour = 0x004707
    )
    my_embed.set_author(name="V. Community", icon_url="https://media.discordapp.net/attachments/991462378917085244/1043176759991996546/IR.V_11.png")
    my_embed.set_footer(icon_url = ctx.author.avatar.url, text = 'Sent by ' + ctx.author.name + '#' + ctx.author.discriminator)
    my_embed.set_image(url = 'https://media.discordapp.net/attachments/991462378917085244/1043178321183260712/rulesd_banner.png')
    await ctx.send('@everyone', embed = my_embed)

@client.command()
@commands.has_any_role(938893789852991561, 939907106692276304, 939812814120439809, 1037865236683825172, 939906925439619123, 939906718761123911, 939906501374537883)
async def announce3(ctx, *, message):
    await ctx.message.delete()
    my_embed = discord.Embed(
        title = '',
        description = str(message),
        colour = 0x004707
    )
    my_embed.set_author(name="V. Community", icon_url="https://media.discordapp.net/attachments/991462378917085244/1043176759991996546/IR.V_11.png")
    my_embed.set_footer(icon_url = ctx.author.avatar.url, text = 'Sent by ' + ctx.author.name + '#' + ctx.author.discriminator)
    my_embed.set_thumbnail(url="https://media.discordapp.net/attachments/991462378917085244/1043176759991996546/IR.V_11.png")
    await ctx.send('@everyone', embed = my_embed)

@client.command()
@commands.has_any_role(938893789852991561, 939907106692276304, 939812814120439809, 1037865236683825172, 939906925439619123, 939906718761123911, 939906501374537883)
async def announce4(ctx, *, message):
    await ctx.message.delete()
    my_embed = discord.Embed(
        title = '',
        description = str(message),
        colour = 0x004707
    )
    my_embed.set_author(name="V. Community", icon_url="https://media.discordapp.net/attachments/991462378917085244/1043176759991996546/IR.V_11.png")
    my_embed.set_footer(icon_url = ctx.author.avatar.url, text = 'Sent by ' + ctx.author.name + '#' + ctx.author.discriminator)
    my_embed.set_thumbnail(url="https://media.discordapp.net/attachments/991462378917085244/1043176759991996546/IR.V_11.png")
    my_embed.set_image(url = 'https://media.discordapp.net/attachments/991462378917085244/1043178321183260712/rulesd_banner.png')
    await ctx.send('@everyone', embed = my_embed)

@client.event
async def on_command_error(ctx, error):
    if isinstance(error, commands.CommandNotFound):
        await ctx.send("Your Command is Wrong!")
    elif isinstance(error, commands.MissingPermissions):
        await ctx.send("You Can't Use That Command!")

client.run('MTAzODU2MTg2MzM2MjkzNjkzMg.GWS_Kk.2o6pIeuaghnTFq_zraX9wuCGNhFwVkVvFPHlGk')
