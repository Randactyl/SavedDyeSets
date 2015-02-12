SavedDyeSetsData = ZO_Object:Subclass()

local data = nil
local version = "1.1"

function SavedDyeSetsData:New()
	local obj = ZO_Object.New(self)
	obj:Initialize()
	return obj
end

function SavedDyeSetsData:Initialize()
	local defaults = { setTable = {}, }

	--str = SavedDyeSetsStrings[self:GetLanguage()]
	data = ZO_SavedVars:New("SavedDyeSets_SavedData", savedVarsVersion, nil, defaults)
end

function SavedDyeSetsData:GetSetTable()
	if data.setTable then return data.setTable end
	return nil
end

function SavedDyeSetsData:LoadDyeSet(name)
	d("Loading dye sets...")

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

function SavedDyeSetsData:SaveDyeSet(name)
	d("Saving dye sets...")

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

function SavedDyeSetsData:DeleteDyeSet(name)
	d("Deleting dye sets...")
    --local name = dropdown.entry --???
    if data.setTable[name] then
    	data.setTable[name] = nil
    	d("Dye sets deleted. (" .. name .. ")")
    else
    	d("Set does not exist.")
    end
end