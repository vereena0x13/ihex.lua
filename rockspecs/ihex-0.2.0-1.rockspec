rockspec_format = "3.0"

package = "ihex"
version = "0.2.0-1"

source = {
    url = "git://github.com/vereena0x13/ihex.lua.git",
    tag = "0.2.0"
}

description = {
    summary = "Intex Hex encoder/decoder",
    detailed = [[
        An opinionated, mostly-feature-complete,
        probably-not-that-buggy Intel Hex encoding 
        and decoding utility library for Lua.
    ]],
    homepage = "https://github.com/vereena0x13/ihex.lua",
    issues_url = "https://github.com/vereena0x13/ihex.lua/issues",
    maintainer = "vereena0x13",
    license = "MIT",
    labels = {
        "serialization"
    }
}

dependencies = {
    "lua >= 5.1",
    "bit32"
}

build = {
    type = "builtin",
    modules = {
        ["ihex"] = "ihex/ihex.lua"
    },
    copy_directories = {
        "docs",
        "spec"
    }
}

test_dependencies = {
    "busted",
    "busted-htest"
}

test = {
    type = "busted"
}