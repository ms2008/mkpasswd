-- Issue: A pure lua password generator implementation
-- Copyright (C)2015 poslua <poslua@gmail.com>

local math = require('math')
local os = require('os')
local string = require('string')
local milsec = ngx.now

-- const defination
local count = 0

local _M = {
    _VERSION = '0.1'
}

-- Reformatted from http://pastebin.com/DruT1MC6
-- the characters that will be used in the generator
local char = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o",
              "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3",
              "4", "5", "6", "7", "8", "9", "!", "@", "#", "$", "%", "^", "&", "*", "(",
              ")", "-", "_", "=", "+", "<", ">", "?",}

local function counter()
    count = count + 1
    return string.format("tally: %s", count)
end

-- args: smallest and largest possible password lengths, inclusive
local function generate(s, l)
    local pass = {}
    -- math.randomseed(os.time())
    math.randomseed(milsec())
    math.random(); math.random(); math.random()
    -- random password length
    size = math.random(s, l)

    for z = 1,size do
        -- randomly choose case (caps or lower)
        case = math.random(1,2)
        -- randomly choose a character from the "char" array
        a = math.random(1,#char)

        if case == 1 then
            -- uppercase if case = 1
            x=string.upper(char[a])
        elseif case == 2 then
            -- lowercase if case = 2
            x=string.lower(char[a])
        end

        -- add new index into array
        table.insert(pass, x)
    end
    -- concatenate all indicies of the "pass" array, then print out concatenation
    return(table.concat(pass))
end

function _M.mkpasswd(s, l)
    if l == nil then
        return generate(s, s)
    end
    return generate(s, l)
end

_M.counter = counter

return _M
