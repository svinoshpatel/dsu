-- Алгоритм Прима на Lua
local INF = 1e9

-- Зчитування кількості вершин і ребер
io.write("Кількість вершин: ")
local n = tonumber(io.read())
io.write("Кількість ребер: ")
local m = tonumber(io.read())

-- Ініціалізація графа
local graph = {}
for i = 1, n do
    graph[i] = {}
end

-- Зчитування ребер
print("Введіть ребра у форматі: вершина1 вершина2 вага")
for i = 1, m do
    local u, v, w = io.read("*n", "*n", "*n")
    table.insert(graph[u], {v = v, w = w})
    table.insert(graph[v], {v = u, w = w})
end

-- Ініціалізація структур алгоритму Прима
local min_e = {}
local sel_e = {}
local visited = {}

for i = 1, n do
    min_e[i] = INF
    sel_e[i] = -1
    visited[i] = false
end

min_e[1] = 0

local total_weight = 0

print("\nРебра мінімального каркасу:")

for i = 1, n do
    local v = -1
    for j = 1, n do
        if not visited[j] and (v == -1 or min_e[j] < min_e[v]) then
            v = j
        end
    end

    visited[v] = true
    total_weight = total_weight + min_e[v]

    if sel_e[v] ~= -1 then
        print(string.format("%d - %d (вага: %d)", sel_e[v], v, min_e[v]))
    end

    for _, edge in ipairs(graph[v]) do
        if edge.w < min_e[edge.v] and not visited[edge.v] then
            min_e[edge.v] = edge.w
            sel_e[edge.v] = v
        end
    end
end

print("Загальна вага каркасу:", total_weight)

