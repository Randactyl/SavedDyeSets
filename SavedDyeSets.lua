local savedVars = nil
local savedVarsVersion = "1.0"

--[[local deleteButton = nil
local saveButton = nil
local loadButton = nil
local dropdown = nil]]

local function LoadDyes(name)
    d("Loading dye sets...")

    --local name = dropdown.entry --???
    --local primaryDyeId, secondaryDyeId, accentDyeId

    if savedVars[name] then
        for i = 1, 4, 1 do
            SetSavedDyeSetDyes(i, savedVars[name]["primary" .. i], savedVars[name]["secondary" .. i], savedVars[name]["accent" .. i])
        	DYEING:RefreshSavedSet(i)
        end


        d("Dye sets loaded. (" .. name .. ")")
    else
        d("Set does not exist.")
    end
end

local function SaveDyes(name)
    d("Saving dye sets...")

    --local name = dropdown.entry --???

    for i = 1, 4, 1 do
        local primaryDyeId, secondaryDyeId, accentDyeId = GetSavedDyeSetDyes(i)

        if savedVars[name] then
        	savedVars[name]["primary" .. i] = primaryDyeId
        	savedVars[name]["secondary" .. i] = secondaryDyeId
        	savedVars[name]["accent" .. i] = accentDyeId
        else
        	savedVars[name] = {}
        	savedVars[name]["primary" .. i] = primaryDyeId
        	savedVars[name]["secondary" .. i] = secondaryDyeId
        	savedVars[name]["accent" .. i] = accentDyeId
        end
    end

    d("Dye sets saved. (" .. name .. ")")
end

local function DeleteDyes(name)
    d("Deleting dye sets...")
    --local name = dropdown.entry --???
    if savedVars[name] then
    	savedVars[name] = nil
    	d("Dye sets deleted. (" .. name .. ")")
    else
    	d("Set does not exist.")
    end
end

--[[local function ButtonClickHandler(button)
    if button.load == true then
        LoadDyes()
    elseif button.save == true then
        SaveDyes()
    else
        DeleteDyes()
    end
end

local function CreateDropdown()
	dropdown = WINDOW_MANAGER:CreateControl(ZO_DyeingTopLevelTabs:GetName() .. "_Dropdown", ZO_DyeingTopLevelTabs, CT_EDITBOX)
	--dropdown:SetText("Load")
	--dropdown:SetFont("ZoFontGameBold")
	dropdown:SetDimensions(110, 20)
	dropdown:SetAnchor(RIGHT, ZO_DyeingTopLevelTabs_LoadButton, LEFT, 0, 0)
	--dropdown:SetHandler("OnClicked", ButtonClickHandler)
	dropdown:SetMouseEnabled(true)
	dropdown:SetHidden(true)
	--dropdown:SetNormalFontColor(0.77254903316498, 0.76078432798386, 0.61960786581039, 1)
	--dropdown:SetPressedFontColor(0.68627452850342, 0.68627452850342, 0.68627452850342, 1)
	--dropdown:SetClickSound(SOUNDS.DIALOG_ACCEPT)
end

local function CreateLoadButton()
	loadButton = WINDOW_MANAGER:CreateControl(ZO_DyeingTopLevelTabs:GetName() .. "_LoadButton", ZO_DyeingTopLevelTabs, CT_BUTTON)
	loadButton:SetText("Load")
	loadButton:SetFont("ZoFontGameBold")
	loadButton:SetDimensions(60, 20)
	loadButton:SetAnchor(RIGHT, ZO_DyeingTopLevelTabs_SaveButton, LEFT, 0, 0)
	loadButton:SetHandler("OnClicked", ButtonClickHandler)
	loadButton:SetMouseEnabled(true)
	loadButton:SetHidden(true)
	loadButton:SetNormalFontColor(0.77254903316498, 0.76078432798386, 0.61960786581039, 1)
	loadButton:SetPressedFontColor(0.68627452850342, 0.68627452850342, 0.68627452850342, 1)
	loadButton:SetClickSound(SOUNDS.DIALOG_ACCEPT)

	loadButton.load = true
end

local function CreateSaveButton()
	saveButton = WINDOW_MANAGER:CreateControl(ZO_DyeingTopLevelTabs:GetName() .. "_SaveButton", ZO_DyeingTopLevelTabs, CT_BUTTON)
	saveButton:SetText("Save")
	saveButton:SetFont("ZoFontGameBold")
	saveButton:SetDimensions(60, 20)
	saveButton:SetAnchor(RIGHT, ZO_DyeingTopLevelTabs_DeleteButton, LEFT, 0, 0)
	saveButton:SetHandler("OnClicked", ButtonClickHandler)
	saveButton:SetMouseEnabled(true)
	saveButton:SetHidden(true)
	saveButton:SetNormalFontColor(0.77254903316498, 0.76078432798386, 0.61960786581039, 1)
	saveButton:SetPressedFontColor(0.68627452850342, 0.68627452850342, 0.68627452850342, 1)
	saveButton:SetClickSound(SOUNDS.DIALOG_ACCEPT)

	saveButton.save = true
end

local function CreateDeleteButton()
	deleteButton = WINDOW_MANAGER:CreateControl(ZO_DyeingTopLevelTabs:GetName() .. "_DeleteButton", ZO_DyeingTopLevelTabs, CT_BUTTON)
	deleteButton:SetText("Delete")
	deleteButton:SetFont("ZoFontGameBold")
	deleteButton:SetDimensions(60, 20)
	deleteButton:SetAnchor(RIGHT, ZO_DyeingTopLevelTabsLabel, LEFT, 0, 0)
	deleteButton:SetHandler("OnClicked", ButtonClickHandler)
	deleteButton:SetMouseEnabled(true)
	deleteButton:SetHidden(true)
	deleteButton:SetNormalFontColor(0.77254903316498, 0.76078432798386, 0.61960786581039, 1)
	deleteButton:SetPressedFontColor(0.68627452850342, 0.68627452850342, 0.68627452850342, 1)
	deleteButton:SetClickSound(SOUNDS.DIALOG_ACCEPT)
end]]

