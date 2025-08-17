-----------------------------------------------------------------------------------------
--
--part8.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function goToPart4(event)
    if event.phase == "ended" then
        	composer.gotoScene("part4")
    end
end
    	
function scene:create( event )
	local sceneGroup = self.view

	--배경
	local background = display.newImageRect("image/마을.jpg", display.contentWidth, display.contentHeight)
 	background.x, background.y = display.contentWidth/2, display.contentHeight/2


	

	local arrow = display.newImage("image/화살표반대.png")
	arrow.x,arrow.y=display.contentWidth*0.05, display.contentHeight*0.95
	arrow:scale(0.2, 0.2)

	-- local robot = display.newImage("image/로봇.png")
	-- robot.x,robot.y=display.contentWidth*0.15, display.contentHeight*0.71
	-- robot:scale(0.2,0.3)

	arrow:addEventListener("touch",goToPart4)

	

	sceneGroup:insert(background)
	sceneGroup:insert(arrow)
	-- sceneGroup:insert(robot)

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene