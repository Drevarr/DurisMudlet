DurisGUI = DurisGUI or {}

DurisGUI.menu = DurisGUI.menu or {
  tabs = {"Tab1","Tab2","Tab3","Tab4"},
  color1 = "rgb(0,0,70)",
  color2 = "rgb(0,0,50)",
  width = "20%",
  height = "40%",
}
DurisGUI.menu.current = DurisGUI.menu.current or DurisGUI.menu.tabs[1]

DurisGUI.menu.container = Geyser.Container:new({
  name = "DurisGUI.menu.back",
  x = "50%", y = "25%",
  width = DurisGUI.menu.width,
  height = DurisGUI.menu.height,
},main)


DurisGUI.menu.header = Geyser.HBox:new({
  name = "DurisGUI.menu.header",
  x = 0, y = 0,
  width = "100%",
  height = "10%",
},DurisGUI.menu.container)

DurisGUI.menu.footer = Geyser.Label:new({
  name = "DurisGUI.menu.footer",
  x = 0, y = "10%",
  width = "100%",
  height = "90%",
},DurisGUI.menu.container)

DurisGUI.menu.footer:setStyleSheet([[
  background-color: ]]..DurisGUI.menu.color1..[[;
  border-bottom-left-radius: 10px;
  border-bottom-right-radius: 10px;
]])

DurisGUI.menu.center = Geyser.Label:new({
  name = "DurisGUI.menu.center",
  x = 0, y = 0,
  width = "100%",
  height = "100%",
},DurisGUI.menu.footer)
DurisGUI.menu.center:setStyleSheet([[
  background-color: ]]..DurisGUI.menu.color2..[[;
  border-radius: 10px;
  margin: 5px;
]])


for k,v in pairs(DurisGUI.menu.tabs) do
  DurisGUI.menu[v.."tab"] = Geyser.Label:new({
    name = "DurisGUI.menu."..v.."tab",
  },DurisGUI.menu.header)
  
  DurisGUI.menu[v.."tab"]:setStyleSheet([[
    background-color: ]]..DurisGUI.menu.color1..[[;
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;
    margin-right: 1px;
    margin-left: 1px;
  ]])
  
  DurisGUI.menu[v.."tab"]:echo("<center>"..v)
  
  DurisGUI.menu[v.."tab"]:setClickCallback("DurisGUI.menu.click",v)
  
  DurisGUI.menu[v] = Geyser.Label:new({
    name = "DurisGUI.menu."..v,
    x = 0, y = 0,
    width = "100%",
    height = "100%",
  },DurisGUI.menu.footer)

  DurisGUI.menu[v]:setStyleSheet([[
    background-color: ]]..DurisGUI.menu.color1..[[;
    border-bottom-left-radius: 10px;
    border-bottom-right-radius: 10px;
  ]])
  
  DurisGUI.menu[v.."center"] = Geyser.Label:new({
    name = "DurisGUI.menu."..v.."center",
    x = 0, y = 0,
    width = "100%",
    height = "100%",
  },DurisGUI.menu[v])
  
  DurisGUI.menu[v.."center"]:setStyleSheet([[
    background-color: ]]..DurisGUI.menu.color2..[[;
    border-radius: 10px;
    margin: 5px;
  ]])
  
  DurisGUI.menu[v]:hide()
end

function DurisGUI.menu.click(tab)
  DurisGUI.menu[DurisGUI.menu.current]:hide()
  DurisGUI.menu.current = tab
  DurisGUI.menu[DurisGUI.menu.current]:show()
end

DurisGUI.menu.Tab1center:echo("1: Testing echo to Tab1center")
DurisGUI.menu.Tab2center:echo("2: Testing echo to Tab2center")
DurisGUI.menu.Tab3center:echo("3: Testing echo to Tab3center")
DurisGUI.menu.Tab4center:echo("4: Testing echo to Tab4center")
