math.randomseed(os.time())

local socket = require "socket"
local gettime = socket.gettime

local function time(name, fn)
    local start = gettime()
    fn()
    local stop = gettime()
    print(string.format("%s %fs", name, stop - start))
end


local ihex = require "ihex"


local bit
if jit then
    bit = require "bit"
else
    bit = require "bit32"
end

local band = bit.band


time("round trip", function()
    local X = 10
    local Y = 0x300

    for _ = 1, X do
        local in_data = {}
        for j = 1, Y do
            in_data[j] = band(j, 0xFF)
        end

        local hex = ihex.encode(in_data)
        local bin = ihex.decode(hex)

        assert(bin.count == #in_data)
        for j = 1, Y do
            assert(bin[j - 1] == in_data[j])
        end
    end

    print("yay!")
end)
