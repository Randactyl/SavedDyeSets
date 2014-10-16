SavedDyeSetGroup = ZO_Object:Subclass()

function SavedDyeSetGroup:SetHidden(value)
	self.control:SetHidden(value)
end

function SavedDyeSetGroup:Init()
	local parent = ZO_DyeingTopLevel

	self.name = "SavedDyeSets"
	self.control = WINDOW_MANAGER:CreateControl(self.name, parent, CT_CONTROL)
	self.control:SetAnchor(LEFT, ZO_DyeingTopLevelToolsHeader, RIGHT, 0, 0)
	self.control:SetDimensions(ZO_DyeingTopLevelTools:GetWidth(), ZO_DyeingTopLevelTools:GetHeight())
	self.control:SetHidden(true)

	self.label = WINDOW_MANAGER:CreateControl(self.control:GetName().."Label", self.control, CT_LABEL)
	self.label:SetAnchor(TOPLEFT, self.control, TOPLEFT, 0, 0)
	self.label:SetFont("ZoFontGameSmall")
	self.label:SetHidden(false)
	self.label:SetText("SAVED DYE SETS")
	self.label:SetVerticalAlignment(TEXT_ALIGN_CENTER)
	
end

function SavedDyeSetGroup:New()
	local obj = ZO_Object.New( self )
	obj:Init()
	return obj
end