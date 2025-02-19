local SlugmanLib = {}

local BaseURL = "https://raw.githubusercontent.com/Im-sigma/Slugman-Hub/main/"

local ActiveUI = {}

-- Function to Load a UI Component
function SlugmanLib.LoadUI(name)
    local uiURL = BaseURL .. name .. ".lua"

    -- Destroy existing UI
    for uiName, _ in pairs(ActiveUI) do
        SlugmanLib.DestroyUI(uiName)
    end

    local success, response = pcall(function()
        return loadstring(game:HttpGet(uiURL, true))()
    end)

    if success and response then
        ActiveUI[name] = response() -- Store UI instance
    else
        warn("Failed to load UI:", name, response)
    end
end

-- Function to Destroy a UI Component
function SlugmanLib.DestroyUI(name)
    if ActiveUI[name] then
        if typeof(ActiveUI[name]) == "function" then
            ActiveUI[name](true) -- Call the function to destroy UI
        end
        ActiveUI[name] = nil
    end
end

-- Function to Load a Script
function SlugmanLib.LoadSCRIPT(name)
    local scriptURL = BaseURL .. name .. ".lua"

    local success, response = pcall(function()
        return loadstring(game:HttpGet(scriptURL, true))()
    end)

    if success then
        response()
    else
        warn("Failed to load script:", name, response)
    end
end

-- Function to Save a Script Locally
function SlugmanLib.SaveSCRIPT(name, filePath)
    local scriptURL = BaseURL .. name .. ".lua"

    local scriptData = game:HttpGet(scriptURL, true)
    makefolder(filePath:match("(.+)/") or "") -- Ensure folder exists
    writefile(filePath, scriptData)
end

return SlugmanLib
