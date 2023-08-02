local url = 'https://raw.githubusercontent.com/MythicalTrashcan/Tools/main/Tools.lua';
local content = game:HttpGetAsync(url);

local Script = loadstring(content)
Script()
