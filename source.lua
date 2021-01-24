local module = {}

local function Set(t, i, v)
	t[i] = v;
end

function module:BoxUpdate(Instance, StartCF, Size, Properties)
    if Instance ~= nil then
        local Camera = game:GetService("Workspace").CurrentCamera

        local TopLeft, TLVis = Camera:WorldToViewportPoint((StartCF * CFrame.new(Size.X, Size.Y, 0)).Position)
        local TopRight, TRVis = Camera:WorldToViewportPoint((StartCF * CFrame.new(-Size.X, Size.Y, 0)).Position)
        local BottomRight, BRVis = Camera:WorldToViewportPoint((StartCF * CFrame.new(-Size.X, -Size.Y, 0)).Position)
        local BottomLeft, BLVis = Camera:WorldToViewportPoint((StartCF * CFrame.new(Size.X, -Size.Y, 0)).Position)

        if TLVis and TRVis and BRVis and BLVis then
            Properties.Visible = true
            Properties.PointA = Vector2.new(TopLeft.X, TopLeft.Y)
            Properties.PointB = Vector2.new(TopRight.X, TopRight.Y)
            Properties.PointC = Vector2.new(BottomRight.X, BottomRight.Y)
            Properties.PointD = Vector2.new(BottomLeft.X, BottomLeft.Y)
            for i,v in pairs(Properties) do
                pcall(Set, Instance, i, v)
            end
            return Instance
        else
            Instance:Remove()
            return nil
        end
    end
end
function module:BoxNew(StartCF, Size, Properties)
    local Camera = game:GetService("Workspace").CurrentCamera
	local NewBox = Drawing.new("Quad")

	local TopLeft, TLVis = Camera:WorldToViewportPoint((StartCF * CFrame.new(Size.X, Size.Y, 0)).Position)
	local TopRight, TRVis = Camera:WorldToViewportPoint((StartCF * CFrame.new(-Size.X, Size.Y, 0)).Position)
	local BottomRight, BRVis = Camera:WorldToViewportPoint((StartCF * CFrame.new(-Size.X, -Size.Y, 0)).Position)
	local BottomLeft, BLVis = Camera:WorldToViewportPoint((StartCF * CFrame.new(Size.X, -Size.Y, 0)).Position)

    if TLVis and TRVis and BRVis and BLVis then
		Properties.PointA = Vector2.new(TopLeft.X, TopLeft.Y)
		Properties.PointB = Vector2.new(TopRight.X, TopRight.Y)
		Properties.PointC = Vector2.new(BottomRight.X, BottomRight.Y)
		Properties.PointD = Vector2.new(BottomLeft.X, BottomLeft.Y)
		for i,v in pairs(Properties) do
			pcall(Set, NewBox, i, v)
		end
		return NewBox
	else
        NewBox:Remove()
        return nil
	end
end

function module:TextUpdate(Instance, Position, Properties, PositionOffset)
    local Camera = game:GetService("Workspace").CurrentCamera
    local ScreenPos, IsVisible = Camera:WorldToViewportPoint(Position)

    if IsVisible then
        PositionOffset = PositionOffset or Vector2.new(0,0)
        Properties.Position = Vector2.new(ScreenPos.X + PositionOffset.X, ScreenPos.Y + PositionOffset.Y)
        for i,v in pairs(Properties) do
			pcall(Set, Instance, i, v)
		end
		return Instance
    else
        Instance:Remove()
        return nil
    end
end
function module:TextNew(Position, Properties, PositionOffset)
    local Camera = game:GetService("Workspace").CurrentCamera
    local NewText = Drawing.new("Text")
    local ScreenPos, IsVisible = Camera:WorldToScreenPoint(Position)

    if IsVisible then
        PositionOffset = PositionOffset or Vector2.new(0,0)
        Properties.Position = Vector2.new(ScreenPos.X + PositionOffset.X, ScreenPos.Y + PositionOffset.Y)
        for i,v in pairs(Properties) do
			pcall(Set, NewText, i, v)
		end
		return NewText
    else
        NewText:Remove()
        return nil
    end
end

return module
