local expected_encrypted = "O0o7Njw5PDo8Nzs2O0g3NTs+Ozk7PjtLPDk="

-- Function to convert a string to hexadecimal
local function toHex(str)
    return (str:gsub('.', function(c)
        return string.format('%02X', string.byte(c))
    end))
end

-- Function to shift each character by a specific amount (Caesar Cipher)
local function caesarShift(str, shift)
    local result = {}
    for i = 1, #str do
        local byte = string.byte(str, i)
        table.insert(result, string.char(((byte + shift - 32) % 95) + 32))
    end
    return table.concat(result)
end

-- Base64 encoding function
local function toBase64(data)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    return ((data:gsub('.', function(x)
        local r, b = '', x:byte()
        for i = 8, 1, -1 do
            r = r .. (b % 2 ^ i - b % 2 ^ (i - 1) > 0 and '1' or '0')
        end
        return r
    end) .. '0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if #x < 6 then
            return ''
        end
        local c = 0
        for i = 1, 6 do
            c = c + (x:sub(i, i) == '1' and 2 ^ (6 - i) or 0)
        end
        return b:sub(c + 1, c + 1)
    end) .. ({ '', '==', '=' })[#data % 3 + 1])
end

-- Function to encrypt a given string
local function encrypt(input)
    local encrypted = input
    encrypted = toHex(encrypted)           -- 1st layer: Hexadecimal encoding
    encrypted = caesarShift(encrypted, 5)  -- 2nd layer: Caesar Cipher with a shift of 5
    encrypted = toBase64(encrypted)        -- 3rd layer: Base64 encoding
    return encrypted
end

-- Main function to check if the encrypted input matches the expected value
return function(input)
    return encrypt(input) == expected_encrypted
end
