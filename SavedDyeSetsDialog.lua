local function SetupSaveDialog()

end

function SavedDyeSets_SetupSaveDialog(self)
    local info = {
        customControl = self,
        setup = SetupSaveDialog,
        title = {
            text = zo_strupper("save dye sets"),
        },
        buttons = {
            [1] = {
                control = GetControl(self, "Save"),
                text = "Save",
                callback = function() end,
            },
            [2] = {
                control = GetControl(self, "Cancel"),
                text = SI_DIALOG_CANCEL,
            }
        }
    }
    ZO_Dialogs_RegisterCustomDialog("SAVE_DYESET", info)
end

local function SetupDeleteDialog()

end

function SavedDyeSets_SetupDeleteDialog(self)
    local info = {
        customControl = self,
        setup = SetupDeleteDialog,
        title = {
            text = zo_strupper("delete dye sets"),
        },
        buttons = {
            [1] = {
                control = GetControl(self, "Delete"),
                text = "Delete",
                callback = function() end,
            },
            [2] = {
                control = GetControl(self, "Cancel"),
                text = SI_DIALOG_CANCEL,
            }
        }
    }
    ZO_Dialogs_RegisterCustomDialog("DELETE_DYESET", info)
end