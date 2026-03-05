# zeph-announcement
A simple FiveM ox_lib announcement system.

# Requirements
[ox_lib](https://coxdocs.com) (Even if you don't download this script, you should have ox_lib anyway.)

# Ace Permissions
This script has ace permissions. You can grant the permission by using the `announce.command` permission in the example format below in your server.cfg or cfg of your choice.

```add_ace group.admin announce.command allow```

# Adding announcement types.
My announcement script allows you to add different announcement types, this could be for departments, staff or general server things. Adding and removing types is easy through the included config.

# Changing the look of your announcement.
In terms of the colouring of the notification itself, that is done through ox_lib convars, which can be found on their [documentation](https://coxdocs.dev/ox_lib/Modules/Interface). However, my script natively allows you to change the colour of the icon, and the icon on the notification, and the title in the config.lua

In the example below, I have made a BCSO Notice, with a beige colour and a shield icon.
```
title = 'BCSO Notice',
icon = 'fa-solid fa-shield',
color = '#c9a76f',
```
This is what it translates to in-game:

![BCSO Notice Example](https://cdn.itszeph.net/u/4SUBeM.png)

# Announcement Sound
By default my script uses the txAdmin notification sound[^1], however this can be changed by naming your chosen sound's file to `audio.mp3` then dragging it into the html folder.
**Note:** You may be prompted to replace the existing sound when you drag it into the folder, click yes.

# Important Notes

> [!NOTE]
> This was made with the assistance of Microsoft Copilot, i'm not very good at coding, so I had an AI help me. I just wanted to give people a solution to something that I haven't seen done yet. If the use of AI makes this script a turnoff for you, then I'm sorry. I just want to provide people with things I've struggled to find.

### Due to the fact that this was mostly made with AI, I can't provide much support, but I will try my best. If you do need support, DM me on [Discord](https://discord.com/users/277474842616397824) and I'll get to your DM as soon as I can.

# Footnotes
[^1]: [PAKKAZEN On Zedge](https://www.zedge.net/notification-sounds/1aa07c0e-0c08-42b8-ad3d-58d1eadf4e09)
