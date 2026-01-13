-- Duris GMCP Mapper
mudlet = mudlet or {}; mudlet.mapper_script = true
map = map or {}
map.room_info = map.room_info or {}

-- Terrain → environment ID (optional)
local TERRAIN = {
  ["inside"]=263,
  ["city"]=263,
  ["field"]=258,
  ["forest"]=266,
  ["hills"]=267,
  ["mountains"]=259,
  ["water swim"]=262,
  ["water noswim"]=260,
  ["no ground"]=271,
  ["underwater"]=268,
  ["underwater ground"]=268,
  ["plane of fire"]=265,
  ["ocean"]=268,
  ["ud wild"]=261,
  ["ud city"]=263,
  ["ud inside"]=261,
  ["ud water swim"]=262,
  ["ud water noswim"]=260,
  ["ud no ground"]=263,
  ["plane of air"]=263,
  ["plane of water"]=268,
  ["plane of earth"]=263,
  ["plane of ethereal"]=263,
  ["plane of astral"]=268,
  ["desert"]=259,
  ["tundra"]=271,
  ["swamp"]=261,
  ["ud mountains"]=264,
  ["ud slime"]=257,
  ["ud low ceilings"]=269,
  ["ud liquid mithril"]=261,
  ["ud mushroom forest"]=269,
  ["outer castle wall"]=263,
  ["castle gate"]=263,
  ["castle"]=257,
  ["negative plane"]=260,
  ["plane of avernus"]=260,
  ["patrolled road"]=260,
  ["snowy forest"]=272,
  ["lava"]=257
}


local ANSI_PALETTE = {
  -- Standard ANSI
  ["L"] = { r = 0,   g = 0,   b = 0   }, -- Black
  ["R"] = { r = 170, g = 60,  b = 60  }, -- Red
  ["G"] = { r = 60,  g = 170, b = 110 }, -- Green
  ["Y"] = { r = 180, g = 170, b = 70  }, -- Yellow
  ["B"] = { r = 80,  g = 130, b = 190 }, -- Blue
  ["M"] = { r = 160, g = 90,  b = 170 }, -- Magenta
  ["C"] = { r = 70,  g = 160, b = 180 }, -- Cyan
  ["W"] = { r = 200, g = 200, b = 200 }, -- Light Gray

  -- Bright ANSI
  ["l"] = { r = 110, g = 110, b = 110 }, -- Dark Gray
  ["r"] = { r = 235, g = 90,  b = 90  }, -- Bright Red
  ["g"] = { r = 90,  g = 215, b = 140 }, -- Bright Green
  ["y"] = { r = 235, g = 225, b = 120 }, -- Bright Yellow
  ["b"] = { r = 110, g = 170, b = 235 }, -- Bright Blue
  ["m"] = { r = 215, g = 140, b = 235 }, -- Bright Magenta
  ["c"] = { r = 110, g = 205, b = 225 }, -- Bright Cyan
  ["w"] = { r = 245, g = 245, b = 245 }, -- White
}

-- Direction normalization
local EXITMAP = {
  n = "north", ne = "northeast", nw = "northwest",
  s = "south", se = "southeast", sw = "southwest",
  e = "east",  w = "west",
  u = "up",    d = "down",
}

-- Movement vectors for coordinate shifting
local MOVE = {
  north = { 0,  1, 0}, south = { 0, -1, 0},
  east  = { 1,  0, 0}, west  = {-1,  0, 0},
  northeast = { 1,  1, 0}, northwest = {-1,  1, 0},
  southeast = { 1, -1, 0}, southwest = {-1, -1, 0},
  up = {0, 0, 1}, down = {0, 0,-1},
}

-- Zone Creation
local function checkZone(info)
  local newId, err = addAreaName(info.name)
  if not newId then
    echo("Zone Exists in AreaTable.")
  else
    cecho("<green>Created new area with the ID of "..newId..":"..info.name..".\n")
  end
  --setAreaName(info.zone, info.area)

  return newId
end

-- Set the active area
-- Returns the areaname on success, "" otherwise
local function setArea(areaname)
	local t = getAreaTable()
	--display(t)
	if table.contains(t, areaname) then
		log:info("Setting active area to '" .. areaname .. "'")
		return areaname
	else
		log:error("No such area as '"..areaname.."'. Please 'createarea' first")
	end

	return ""
end

-- Return an id for the given area name, nil if area doesn't exist
local function getAreaId(areaname)
	local t = getAreaTable()
	local id = t[areaname]

	if id then
		--echo("[[getAreaId: Found area id of "..id.." for area name '"..areaname.."']]\n")
		return id
	else
		--echo("[[getAreaId: No id found for that area!]]\n")
	end

	return nil
end

local function createZone(new_zone_name)
  local new_zone_id = addAreaName(new_zone_name)

  if new_zone_id then
    echo("New zone "..new_zone_name.." created with id: "..new_zone_id)
    return new_zone_id
  else
    echo("Zone already exists, not creating new zone")
  end

end


-- Room creation
local function makeRoom(info)
  if getRoomName(info.vnum) then return end

  if getAreaId(info.name) then
    return
  else
    createZone(info.area)
  end

  addRoom(info.vnum)
  setRoomName(info.vnum, info.name)
  setRoomArea(info.vnum, info.area)
  setRoomCoordinates(info.vnum, info.coords[1], info.coords[2], info.coords[3])

  if TERRAIN[info.environment] then
    setRoomEnv(info.vnum, TERRAIN[info.environment])
  end
end

-- Exit linking
local function linkExits(info)
  for dir, dest in pairs(info.exits) do
    if getRoomName(dest) then
      setExit(info.vnum, dest, dir)
    else
      setExitStub(info.vnum, dir, true)
    end
  end
end

-- GMCP handler
function map.onGMCP()
  local g = gmcp.Room.Info
  if not g then return end

  local info = {
    vnum    = tonumber(g.num),
    name    = g.name or "Unknown",
    area    = g.area or "Unknown",
    zone    = tonumber(g.zone) or 0,
    environment = g.environment,
    terrain = g.terrain,
    coords  = {
      tonumber(g.coords.x) or 0,
      tonumber(g.coords.y) or 0,
      tonumber(g.coords.z) or 0,
    },
    exits   = {},
  }

  for dir, vnum in pairs(g.exits or {}) do
    info.exits[EXITMAP[dir] or dir] = tonumber(vnum)
  end

  map.room_info = info

  makeRoom(info)
  linkExits(info)
  centerview(info.vnum)
end

-- Event registration
registerAnonymousEventHandler("gmcp.Room.Info", "map.onGMCP")