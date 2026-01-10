-- =========================
-- Minimal GMCP Mapper
-- =========================

map = map or {}
map.room_info = map.room_info or {}

-- Terrain → environment ID (optional)
local TERRAIN = {
  Inside = 1,
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

-- -------------------------
-- Room creation
-- -------------------------
local function makeRoom(info)
  if getRoomName(info.vnum) then return end

  addRoom(info.vnum)
  setRoomName(info.vnum, info.name)
  setRoomArea(info.vnum, info.zone)
  setRoomCoordinates(info.vnum, info.coords[1], info.coords[2], info.coords[3])

  if TERRAIN[info.terrain] then
    setRoomEnv(info.vnum, TERRAIN[info.terrain])
  end
end

-- -------------------------
-- Exit linking
-- -------------------------
local function linkExits(info)
  for dir, dest in pairs(info.exits) do
    if getRoomName(dest) then
      setExit(info.vnum, dest, dir)
    else
      setExitStub(info.vnum, dir, true)
    end
  end
end

-- -------------------------
-- GMCP handler
-- -------------------------
function map.onGMCP()
  local g = gmcp.Room.Info
  if not g then return end

  local info = {
    vnum    = tonumber(g.num),
    name    = g.name or "Unknown",
    zone    = tonumber(g.zone) or 0,
    terrain = g.environment,
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

-- -------------------------
-- Event registration
-- -------------------------
registerAnonymousEventHandler("gmcp.Room.Info", "map.onGMCP")