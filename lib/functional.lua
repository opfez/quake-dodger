function map(f, lst)
	local res = {}
	for i, v in ipairs(lst) do
		res[i] = f(v)
	end
	return res
end

function filter(pred, lst)
	local res = {}
	for i, v in ipairs(lst) do
		if pred(v) then
			table.insert(res, v)
		end
	end
	return res
end

function foldl(f, init, lst)
	local acc = init
	for i, v in ipairs(lst) do
		acc = f(acc, v)
	end
	return acc
end

function foldr(f, init, lst)
	local acc = init
	for i = #lst, 1, -1 do
		acc = f(lst[i], acc)
	end
	return acc
end

function compose(f, g)
	return function(x) return f(g(x)) end
end

function id(x) return x end
