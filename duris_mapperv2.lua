-- ============================
-- Duris GMCP Elastic Mapper
-- ============================

map = map or {}
map.room_info = map.room_info or {}

-------------------------------------------------
-- TERRAIN → ENVIRONMENT IDS
-------------------------------------------------
local TERRAIN = {
  inside=263, city=263, field=258, forest=266, hills=267,
  mountains=259, desert=259, tundra=271, swamp=261,
  water_swim=262, water_noswim=260, ocean=268,
  underwater=268, lava=257,
}

-------------------------------------------------
-- DIRECTION NORMALIZATION
-------------------------------------------------
local EXITMAP = {
  n="north", ne="northeast", nw="northwest",
  s="south", se="southeast", sw="southwest",
  e="east", w="west",
  u="up", d="down",
}

local function oppositeDir(dir)
  local opp = {
    north="south", south="north",
    east="west", west="east",
    northeast="southwest", southwest="northeast",
    northwest="southeast", southeast="northwest",
    up="down", down="up",
  }
  return opp[dir]
end

-------------------------------------------------
-- SYMBOLIC MOVEMENT VECTORS (DIAGONALS SAFE)
-------------------------------------------------
local MOVE = {
  north={0,2,0}, south={0,-2,0},
  east={2,0,0}, west={-2,0,0},

  northeast={2,2,0}, northwest={-2,2,0},
  southeast={2,-2,0}, southwest={-2,-2,0},

  up={0,0,1}, down={0,0,-1},
}

-------------------------------------------------
-- ROOM LOOKUP
-------------------------------------------------
local function roomAt(x,y,z)
  local r = getRoomsByCoordinates(x,y,z)
  return r and r[1] or nil
end

-------------------------------------------------
-- ELASTIC STRETCH (FLOOD PUSH)
-------------------------------------------------
local function stretchCluster(start, dx, dy, dz, visited)
  visited = visited or {}
  if visited[start] then return end
  visited[start] = true

  local x,y,z = getRoomCoordinates(start)
  setRoomCoordinates(start, x+dx, y+dy, z+dz)

  for _,dest in pairs(getRoomExits(start) or {}) do
    if dest then
      stretchCluster(dest, dx, dy, dz, visited)
    end
  end
end

-------------------------------------------------
-- ELASTIC ROOM PLACEMENT
-------------------------------------------------
local function placeRoomElastic(vnum, x, y, z, entry_dir)
  local dx,dy,dz = 2,0,0
  if entry_dir and MOVE[entry_dir] then
    dx,dy,dz = unpack(MOVE[entry_dir])
  end

  while true do
    local hit = roomAt(x,y,z)
    if not hit then break end
    stretchCluster(hit, dx, dy, dz)
  end

  setRoomCoordinates(vnum, x, y, z)
end

-------------------------------------------------
-- TELEPORT Z-LAYER MANAGEMENT
-------------------------------------------------
local TELEPORT_Z_STEP = 20
local teleport_layers = {}

local function getTeleportZ(area)
  teleport_layers[area] = teleport_layers[area] or
    (#teleport_layers + 1) * TELEPORT_Z_STEP
  return teleport_layers[area]
end

local function placeTeleportRoom(vnum, area)
  local z = getTeleportZ(area)
  local x,y = 0,0
  while roomAt(x,y,z) do x = x + 4 end
  setRoomCoordinates(vnum, x, y, z)
end

-------------------------------------------------
-- AREA HELPERS
-------------------------------------------------
local function getAreaId(name)
  return getAreaTable()[name]
end

local function ensureArea(name)
  if not getAreaId(name) then
    addAreaName(name)
  end
end

-------------------------------------------------
-- ROOM CREATION
-------------------------------------------------
local last_room = nil
local last_dir  = nil

local function makeRoom(info)
  if getRoomName(info.vnum) then return end

  ensureArea(info.area)

  addRoom(info.vnum)
  setRoomName(info.vnum, info.name)
  setRoomArea(info.vnum, info.area)

  -- TELEPORT HANDLING
  if info.teleport then
    placeTeleportRoom(info.vnum, info.area)
  else
    if not last_room then
      setRoomCoordinates(info.vnum, 0, 0, 0)
    else
      local px,py,pz = getRoomCoordinates(last_room)
      local x,y,z = px,py,pz
      if last_dir and MOVE[last_dir] then
        local v = MOVE[last_dir]
        x = px + v[1]; y = py + v[2]; z = pz + v[3]
      end
      placeRoomElastic(info.vnum, x, y, z, last_dir)
    end
  end

  if TERRAIN[info.environment] then
    setRoomEnv(info.vnum, TERRAIN[info.environment])
  end
end

-------------------------------------------------
-- EXIT LINKING
-------------------------------------------------
local function linkExits(info)
  for dir,dest in pairs(info.exits) do
    setExit(info.vnum, dest, dir)
  end
end

-------------------------------------------------
-- GMCP HANDLER
-------------------------------------------------
function map.onGMCP()
  local g = gmcp.Room.Info
  if not g then return end

  local prev = map.room_info
  last_dir = nil

  local info = {
    vnum = tonumber(g.num),
    name = g.name or "Unknown",
    area = g.area or ("Zone "..tostring(g.zone)),
    environment = g.environment,
    exits = {},
  }

  for dir,vnum in pairs(g.exits or {}) do
    local norm = EXITMAP[dir] or dir
    info.exits[norm] = tonumber(vnum)
    if prev and tonumber(vnum) == prev.vnum then
      last_dir = oppositeDir(norm)
    end
  end

  -- TELEPORT DETECTION
  if prev and not last_dir then
    info.teleport = true
  end

  last_room = prev and prev.vnum or nil
  map.room_info = info

  makeRoom(info)
  linkExits(info)
  centerview(info.vnum)
end

-------------------------------------------------
-- EVENT REGISTRATION
-------------------------------------------------
registerAnonymousEventHandler("gmcp.Room.Info", "map.onGMCP")
