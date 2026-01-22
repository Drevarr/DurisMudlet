GroupUI = GroupUI or {}
GroupUI.widgets = GroupUI.widgets or {}

GroupUI.panel = TabPanel:new({
  name = "GroupUI",

  container = {
    name      = "groupUIContainer",
    titleText = "Group Data",
    x         = "-25%",
    y         = "50%",
    width     = "25%",
    height    = "50%",
  },

  attach    = "right",
  tabHeight = "5%",
  styles    = UIStyles,
  default   = "map",

  tabs = {
    groupGrid = {
        label = "GroupGrid",
        create = function(parent)
        GroupUI.widgets.groupGrid = Geyser.Label:new({
            name     = "GroupGrid",
            autoWrap = true,
            x        = "0%", y = "0%",
            width    = "100%", height = "100%",
        }, parent)

        GroupUI.widgets.groupGrid:setColor("black")
        return GroupUI.widgets.groupGrid
        end
    },


    comms = {
      label = "GroupText",
      create = function(parent)
      GroupUI.widgets.groupText = Geyser.MiniConsole:new({
          name     = "GroupTextMini",
          autoWrap = true,
          x        = "0%", y = "0%",
          width    = "100%", height = "100%",
        }, parent)

        GroupUI.widgets.groupText:setColor("black")
        return GroupUI.widgets.groupText
      end
    },

    misc = {
      label = "DualMode",
      create = function(parent)
        GroupUI.widgets.dualMode = Geyser.Container:new({
          name   = "DualMode",
          x      = "0%", y = "0%",
          width  = "100%", height = "100%",
        }, parent)

        GroupUI.widgets.dualGrid = Geyser.Label:new({
          name     = "DualGrid",
          autoWrap = true,
          x        = "0%", y = "0%",
          width    = "100%", height = "50%",
        }, GroupUI.widgets.dualMode)   
        GroupUI.widgets.dualGrid:setColor("black")

        GroupUI.widgets.dualMini = Geyser.MiniConsole:new({
          name   = "DualMini",
          x      = "0%", y = "50%",
          width  = "100%", height = "50%",
        }, GroupUI.widgets.dualMode)
        GroupUI.widgets.dualMini:setColor("green")

        return GroupUI.widgets.dualMode
      end
    },
  }
})