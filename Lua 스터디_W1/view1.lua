-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()--뷰1루아는 하나의 장면을 생성하는 파일이기 때문에 newScene()으로 장면을 생성하고 그걸 씬이라는 변수에 담아주고 있다

function scene:create( event )--이벤트 함수 안에 디스플레이 오브젝트 설정, 처음에 scene이 생성되었을 때/불러왔을때 실행
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
 	object[3]:setFillColor(1, 1, 0)

 	local objectGroup = display.newGroup()--디스플레이 그룹 객체 반환하는 함수
 	objectGroup:insert(object[1])--그룹에 insert를 이용해서 기
 	objectGroup:insert(object[3])
 	objectGroup:insert(object[2])

 	object[3]:toFront()--3번이 앞으로!맨앞으로 가져오기

 	objectGroup.x=objectGroup.x+100--그룹단위 변경
 	objectGroup.y=objectGroup.y-100

 	sceneGroup:insert(background)--지금까지 했던거 모두 sceneGroup에 담기
 	sceneGroup:insert(objectGroup)

 	--local function tapEventListener( event )--이벤트를 사용함으로서 게임이 플레이어와 상호작용할수 있음--이벤트를 매개변수로 가지는 함수가 이벤트 리스너 함수
 		--print("노란색 네모를 클릭했습니다!")
 	--end
 	--background:addEventListener("tap", tapEventListener)--백그라운드 객체에다 이벤트 리스너 추가하기--디스플레이 오브젝트:addEventListener("이벤트종류",선언한 함수 이름)--객체에 탭이 일어날때마다 이벤트 리스너가 실행된다
 	--object[3]:addEventListener("tap", tapEventListener)

--event라는 매개변수를 통해 일어난 event 정보가 넘어온다
 -- event.target.x = 100  --event.뒤에 뭔가를 붙여서 원하는 값을 가져올수 있다 --event.target은 이벤트가 일어난 오브젝트를 가져온다
 -- event.target.alpha = 0.5  
 -- event.target:setFillColor(1, 0, 0)  

 	--object[3].alpha = 0--투명도가 0일때는 탭이 안된다
 	--object[2]:toFront()--다른 오브젝트 뒤에 존재할때는 탭이 된다

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

 	 	local function drag( event )
 		if( event.phase == "began" ) then
 			display.getCurrentStage():setFocus( event.target )
 			event.target.isFocus = true
 			-- 드래그 시작할 때

 		elseif( event.phase == "moved" ) then

 			if ( event.target.isFocus ) then
 				-- 드래그 중일 때
 				event.target.x = event.xStart + event.xDelta- event.target.parent.x--xStart는 처음x값,xDelta는 마우스가 이동한 정도를 의미--처음 값에 이동한 만큼을 더해서 event.target.x에 넣어주면 드래그 하는대로 오브젝트가 마우스를 따라감
 				event.target.y = event.yStart + event.yDelta- event.target.parent.y--object를 디스플레이 그룹에 넣은 채로 그룹 채로 위치 이동을 했기 때문에 마우스 커서 위치와 오브젝트 위치에 오차가 있는데 이벤트타겟페어런츠로 오브젝트 그룹의 좌표값 빼주기
 			end

 		elseif ( event.phase == "ended" or event.phase == "cancelled") then
 		
 				display.getCurrentStage():setFocus( nil )
 				event.target.isFocus = false
 				-- 드래그 끝났을 때
 		end
	end

	object[3]:addEventListener("touch", drag)

	-- 타이머는 특정 오브젝트에 addEventListener를 사용하는것이 아닌
	-- timer.performWithDelay( delay, listener [, iterations] [, tag] )로 리스너가 (언제 실행될건지,무엇이 실행될건지,선택사항으로 몇번 반복될건지 설정,tag는 오늘 사용은 x)
	-- delay: 리스너 함수 실행까지 딜레이 시간
	-- listener: 리스너 함수 이름
	-- iterations: delay마다 반복 횟수
	-- 0 또는 -1은 무한 반복
	-- timer.cancle( timerName ): 정지--이미 실행하는 특정 타이머를 취소
	-- timer.pause( timerName ): 일시 정지
	-- timer.resume( timerName ): 재시작--일시정지한걸 재시작
	-- 뒤에 All을 붙여주면 실행되는 모든 타이머에 적용 가능

	-- local function alarm(event)--알람이라는 이름의 event함수
	-- 	print("1초 뒤입니다.")
	-- end

	-- local timeAttack = timer.performWithDelay(1000, alarm)--1000이 1초--생성된 타이머를 timaAttack에 담아놓을수 있다


 	local count = 1
 	local function counter( event )
 		print(count.."초가 지났습니다.")--문자를 합쳐주는 ..
 		count = count + 1
 	end

 	local timeAttack = timer.performWithDelay(1000, counter, 10)

end

function scene:show( event )--scene이 화면에 보여지기 직전(will) / 직후(did) , 예)배경음악 실행
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

function scene:hide( event )--scene이 화면에서 사라지기 직전(will) / 직후(did),gotoScene()으로 인해 다른 장면으로 넘어갈때 화면이 가려지게 될때 실행,예)배경음악 꺼주기
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

function scene:destroy( event )--scene이 삭제될 때
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