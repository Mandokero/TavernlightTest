local q7Window = nil;
local jumpButton = nil;

function init() openWindow() end -- cool, we open the window when we load this module
function terminate()
    removeEvent(myLoopEventId)
    closeWindow()
end -- and then we close it when we unload

function openWindow()
    q7Window = g_ui.displayUI('q7.otui') -- shows the window
    -- I would like to please save the button to this variable such that it can be manipulated with the jumpClick() method
    jumpButton = q7Window:getChildById('jumpButton')
    moveButtonLeft()
end

function moveButtonLeft()
    jumpButton:setMarginRight(jumpButton:getMarginRight() + 5)
    if (jumpButton:getMarginRight() > 350) then jumpClick() end
    moveAgainEvent = scheduleEvent(moveButtonLeft, 50)
end

function closeWindow()
    q7Window:destroy()
    q7Window = nil
end

function jumpClick()
    jumpButton:setMarginRight(5)
    jumpButton:setMarginTop(math.random(350))
end
