local control = nil
local dropdown = nil
local saveButton = nil
local saveDialog = nil
local deleteButton = nil
local deleteDialog = nil
local data = nil
local lang = "en"

local function GetLanguage()
    local lang = GetCVar("language.2")

    --check for supported languages
    if SavedDyeSetsStrings[lang] ~= nil then return lang end

    --return english if not supported
    return "en"
end

local function DyeStationClosed()
    control:SetHidden(true)
    SLASH_COMMANDS["/dyeset"] = nil
end

local function LoadDyeSet(name)
    if data.setTable[name] then
        for i = 1, 4, 1 do
            SetSavedDyeSetDyes(i, data.setTable[name]["primary" .. i], data.setTable[name]["secondary" .. i],
                data.setTable[name]["accent" .. i])
            DYEING:RefreshSavedSet(i)
        end


        d("Dye sets loaded. (" .. name .. ")")
    else
        d("Set does not exist.")
    end
end

local function SaveDyeSet(name)
    for i = 1, 4, 1 do
        local primaryDyeId, secondaryDyeId, accentDyeId = GetSavedDyeSetDyes(i)

        if data.setTable[name] then
            
            data.setTable[name]["primary" .. i] = primaryDyeId
            data.setTable[name]["secondary" .. i] = secondaryDyeId
            data.setTable[name]["accent" .. i] = accentDyeId
        else
            data.setTable[name] = {}
            data.setTable[name]["primary" .. i] = primaryDyeId
            data.setTable[name]["secondary" .. i] = secondaryDyeId
            data.setTable[name]["accent" .. i] = accentDyeId
        end
    end

    d("Dye sets saved. (" .. name .. ")")
end

local function DeleteDyeSet(name)
    if data.setTable[name] then
        data.setTable[name] = nil
        d("Dye sets deleted. (" .. name .. ")")
    else
        d("Set does not exist.")
    end
end

local function OnButtonClicked(button)
    if button.save == true then
        saveDialog = ZO_Dialogs_ShowDialog("SAVE_DYESET")
    else
        deleteDialog = ZO_Dialogs_ShowDialog("DELETE_DYESET")
    end
end

local function OnDropdownSelect(name)
    PlaySound(SOUNDS.DIALOG_ACCEPT)
    LoadDyeSet(name)
end

local function PopulateDropdown()
    local comboBox = dropdown.m_comboBox
    local setTable = data.setTable

    if setTable == nil then return end

    comboBox:SetSortsItems(true)
    comboBox:ClearItems()
    for i,_ in pairs(setTable) do
        comboBox:AddItem(ZO_ComboBox:CreateItemEntry(i, function()
            OnDropdownSelect(i) end))
    end

    comboBox:SetSelectedItemFont("ZoFontGameSmall")
    comboBox:SetDropdownFont("ZoFontGameSmall")
    comboBox.m_selectedItemText:SetText("Load sets...")
end

local function DyeStationOpened()
    PopulateDropdown()
    control:SetHidden(false)

    SLASH_COMMANDS["/dyeset"] = function(arg)
        local options = {}
        local searchResult = { string.match(arg,"^(%S*)%s*(.-)$") }
        for i,v in pairs(searchResult) do
            if (v ~= nil and v ~= "") then
                options[i] = string.lower(v)
            end
        end

        if options[1] == "load" then LoadDyeSet(options[2]) end
        if options[1] == "save" then SaveDyeSet(options[2]) end
        if options[1] == "delete" then DeleteDyeSet(options[2]) end
        if options[1] == "list" then
            local setTable = data.setTable

            for i,_ in pairs(setTable) do
                d(i)
            end
        end
    end
end

