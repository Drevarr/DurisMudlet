MapUI = MapUI or {}

MapUI.panel = TabPanel:new({
  name = "MapUI",

  container = {
    name      = "mapUIContainer",
    titleText = "Map and Comms",
    x         = "-25%",
    y         = "0%",
    width     = "25%",
    height    = "50%",
  },

  attach    = "right",
  tabHeight = "5%",
  styles    = UIStyles,
  default   = "map",

  tabs = {
    map = {
      label = "Map",
      create = function(parent)
        local c = Geyser.Container:new({
          name   = "mapView",
          x      = "0%", y = "0%",
          width  = "100%", height = "100%",
        }, parent)

        MapUI.mapBox = Geyser.Container:new({
          name   = "MapBox",
          x      = "0%", y = "0%",
          width  = "100%", height = "100%",
        }, c)

        return c
      end
    },

    comms = {
      label = "Comms",
      create = function(parent)
        local m = Geyser.MiniConsole:new({
          name     = "commsMini",
          autoWrap = true,
          x        = "0%", y = "0%",
          width    = "100%", height = "100%",
        }, parent)

        m:setColor("black")
        return m
      end
    },

    misc = {
      label = "Misc",
      create = function(parent)
        local m = Geyser.MiniConsole:new({
          name     = "miscMini",
          autoWrap = true,
          x        = "0%", y = "0%",
          width    = "100%", height = "100%",
        }, parent)

        m:setColor("black")
        return m
      end
    },
  }
})

DurisUI.panels.MapUI = MapUI.panel