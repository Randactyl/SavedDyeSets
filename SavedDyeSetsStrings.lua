SavedDyeSetsStrings = {
	["de"] = {},
	["fr"] = {},
	["en"] = {
		NAME = "Saved Dye Sets",
		SAVE_TITLE = "save dye sets", --passed to zo_strupper
		SAVE_TEXT = "Enter name of set to save:",
		SAVE_BUTTON = "Save",
		DELETE_TITLE = "delete dye sets", --passed to zo_strupper
		DELETE_TEXT = "Enter name of set to delete:",
		DELETE_BUTTON = "Delete",
	},
	["es"] = {},
	["ru"] = {},
}

setmetatable(SavedDyeSetsStrings["de"], {__index = SavedDyeSetsStrings["en"]})
setmetatable(SavedDyeSetsStrings["fr"], {__index = SavedDyeSetsStrings["en"]})
setmetatable(SavedDyeSetsStrings["ru"], {__index = SavedDyeSetsStrings["en"]})
setmetatable(SavedDyeSetsStrings["es"], {__index = SavedDyeSetsStrings["en"]})