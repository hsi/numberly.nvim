local M = {}

M.Numberings = {
    NONE = 0,
    ABSOLUTE = 1,
    RELATIVE = 2,
    BOTH = 3,
}

local numberings = {}

local function get_current_window_key()
    return tostring(vim.api.nvim_get_current_win())
end


local function set_numbering()
    local window_key = get_current_window_key()

    vim.o.number = numberings[window_key][1].number
    vim.o.relativenumber = numberings[window_key][1].relativenumber
end


function M.next()
    local window_key = get_current_window_key()
    local first_item = table.remove(numberings[window_key], 1)
    table.insert(numberings[window_key], first_item)

    set_numbering()
end


function M.prev()
    local window_key = get_current_window_key()
    local last_item = table.remove(numberings[window_key])
    table.insert(numberings[window_key], 1, last_item)

    set_numbering()
end


local function filter_numberings(raw_numberings)
    local filtered_numberings = {}

    for _, v in pairs(raw_numberings) do
        local number = bit.band(v, M.Numberings.ABSOLUTE) == M.Numberings.ABSOLUTE
        local relativenumber = bit.band(v, M.Numberings.RELATIVE) == M.Numberings.RELATIVE

        table.insert(filtered_numberings, {
            number = number,
            relativenumber = relativenumber,
        })
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
