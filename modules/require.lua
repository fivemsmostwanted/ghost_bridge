local moduleCache = {}

--- Custom require function to load modules within the FiveM resource environment.
--- @param moduleName string The name of the module to load.
--- @return any The loaded module.
local function customRequire(moduleName)
    -- Check if the module is already cached
    local cachedModule = moduleCache[moduleName]
    if cachedModule == '__LOADING__' then
        error(("Circular dependency detected while loading module '%s'"):format(moduleName))
    elseif cachedModule then
        return cachedModule
    end

    -- Mark the module as loading to detect circular dependencies
    moduleCache[moduleName] = '__LOADING__'

    -- Convert module name to file path
    local modulePath = moduleName:gsub('%.', '/') .. '.lua'

    -- Get the current resource name
    local resourceName = GetCurrentResourceName()

    -- Load the module file content
    local fileContent = LoadResourceFile(resourceName, modulePath)

    if not fileContent then
        error(("Module '%s' not found in resource '%s'"):format(moduleName, resourceName))
    end

    -- Load the module code into a function
    local moduleFunction, loadError = load(fileContent, '@' .. modulePath, 't')

    if not moduleFunction then
        error(("Error loading module '%s': %s"):format(moduleName, loadError))
    end

    -- Execute the module code
    local result = moduleFunction()

    -- Cache the loaded module (use 'true' if result is nil)
    moduleCache[moduleName] = result or true

    return moduleCache[moduleName]
end

-- Set the custom require globally
_G.require = customRequire