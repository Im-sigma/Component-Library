local UILibrary = {}
UILibrary.ActiveComponents = {}
UILibrary.ScriptURLs = {}
function UILibrary.LoadUI(ComponentName)
    if UILibrary.ActiveComponents[ComponentName] then
        return
    end
    local url = UILibrary.ScriptURLs[ComponentName]
    if url then
        local success, UIComponent = pcall(loadstring(game:HttpGet(url, true)))
        if success then
            UILibrary.ActiveComponents[ComponentName] = UIComponent
            UIComponent()
        else
            warn("Failed to load UI:", ComponentName)
        end
    else
        warn("No URL found for:", ComponentName)
    end
end
function UILibrary.DestroyUI(ComponentName)
    if UILibrary.ActiveComponents[ComponentName] then
        UILibrary.ActiveComponents[ComponentName] = nil
    end
end
function UILibrary.LoadSCRIPT(ScriptName)
    local url = UILibrary.ScriptURLs[ScriptName]
    if url then
        local success, ScriptFunction = pcall(loadstring(game:HttpGet(url, true)))
        if success then
            ScriptFunction()
        else
            warn("Failed to load script:", ScriptName)
        end
    else
        warn("No URL found for:", ScriptName)
    end
end
return UILibrary
