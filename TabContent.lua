menu = menu or {
  tabs = {"Tab1","Tab2","Tab3","Tab4"},
  color1 = "rgb(0,0,70)",
  color2 = "rgb(0,0,50)",
  width = "20%",
  height = "40%",
}
menu.current = menu.current or menu.tabs[1]

menu.container = Geyser.Container:new({
  name = "menu.back",
  x = "50%", y = "25%",
  width = menu.width,
  height = menu.height,
},main)


menu.header = Geyser.HBox:new({
  name = "menu.header",
  x = 0, y = 0,
  width = "100%",
  height = "10%",
},menu.container)

menu.footer = Geyser.Label:new({
  name = "menu.footer",
  x = 0, y = "10%",
  width = "100%",
  height = "90%",
},menu.container)

menu.footer:setStyleSheet([[
  background-color: ]]..menu.color1..[[;
  border-bottom-left-radius: 10px;
  border-bottom-right-radius: 10px;
]])

menu.center = Geyser.Label:new({
  name = "menu.center",
  x = 0, y = 0,
  width = "100%",
  height = "100%",
},menu.footer)
menu.center:setStyleSheet([[
  background-color: ]]..menu.color2..[[;
  border-radius: 10px;
  margin: 5px;
]])


for k,v in pairs(menu.tabs) do
  menu[v.."tab"] = Geyser.Label:new({
    name = "menu."..v.."tab",
  },menu.header)
  
  menu[v.."tab"]:setStyleSheet([[
    background-color: ]]..menu.color1..[[;
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;
    margin-right: 1px;
    margin-left: 1px;
  ]])
  
  menu[v.."tab"]:echo("<center>"..v)
  
  menu[v.."tab"]:setClickCallback("menu.click",v)
  
  menu[v] = Geyser.Label:new({
    name = "menu."..v,
    x = 0, y = 0,
    width = "100%",
    height = "100%",
  },menu.footer)

  menu[v]:setStyleSheet([[
    background-color: ]]..menu.color1..[[;
    border-bottom-left-radius: 10px;
    border-bottom-right-radius: 10px;
  ]])
  
  menu[v.."center"] = Geyser.Label:new({
    name = "menu."..v.."center",
    x = 0, y = 0,
    width = "100%",
    height = "100%",
  },menu[v])
  
  menu[v.."center"]:setStyleSheet([[
    background-color: ]]..menu.color2..[[;
    border-radius: 10px;
    margin: 5px;
  ]])
  
  menu[v]:hide()
end

function menu.click(tab)
  menu[menu.current]:hide()
  menu.current = tab
  menu[menu.current]:show()
end

menu.Tab1center:echo("Testing echo to Tab1center")
