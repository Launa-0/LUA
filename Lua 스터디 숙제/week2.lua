-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	local background = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
	--검은창에서 흰 창으로 변함--디스플레이 오브젝트 생성 함수를 반환하는 오브젝트를 background라는 변수에 받음
	--사각형을 생성하는 함수--x,y좌표 가로 세로만 매개변수로 넘겨주기
	
	-- background:setFillColor(1,1,0)
	-- background.alpha=0.5 --알파는 투명도를 의미

	-- background.x=background.x + 100--Lua는 background.x += 100 불가함
	-- background.y=background.y - 100

	-- background:scale(0.5,0.5)--가로 넓이 줄이기,세로넓이줄이기

	local object={}--배열생성

	object[1]=display.newRect(display.contentCenterX, display.contentCenterY,500,500)
	object[1]:setFillColor(1,0,0)
	
 	object[2] = display.newRect(display.contentCenterX, display.contentCenterY, 300, 300)
 	object[2]:setFillColor(1, 0.5, 0)

 	object[3] = display.newRect(display.contentCenterX, display.contentCenterY, 100, 100)
 	object[3]:setFillColor(0.5, 0, 1)

 	local objectGroup = display.newGroup()--디스플레이 그룹 객체 반환하는 함수
 	objectGroup:insert(object[1])--그룹에 insert를 이용해서 기
 	objectGroup:insert(object[3])
 	objectGroup:insert(object[2])

 	object[3]:toFront()--3번이 앞으로!맨앞으로 가져오기

 	objectGroup.x=objectGroup.x+100--그룹단위 변경
 	objectGroup.y=objectGroup.y-100

 	sceneGroup:insert(background)--지금까지 했던거 모두 sceneGroup에 담기
 	sceneGroup:insert(objectGroup)

 	--local function tapEventListener( event )
 		--print("노란색 네모를 클릭했습니다!")
 	--end
 	--object[3]:addEventListener("tap", tapEventListener)

 	--object[3].alpha = 0
 	--object[2]:toFront()

 	 	-- local function touchEventListener( event )
 		-- if( event.phase == "began" ) then
 		-- 	print("터치를 시작함")
 		-- elseif( event.phase == "moved" ) then
 		-- 	print("객체를 누르고 있는 상태로 움직임(드래그)")
 		-- elseif ( event.phase == "ended" or event.phase == "cancelled") then
 		-- 	print("터치가 끝남")
 		-- end
 	--end
 
 	--object[3]:addEventListener("touch", touchEventListener)

local function tap(event)
    if (event.phase == "began") then
        display.getCurrentStage():setFocus(event.target)
        event.target.isFocus = true
        -- 터치 시작할 때
    elseif (event.phase == "moved") then
        if (event.target.isFocus) then
            -- 터치 중일 때 랜덤 위치로 이동하기
            local x = math.random(display.contentWidth)
            local y = math.random(display.contentHeight)
            object[3].x = x
            object[3].y = y
        end
    elseif (event.phase == "ended" or event.phase == "cancelled") then
        display.getCurrentStage():setFocus(nil)
        event.target.isFocus = false
        -- 터치 끝났을 때
    end
    return true
end

object[3]:addEventListener("touch", tap)
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