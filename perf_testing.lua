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


--[[

TODO: write `using`
    - using { math, "min", "max" }  =>  local min, max = math.min, math.max
    - What about other forms of using? Hmm... XD I think we might be able to do stuff here too!
        - This is blegh; we can't put it in the table ctor because we need to have a reference
          to said table. So, yeah, eh.
            local pos = { x = 0, y = 0, z = 0 }
            local ent = {}
            ent:using(pos)
        -
            function fn(ent)
                using { ent }
                print(pos.x, pos.y, pos.z)

TODO: write `table.new`
    - basically we need to
        1. detect what version of lua we're on; 5.1, 5.2, 5.3, 5.4, luajit, etc.
            - we may not necessarily have to get that specific? i'll have to look at the
              bytecode format for all the versions; obviously luajit is a totally different
              ball game than regular lua
        2. detect endianness, number of bytes per size_Number, size_Int, etc. whatever the hell
            - just do a string.dump and boom, ez pz lemon squeeze me
                - This is literally what MetaLua does lol; probably "isn't uncommon"
        3. combine the data we detect at runtime with the correct pre-defined (binary) bytecode
           template in order to generate the actual `table.new` function
    - reference LuaDbg! and other related projects on the interwebs
        - but more importantly, Lua No Frills :P and even the actual lua source code (kinda _the_
          best source for info here.)

TODO: implement the "sparse bitset" as a rock
    - maybe think of a better name for it; bitset isn't necessarily the best
    - oh and of course, allow for the "sparse bitmap" as well, as it were

]]