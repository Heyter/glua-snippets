-- util.TextPlural(111, "рубль", "рубля", "рублей")
-- util.TextPlural(100, "патрон", "патрона", "патронов")

function util.TextPlural(amount, a, b, c)
	local num100 = amount % 100

	if num100 > 4 and num100 < 21 then
		return c
	end

	local num10 = num100 % 10

	if num10 == 1 then
		return a
	elseif num10 > 1 and num10 < 5 then
		return b
	end

	return c
end
