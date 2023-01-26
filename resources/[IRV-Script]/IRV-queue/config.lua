Config = {
  Whitelisted       = true,     -- Stop all players who are not whitelisted in discord from joining?
  MaxPlayers        = 60,       -- Max number of players allowed to connect.
  ReserveSlots      = 4,        -- Reserved slots for priority and staff members.

  ShowStaffQueue    = true, -- Display count of staff members in queue ahead of you?
  ShowPriorityQueue = true, -- Display count of priority members in queue ahead of you?

  Tokens = {
    Discord         = '922903544430997555', -- Discord id. (On discord, enable developer mode in settings, right click your discord, copy id)
    Bot             = 'Bot Tokens BAT', -- Bot token.  (From discord developer portal) (NOTE: Must be "Bot XYZ.123", inclusive of "Bot ")

    competence      = '',
    CompetenceGPlus = '', -- Whitelisted role id.      (On discord, enable developer mode in settings, right click this role in guild/server settings, copy id)
    CompetencePlus  = '', -- Priority/donator role id. (On discord, enable developer mode in settings, right click this role in guild/server settings, copy id)
    CompetencePerma = '', -- Staff role id.            (On discord, enable developer mode in settings, right click this role in guild/server settings, copy id)
  },
}