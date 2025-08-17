-----------------------------------------------------------------------------------------
--
-- sea_explanation1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()


function scene:create( event )
	local sceneGroup = self.view

	local uiImage = display.newImage("image/대사창.png")
	uiImage.x,uiImage.y=display.contentWidth*0.5, display.contentHeight*0.8
	uiImage:scale(0.6, 0.6)

	local text1 = display.newText("희미하지만 파도 소리가 들려온다.", display.contentWidth*0.42, display.contentHeight*0.80, display.contentWidth*0.7, display.contentHeight*0.2)
	text1:setFillColor(0)
	text1.size = 30

	local text2 = display.newText("파란 물빛이 햇빛에 일렁거린다.", display.contentWidth*0.42, display.contentHeight*0.85, display.contentWidth*0.7, display.contentHeight*0.2)
	text2:setFillColor(0)
	text2.size = 30

	local text3 = display.newText("오랫동안 사람들의 공해가 없어서 다시 깨끗해진 바다이다.", display.contentWidth*0.42, display.contentHeight*0.90, display.contentWidth*0.7, display.contentHeight*0.2)
	text3:setFillColor(0)
	text3.size = 30

 	function uiImage:tap( event )
 		composer.hideOverlay('sea_explanation1')
 	end

 	uiImage:addEventListener("tap", uiImage)


 	sceneGroup:insert(uiImage)
 	sceneGroup:insert(text1)
 	sceneGroup:insert(text2)
 	sceneGroup:insert(text3)
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