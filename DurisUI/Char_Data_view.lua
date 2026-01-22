CharacterUI = CharacterUI or {}

CharacterUI.panel = TabPanel:new({
  name = "CharacterUI",

  container = {
    name      = "characterUIContainer",
    titleText = "Character",
    x         = "0%",
    y         = "0%",
    width     = "15%",
    height    = "70%",
  },

  attach    = "left",
  tabHeight = "20px", --8%
  styles    = UIStyles,
  default   = "stats",

  tabs = {
    stats = {
      label = "Stats",
      create = function(parent)
        local mini = Geyser.MiniConsole:new({
          name     = "statsMini",
          autoWrap = true,
          x        = "0%", y = "0%",
          width    = "100%", height = "100%",
        }, parent)

        mini:setColor("black")
        mini:echo("Stats here\n")
        return mini
      end
    },

    affects = {
      label = "Affects",
      create = function(parent)
        local mini = Geyser.MiniConsole:new({
          name     = "affectsMini",
          autoWrap = true,
          x        = "0%", y = "0%",
          width    = "100%", height = "100%",
        }, parent)

        mini:setColor("black")
        mini:echo("Affects here\n")
        return mini
      end
    },

    skills = {
      label = "Skills",
      create = function(parent)
        local mini = Geyser.MiniConsole:new({
          name     = "skillsMini",
          autoWrap = true,
          x        = "0%", y = "0%",
          width    = "100%", height = "100%",
        }, parent)

        mini:setColor("black")
        mini:echo("Skills here\n")
        return mini
      end
    },
  }
})

DurisUI.panels.CharacterUI = CharacterUI.panel