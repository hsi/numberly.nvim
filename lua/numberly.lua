local M = {}

local numberings = {}

local function set_absolute_numbering()
    vim.o.number = true
    vim.o.relativenumber = false
end


local function set_relative_numbering()
    vim.o.number = false
    vim.o.relativenumber = true
end


local function set_both_numbering()
    vim.o.number = true
    vim.o.relativenumber = true
end


local function disable_numbering()
    vim.o.number = false
    vim.o.relativenumber = false
end


local function get_current_window_key()
    return tostring(vim.api.nvim_get_current_win())
end


local function set_numbering()
    local window_key = get_current_window_key()

    if     numberings[window_key][1] == 'a' then set_absolute_numbering()
    elseif numberings[window_key][1] == 'r' then set_relative_numbering()
    elseif numberings[window_key][1] == 'b' then set_both_numbering()
    else disable_numbering()
    end
end


function M.next()
    local window_key = get_current_window_key()
    local first_item = table.remove(numberings[window_key], 1)
    table.insert(numberings[window_key], first_item)

    set_numbering()
end


local function filter_numberings(raw_numberings)
    local filtered_numberings = {}

    for _, v in pairs(raw_numberings) do
        if type(v) == 'string' and string.find(string.lower(v), '[arb]') == 1 then
            table.insert(filtered_numberings, string.char(string.byte(v)))
        else
            table.insert(filtered_numberings, '')
        end
    end

    return filtered_numberings
end


function M.setup(raw_numberings)
    if type(raw_numberings) ~= 'table' then return end

    local window_key = get_current_window_key()
    numberings[window_key] = filter_numberings(raw_numberings)

    set_numbering()
end


return M