local function DyeStationClosed()
	SLASH_COMMANDS["/dyeset"] = nil
end

local function DyeStationOpened()
    --[[deleteButton:SetHidden(false)
    saveButton:SetHidden(false)
   	loadButton:SetHidden(false)
    dropdown:SetHidden(false)
    ZO_DyeingTopLevelTabs:SetAnchor(RIGHT, ZO_DyeingTopLevel, RIGHT, 270, -330)]]

    SLASH_COMMANDS["/dyeset"] = function(arg)
    	local options = {}
    	local searchResult = { string.match(arg,"^(%S*)%s*(.-)$") }
    	for i,v in pairs(searchResult) do
        	if (v ~= nil and v ~= "") then
         		options[i] = string.lower(v)
        	end
    	end

    	--d(options)

    	--[[if options[2] == nil then return end
    	local set = options[2]
    	for i = 3, #options, 1 do
    		set = set .. " " .. options[i]
    	end

    	d("concated")]]

    	if options[1] == "load" then LoadDyes(options[2]) end
    	if options[1] == "save" then SaveDyes(options[2]) end
    	if options[1] == "delete" then DeleteDyes(options[2]) end
    	if options[1] == "list" then
    		for i,_ in pairs(savedVars["default"][GetUnitName("player")]) do
    			if i ~= "version" then d(i) end
    		end
    	end
	end
end

local function SavedDyeSetsOnLoaded(eventCode, addonName)
    if addonName ~= "SavedDyeSets" then return end

    local default = {}
    savedVars = ZO_SavedVars:New("SavedDyeSets", savedVarsVersion, nil, default)

    EVENT_MANAGER:UnregisterForEvent("SavedDyeSetsOnLoaded", EVENT_ADD_ON_LOADED)
    EVENT_MANAGER:RegisterForEvent("DyeStationOpened", EVENT_DYEING_STATION_INTERACT_START, DyeStationOpened)
    EVENT_MANAGER:RegisterForEvent("DyeStationClosed", EVENT_DYEING_STATION_INTERACT_END, DyeStationClosed)


    --[[CreateDeleteButton()
    CreateSaveButton()
    CreateLoadButton()
    CreateDropdown()]]
end

EVENT_MANAGER:RegisterForEvent("SavedDyeSetsOnLoaded", EVENT_ADD_ON_LOADED, SavedDyeSetsOnLoaded)