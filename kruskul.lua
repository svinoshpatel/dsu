-- Алгоритм Краскала на Lua з введенням з клавіатури

-- Зчитування кількості вершин і ребер
io.write("Введіть кількість вершин: ")
local n = tonumber(io.read())

io.write("Введіть кількість ребер: ")
local m = tonumber(io.read())

-- Зчитування ребер
local edges = {}
for i = 1, m do
    io.write(string.format("Ребро #%d (u v вага): ", i))
    local line = io.read()
    local u, v, w = line:match("(%d+)%s+(%d+)%s+(%d+)")
    table.insert(edges, {tonumber(w), tonumber(u), tonumber(v)})
end

-- Ініціалізація DSU
local parent = {}
for i = 1, n do
    parent[i] = i
end

local function find(v)
    if parent[v] ~= v then
        parent[v] = find(parent[v])
    end
    return parent[v]
end

local function union(u, v)
    local ru = find(u)
    local rv = find(v)
    if ru ~= rv then
        parent[ru] = rv
        return true
    end
    return false
end

-- Алгоритм Краскала
table.sort(edges, function(a, b) return a[1] < b[1] end)

local mst = {}
local total_weight = 0

for _, edge in ipairs(edges) do
    local weight, u, v = edge[1], edge[2], edge[3]
    if union(u, v) then
        table.insert(mst, edge)
        total_weight = total_weight + weight
    end
end

-- Виведення результату
print("\nМінімальне остовне дерево:")
for _, edge in ipairs(mst) do
    print(string.format("(%d -- %d) вага = %d", edge[2], edge[3], edge[1]))
end
print("Загальна вага:", total_weight)

