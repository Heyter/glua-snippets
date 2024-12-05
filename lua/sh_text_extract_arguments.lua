local strsub, strbyte = string.sub, string.byte
local arguments = setmetatable({}, { __mode = "v" })

-- GoodOldBrick
-- " - 0x22 -- doublequotes
--   - 0x20 -- whitespace
function string.ExtractArgs(text, max)
	local ptr, len, arglen = 1, #text, 0

	while ptr <= len do
		while ptr <= len and strbyte(text, ptr) == 0x20 do
			ptr = ptr + 1
		end

		if ptr > len then break end
		if strbyte(text, ptr) == 0x22 then
			local sub = ptr + 1
			ptr = sub
			while ptr <= len and strbyte(text, ptr) ~= 0x22 do
				ptr = ptr + 1
			end
			arglen = arglen + 1
			arguments[arglen] = strsub(text, sub, ptr - 1)
			ptr = ptr + 1
		else
			local sub = ptr
			while ptr <= len and strbyte(text, ptr) ~= 0x20 and strbyte(text, ptr) ~= 0x22 do
				ptr = ptr + 1
			end
			arglen = arglen + 1
			arguments[arglen] = strsub(text, sub, ptr - 1)
		end

		if max and arglen >= max then
			return arguments, arglen
		end
	end

	return arguments, arglen
end

-- local a, b = string.ExtractArgs('/setname "John Smith"', 1)
-- local a, b = string.ExtractArgs('/test "Привет мир" 100')
-- local a, b = string.ExtractArgs('/test"Привет мир"100') -- also work
