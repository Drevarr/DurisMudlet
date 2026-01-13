-- =========================================
-- Duris GMCP Hybrid Elastic Mapper
-- GMCP coords are primary, elastic on overlap
-- =========================================

map = map or {}
map.room_info = map.room_info or {}

-------------------------------------------------
-- CONFIG
-------------------------------------------------
local SCALE = 2        -- spacing to avoid diagonal touch
local STRETCH_STEP = 2

-------------------------------------------------
-- TERRAIN → ENV IDS
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

-------------------------------------------------
-- MOVEMENT VECTORS (USED FOR STRETCH DIRECTION)
-------------------------------------------------
local MOVE = {
  north={0,STRETCH_STEP,0}, south={0,-STRETCH_STEP,0},
  east={STRETCH_STEP,0,0}, west={-STRETCH_STEP,0,0},

  northeast={STRETCH_STEP,STRETCH_STEP,0},
  northwest={-STRETCH_STEP,STRETCH_STEP,0},
  southeast={STRETCH_STEP,-STRETCH_STEP,0},
  southwest={-STRETCH_STEP,-STRETCH_STEP,0},
}

-------------------------------------------------
-- ROOM LOOKUP
-------------------------------------------------
local function roomAt(x,y,z)
  local r = getRoomsByCoordinates(x,y,z)
  return r and r[1] or nil
end

-------------------------------------------------
-- VECTOR → DIRECTION (FROM GMCP DELTA)
-------------------------------------------------
local function vectorDir(dx,dy)
  if dx==0 and dy>0 then return "north" end
  if dx==0 and dy<0 then return "south" end
  if dx>0 and dy==0 then return "east" end
  if dx<0 and dy==0 then return "west" end

  if dx>0 and dy>0 then return "northeast" end
  if dx<0 and dy>0 then return "northwest" end
  if dx>0 and dy<0 then return "southeast" end
  if dx<0 and dy<0 then return "southwest" end

  return nil
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
-- CHOOSE STRETCH VECTOR
-------------------------------------------------
local function chooseStretch(prev_room, x, y)
  if prev_room then
    local px,py = getRoomCoordinates(prev_room)
    local dir = vectorDir(x-px, y-py)
    if dir and MOVE[dir] then
      return unpack(MOVE[dir])
    end
  end
  return STRETCH_STEP, 0, 0
end

-------------------------------------------------
-- PLACE ROOM USING GMCP + ELASTIC RESOLVE
-------------------------------------------------
local function placeRoomHybrid(vnum, x, y, z, prev_room)
  local dx,dy,dz = chooseStretch(prev_room, x, y)

  while true do
    local hit = roomAt(x,y,z)
    if not hit then break end
    stretchCluster(hit, dx, dy, dz)
  end

  setRoomCoordinates(vnum, x, y, z)
end

-------------------------------------------------
-- AREA HELPERS
-------------------------------------------------
local function ensureArea(name)
  if not getAreaTable()[name] then
    addAreaName(name)
  end
end

-------------------------------------------------
-- ROOM CREATION
-------------------------------------------------
local function makeRoom(info)
  if getRoomName(info.vnum) then return end

  ensureArea(info.area)

  addRoom(info.vnum)
  setRoomName(info.vnum, info.name)
  setRoomArea(info.vnum, info.area)

  local x = info.coords[1] * SCALE
  local y = info.coords[2] * SCALE
  local z = info.coords[3]

  placeRoomHybrid(info.vnum, x, y, z, map.room_info and map.room_info.vnum)

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

  local info = {
    vnum = tonumber(g.num),
    name = g.name or "Unknown",
    area = g.area or ("Zone "..tostring(g.zone)),
    environment = g.environment,
    coords = {
      tonumber(g.coords.x) or 0,
      tonumber(g.coords.y) or 0,
      tonumber(g.coords.z) or 0,
    },
    exits = {},
  }

  for dir,vnum in pairs(g.exits or {}) do
    info.exits[EXITMAP[dir] or dir] = tonumber(vnum)
  end

  local prev = map.room_info
  map.room_info = info

  makeRoom(info)
  linkExits(info)
  centerview(info.vnum)
end

-------------------------------------------------
-- EVENT REGISTRATION
-------------------------------------------------
registerAnonymousEventHandler("gmcp.Room.Info", "map.onGMCP")
