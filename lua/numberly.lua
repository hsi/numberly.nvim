local M = {}

M.Numberings = {
    NONE = 0,
    ABSOLUTE = 1,
    RELATIVE = 2,
    BOTH = 3,
}

local function get_buffer_numberings()
    local window_id = vim.api.nvim_get_current_win()
    local window_numberings = vim.w[window_id].numberings

    if window_numberings ~= nil then
        return window_numberings
    end

    local buffer_id = vim.api.nvim_get_current_buf()
    local buffer_numberings = vim.b[buffer_id].numberings
    local found = nil

    for i = 1, #buffer_numberings do
        if buffer_numberings[i].number == vim.o.number and
            buffer_numberings[i].relativenumber == vim.o.relativenumber then
            found = i
            break
        end
    end
    if #buffer_numberings > 1 and found > 1 then
        return {
            unpack(buffer_numberings, found, #buffer_numberings),
            unpack(buffer_numberings, 1, found - 1),
        }
    else
        return buffer_numberings
    end
end


local function set_numbering()
    local window_id = vim.api.nvim_get_current_win()

    vim.o.number         = vim.w[window_id].numberings[1].number
    vim.o.relativenumber = vim.w[window_id].numberings[1].relativenumber
end


function M.next()
    local window_id = vim.api.nvim_get_current_win()
    local numberings = get_buffer_numberings()

    local first_item = table.remove(numberings, 1)
    table.insert(numberings, first_item)
    vim.w[window_id].numberings = numberings

    set_numbering()
end


function M.prev()
    local window_id = vim.api.nvim_get_current_win()
    local numberings = get_buffer_numberings()

    local last_item = table.remove(numberings)
    table.insert(numberings, 1, last_item)
    vim.w[window_id].numberings = numberings

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

    local buffer_id = vim.api.nvim_get_current_buf()
    local window_id = vim.api.nvim_get_current_win()

    vim.b[buffer_id].numberings = filter_numberings(raw_numberings)
    vim.w[window_id].numberings = vim.b[buffer_id].numberings

    set_numbering()
end


return M
