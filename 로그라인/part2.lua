-----------------------------------------------------------------------------------------
--
--part2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function goToPart3(event)
    if event.phase == "ended" then
        	composer.gotoScene("part3")
    end
end
    	
function scene:create( event )
	local sceneGroup = self.view

	--배경
	local background = display.newImageRect("image/마을.jpg", display.contentWidth, display.contentHeight)
 	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local sea = display.newImage("image/바다.png")
	sea.x,sea.y=display.contentWidth*0.20, display.contentHeight*0.3
	sea:scale(0.4, 0.4)

	local house = display.newImage("image/집.png")
	house.x,house.y=display.contentWidth*0.55, display.contentHeight*0.55
	house:scale(1, 1)

	local trashcan = display.newImage("image/쓰레기통.png")
	trashcan.x,trashcan.y=display.contentWidth*0.85, display.contentHeight*0.7
	trashcan:scale(0.2, 0.2)

	local magazine = display.newImage("image/폐잡지.png")
	magazine.x,magazine.y=display.contentWidth*0.35, display.contentHeight*0.7
	magazine:scale(0.1, 0.1)

	local arrow = display.newImage("image/화살표.png")
	arrow.x,arrow.y=display.contentWidth*0.95, display.contentHeight*0.95
	arrow:scale(0.2, 0.2)

	local robot = display.newImage("image/로봇.png")
	robot.x,robot.y=display.contentWidth*0.15, display.contentHeight*0.71
	robot:scale(0.2,0.3)

	arrow:addEventListener("touch",goToPart3)

	--쓰레기통 누르면 뉴스 띄우기
	function trashcan:tap(event)
		composer.showOverlay('trashcan_explanation1')
	end

 	trashcan:addEventListener("tap", trashcan)

 	--쌓인 폐잡지 설명
	function magazine:tap(event)
		composer.showOverlay('magazine_explanation1')
	end

 	magazine:addEventListener("tap", magazine)

 	--폐가 설명
	function house:tap(event)
		composer.showOverlay('house_explanation1')
	end

 	house:addEventListener("tap", house)

 	--바다 설명
	function sea:tap(event)
		composer.showOverlay('sea_explanation1')
	end

 	sea:addEventListener("tap", sea)


	sceneGroup:insert(background)
	sceneGroup:insert(sea)
	sceneGroup:insert(house)
	sceneGroup:insert(trashcan)
	sceneGroup:insert(magazine)
	sceneGroup:insert(arrow)
	sceneGroup:insert(robot)

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