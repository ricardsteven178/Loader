--hybird
task.wait(1)

local INGAME_PLACE_ID = 16552821455
local LOBBY_PLACE_ID  = 16116270224
local CONFIG_NAME     = "RunTestV2"

local REDIRECTS = {
    {
        from = "https://raw.githubusercontent.com/did%-i%-leave%-the%-oven%-on/Boxten%-Sex%-GUI/refs/heads/main/",
        to   = "https://raw.githubusercontent.com/ricardsteven178/Loader/main/bsgui/",
    },
    {
        from = "https://raw.githubusercontent.com/did%-i%-leave%-the%-oven%-on/Dandys%-World%-Serialized/refs/heads/main/",
        to   = "https://raw.githubusercontent.com/ricardsteven178/Loader/main/dandys/",
    },
    {
        from = "https://raw.githubusercontent.com/did%-i%-leave%-the%-oven%-on/Tisha/refs/heads/main/",
        to   = "https://raw.githubusercontent.com/ricardsteven178/Loader/main/tisha/",
    },
}

local function redirectURL(url)
    local s = tostring(url)
    for _, r in ipairs(REDIRECTS) do
        if string.find(s, r.from) then
            s = string.gsub(s, r.from, r.to)
            break
        end
    end
    return s
end

local oldHttpGet
oldHttpGet = hookfunction(game.HttpGet, function(self, url, ...)
    return oldHttpGet(self, redirectURL(url), ...)
end)

if hookmetamethod and getnamecallmethod then
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        if self == game and (method == "HttpGet" or method == "HttpGetAsync") then
            args[1] = redirectURL(args[1])
            return oldNamecall(self, unpack(args))
        end
        return oldNamecall(self, ...)
    end)
end

if game.PlaceId == INGAME_PLACE_ID then
    getgenv()["boxten sex gui auto load config"] = CONFIG_NAME

    loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/Team-Noxious/Roblox/refs/heads/main/Loader.lua"
    ))({ load = "BSGUI", fix = true })

elseif game.PlaceId == LOBBY_PLACE_ID then
    print("[AutoLoad] Lobby detected, skipping.")
end