local function InitializeControls()
    local parent = ZO_DyeingTopLevel
    local name = "SavedDyeSets"

    control = WINDOW_MANAGER:CreateControl(name, parent, CT_CONTROL)
    control:SetAnchor(LEFT, ZO_DyeingTopLevelSavedSetsHeader, RIGHT, 0, 0)
    control:SetDimensions(ZO_DyeingTopLevelTools:GetWidth(), ZO_DyeingTopLevelTools:GetHeight())
    control:SetHidden(true)
    
    dropdown = WINDOW_MANAGER:CreateControlFromVirtual(name .. "LoadDyesDropdown", control, "ZO_ComboBox")
    dropdown:SetAnchor(LEFT, control, LEFT, 10, 0)
    dropdown:SetHeight(27)
    dropdown:SetWidth(136)
    PopulateDropdown()

    saveButton = WINDOW_MANAGER:CreateControl(name .. "SaveDyesButton", control, CT_BUTTON)
    saveButton:SetText("Save sets")
    saveButton:SetFont("ZoFontGameBold")
    saveButton:SetDimensions(73, 22)
    saveButton:SetAnchor(LEFT, dropdown, RIGHT, 5, 0)
    saveButton:SetHandler("OnClicked", OnButtonClicked)
    saveButton:SetMouseEnabled(true)
    saveButton:SetHidden(false)
    saveButton:SetNormalFontColor(0.77254903316498, 0.76078432798386, 0.61960786581039, 1)
    saveButton:SetPressedFontColor(0.68627452850342, 0.68627452850342, 0.68627452850342, 1)
    saveButton:SetClickSound(SOUNDS.DIALOG_ACCEPT)
    saveButton.save = true

    deleteButton = WINDOW_MANAGER:CreateControl(name .. "DeleteDyesButton", control, CT_BUTTON)
    deleteButton:SetText("Delete sets")
    deleteButton:SetFont("ZoFontGameBold")
    deleteButton:SetDimensions(85, 22)
    deleteButton:SetAnchor(LEFT, saveButton, RIGHT, 5, 0)
    deleteButton:SetHandler("OnClicked", OnButtonClicked)
    deleteButton:SetMouseEnabled(true)
    deleteButton:SetHidden(false)
    deleteButton:SetNormalFontColor(0.77254903316498, 0.76078432798386, 0.61960786581039, 1)
    deleteButton:SetPressedFontColor(0.68627452850342, 0.68627452850342, 0.68627452850342, 1)
    deleteButton:SetClickSound(SOUNDS.DIALOG_ACCEPT)
    deleteButton.delete = true

    local function SetupSaveDialog()
        local info = {
            customControl = self,
            setup = SetupSaveDialog,
            title = {
                text = zo_strupper(SavedDyeSetsStrings[lang].SAVE_TITLE),
            },
            mainText = {
                text = SavedDyeSetsStrings[lang].SAVE_TEXT,
            },
            editBox = {},
            buttons = {
                [1] = {
                    text = SavedDyeSetsStrings[lang].SAVE_BUTTON,
                    callback = function() 
                        SaveDyeSet(ZO_Dialogs_GetEditBoxText(saveDialog))
                        PopulateDropdown()
                    end,
                },
                [2] = {
                    text = SI_DIALOG_CANCEL,
                },
            },
        }
        ZO_Dialogs_RegisterCustomDialog("SAVE_DYESET", info)
    end
    local function SetupDeleteDialog()
        local info = {
            customControl = self,
            setup = SetupDeleteDialog,
            title = {
                text = zo_strupper(SavedDyeSetsStrings[lang].DELETE_TITLE),
            },
            mainText = {
                text = SavedDyeSetsStrings[lang].DELETE_TEXT,
            },
            editBox = {},
            buttons = {
                [1] = {
                    text = SavedDyeSetsStrings[lang].DELETE_BUTTON,
                    callback = function() 
                        DeleteDyeSet(ZO_Dialogs_GetEditBoxText(deleteDialog))
                        PopulateDropdown()
                    end,
                },
                [2] = {
                    text = SI_DIALOG_CANCEL,
                }
            }
        }
        ZO_Dialogs_RegisterCustomDialog("DELETE_DYESET", info)
    end

    SetupSaveDialog()
    SetupDeleteDialog()
end

local function SavedDyeSetsOnLoaded(eventCode, addonName)
    if addonName ~= "SavedDyeSets" then return end
    EVENT_MANAGER:UnregisterForEvent("SavedDyeSetsOnLoaded", EVENT_ADD_ON_LOADED)

    local defaults = { setTable = {}, }

    lang = GetLanguage()
    data = ZO_SavedVars:NewAccountWide("SavedDyeSets_SavedData", 1.1, nil, defaults)

    InitializeControls()

    EVENT_MANAGER:RegisterForEvent("DyeStationOpened", EVENT_DYEING_STATION_INTERACT_START, DyeStationOpened)
    EVENT_MANAGER:RegisterForEvent("DyeStationClosed", EVENT_DYEING_STATION_INTERACT_END, DyeStationClosed)
end

EVENT_MANAGER:RegisterForEvent("SavedDyeSetsOnLoaded", EVENT_ADD_ON_LOADED, SavedDyeSetsOnLoaded)