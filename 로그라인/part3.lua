-----------------------------------------------------------------------------------------
--
--part3.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	--배경
	local background = display.newImageRect("image/임시 배경.png", display.contentWidth, display.contentHeight)
 	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local uiImage = display.newImage("image/대사창.png")
	uiImage.x,uiImage.y=display.contentWidth*0.5, display.contentHeight*0.8
	uiImage:scale(0.6, 0.6)

	local cat = display.newImage("image/고양이.png")
	cat.x,cat.y=display.contentWidth*0.85, display.contentHeight*0.8
	cat:scale(0.2, 0.2)
	cat.alpha = 0

	-- DIALOG
	local dialog = display.newGroup()

	local image = display.newRect(dialog, display.contentWidth*0.15, display.contentHeight*0.71, 200, 300)
	--이미지 변경할때 newRect사용해서 생성하기
	local speaker = display.newText(dialog, "캐릭터 이름", display.contentWidth*0.34, display.contentHeight*0.73, display.contentWidth*0.2, display.contentHeight*0.1)
	speaker:setFillColor(0)
	speaker.size = 40

	local content = display.newText(dialog, "솰라솰라 불라불라", display.contentWidth*0.59, display.contentHeight*0.85, display.contentWidth*0.7, display.contentHeight*0.2)
	content:setFillColor(0)
	content.size = 30

	-- json에서 정보 읽기
	local Data = jsonParse( "json/dialog2.json" )--파싱한 결과물 담기
	if (Data) then
		print(Data[1].speaker)
		print(Data[1].content)
		print(Data[1].image)
	end

	-- json에서 읽은 정보 적용하기
	local index = 0

	local function nextScript( event )
		index = index + 1
		if(index > #Data) then
			composer.gotoScene("part4")
			return
		end

		speaker.text = Data[index].speaker
		content.text = Data[index].content
		image.fill = {
			type = "image",
			filename = Data[index].image
		}

		--효과음 부분
		if Data[index].speaker == "PW-24601" and Data[index].content == "내게 많은 걸 바라지 마." then
			local cat=audio.loadStream("sound/고양이.mp3")
			audio.play( cat , {loops = 0} )
	 	end
	 	if Data[index].speaker == "아라" and Data[index].content == "고양이다!" then
			local cat=audio.loadStream("sound/고양이.mp3")
			audio.play( cat , {loops = 0} )
	 	end

	 	--고양이 터치 부분
 		if Data[index].speaker == "아라" and Data[index].content == "임시" then
			dialog.isVisible = false
			speaker.isVisible = false
			uiImage.isVisible=false
			content.text = nil
			cat.alpha = 1

			local function tapCat(event)
				speaker.isVisible = true
        		dialog.isVisible = true
       	 		uiImage.isVisible = true
        		cat.alpha = 0
			end

			cat:addEventListener("tap", tapCat)

		end
 
	

	end	
	background:addEventListener("tap", nextScript)

	nextScript()

	

	sceneGroup:insert(background)
	sceneGroup:insert(uiImage)
	sceneGroup:insert(dialog)
	sceneGroup:insert(cat)
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