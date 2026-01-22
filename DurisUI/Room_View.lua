InRoomUI = InRoomUI or {}

InRoomUI.panel = TabPanel:new({
  name = "InRoomUI",

  container = {
    name      = "inRoomContainer",
    titleText = "In Room",
    x         = "0%",
    y         = "70%",
    width     = "15%",
    height    = "30%",
  },

  attach    = "left",
  tabHeight = "20px", --8%
  styles    = UIStyles,
  default   = "mobs",

  tabs = {
    mobs = {
      label = "Mobs",
      create = function(parent)
        local mini = Geyser.MiniConsole:new({
          name     = "mobsMini",
          autoWrap = true,
          x        = "0%", y = "0%",
          width    = "100%", height = "100%",
        }, parent)

        mini:setColor("black")
        mini:echo("Mobs here\nInRoomUI.panel.tabs.mobs.view")
        return mini
      end
    },

    items = {
      label = "Items",
      create = function(parent)
        local mini = Geyser.MiniConsole:new({
          name     = "itemsMini",
          autoWrap = true,
          x        = "0%", y = "0%",
          width    = "100%", height = "100%",
        }, parent)

        mini:setColor("black")
        mini:echo("Items here\nInRoomUI.panel.tabs.items.view")
        return mini
      end
    },

    players = {
      label = "Players",
      create = function(parent)
        local mini = Geyser.MiniConsole:new({
          name     = "playersMini",
          autoWrap = true,
          x        = "0%", y = "0%",
          width    = "100%", height = "100%",
        }, parent)

        mini:setColor("black")
        mini:echo("Players here\nInRoomUI.panel.tabs.players.view")
        return mini
      end
    },
  }
})

DurisUI.panels.InRoomUI = InRoomUI.panel