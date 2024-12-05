local strsub, strbyte, strmatch = string.sub, string.byte, string.match
local arguments = setmetatable({}, { __mode = "v" })

-- UTF-8 support
function string.ExtractArgs(text, max)
	local arglen, curString = 0, ""
	local pos, charbytes = 1

	while pos <= #text do
		local b = strbyte(text, pos)
		if b < 0x80 then charbytes = 1
		elseif b < 0xE0 then charbytes = 2
		elseif b < 0xF0 then charbytes = 3
		elseif b < 0xF8 then charbytes = 4
		else charbytes = 1 end
		local c = strsub(text, pos, pos + charbytes - 1)

		if c == '"' then
			local match = strmatch(strsub(text, pos), '%b""')

			if match then
				curString = ""
				pos = pos + #match
				arglen = arglen + 1
				arguments[arglen] = strsub(match, 2, -2)
			else curString = curString .. c end
		elseif c == " " and curString ~= "" then
			arglen = arglen + 1
			arguments[arglen] = curString
			curString = ""
		elseif curString == "" and c == " " then
		else curString = curString..c end

		if max and arglen >= max then
			return arguments, arglen
		end

		pos = pos + charbytes
	end

	if curString ~= "" then
		arglen = arglen + 1
		arguments[arglen] = curString
	end

	return arguments, arglen
end

-- local a, b = string.ExtractArgs('/setname "John Smith"', 1)
-- local a, b = string.ExtractArgs('/test "Привет мир" 100')
