local function file_exists(fname)
	local stat = vim.loop.fs_stat(fname)
	return (stat and stat.type) or false
end

return {
    -- From the currently opened file traverses upwards in the directory tree
    -- to find the first file with file_name. Returns the full path to the
    -- directory where the file is found. 
    nearest = function(file_name)
        local file = vim.fn.expand('%:p')
        local split = vim.gsplit(file, "/")
        local arr = {}
        for v in split do
            arr[#arr + 1] = v
        end
        for i=1,#arr do
            table.remove(arr, #arr)
            local dir = table.concat(arr, "/")
            local n = dir .. "/" .. file_name
            if file_exists(n) then
                return n
            end
        end
        return nil
    end
}
