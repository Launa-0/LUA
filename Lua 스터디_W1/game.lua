-----------------------------------------------------------------------------------------
--
-- game.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

local timeAttack--create()함수도 접근하고 hide()함수도 접근해야 함으로 앞으로 빼서 선언해주기

function scene:create( event )
	local sceneGroup = self.view
	
	 -- 1차시 display object ---------------------------------------------------------------------

	local background = display.newImageRect("image/background.png", display.contentWidth, display.contentHeight)
 	background.x, background.y = display.contentWidth/2, display.contentHeight/2

 	local bunny = display.newImage("image/bunny.png")--이미지 기본크기 그대로 가져오는 함수
 	bunny.x, bunny.y = display.contentWidth*0.3, display.contentHeight*0.6

 	 local ground = display.newImage("image/ground.png")
 	ground.x, ground.y = display.contentWidth*0.7, display.contentHeight*0.7

 	local carrotGroup = display.newGroup()
 	local carrot = {}--배열선언하기

 	for i = 1, 5 do--5번 반복하는 반복문
 		carrot[i] = display.newImageRect(carrotGroup, "image/carrot.png", 60, 150)--parent에 오브젝트가 속할 디스플레이 그룹 이름 적어주기
 		carrot[i].x, carrot[i].y = display.contentWidth*0.55 + 60*i, display.contentHeight*0.6--옆으로정렬

 		--carrotGroup:insert(carrot[i])
 	end

 	local diceGroup=display.newGroup()
 	local dice = {}

 	for i = 1, 6 do
 		dice[i] = display.newImage(diceGroup, "image/dice (" .. i .. ").png")-- ..은 문자 이어주는 연산자 
 		dice[i].x, dice[i].y = display.contentWidth*0.5, display.contentHeight*0.25
 		
 		dice[i]:scale(2, 2)--스케일 함수로 주사위 크기 키우기
 		dice[i].alpha = 0
 	end

 	dice[math.random(6)].alpha = 1--1부터 6까지 점수 반환

 	local score = display.newText(0, display.contentWidth*0.1, display.contentHeight*0.15) --덱스트랑 x,y값만 넣기
 	score.size = 100--글자크기설정

 	score:setFillColor(0)--검은색
 	score.alpha = 0.5--투명도 넣기

 	--타이머
 	local time = display.newText(10, display.contentWidth*0.9, display.contentHeight*0.15) --덱스트랑 x,y값만 넣기
 	time.size = 100--글자크기설정

 	time:setFillColor(0)--검은색
 	time.alpha = 0.5--투명도 넣기

 	-- 레이어 정리
 	sceneGroup:insert(background)
 	sceneGroup:insert(bunny)
 	sceneGroup:insert(ground)
 	sceneGroup:insert(carrotGroup)
 	sceneGroup:insert(diceGroup)
 	sceneGroup:insert(score)
 	sceneGroup:insert(time)--생성한 순서대로 넣기

 	ground:toFront()--그라운드만 앞으로 뺴기

 	--2차시: Event------------------------------------------------

 	 	local function tapDice( event )--tapdice라는 이벤트 리스너 추가하기
 		for i = 1, 6 do--어떤 주사위가 보여지고 있는지 모르니 모든 주사위 투명도를 0으로 정하기
 			dice[i].alpha = 0 
 		end
 		dice[math.random(6)].alpha = 1--랜덤으로 하나 보여지기
 	end

 	diceGroup:addEventListener("tap", tapDice)--다이스그룹에 통채로 이벤트 리스너 추가하기--터치할떄마다 주사위 눈이 바뀜


 	 	local function dragCarrot( event )--드래그 함수 그냥 공식처럼 생각하기
 		if( event.phase == "began" ) then
 			display.getCurrentStage():setFocus( event.target )
 			event.target.isFocus = true
 			-- 드래그 시작할 때
 			event.target.initX=event.target.x--이벤트 타겟의 현재좌표 넣어놓기 그럼 처음 x값이 저장됨
 			event.target.initY=event.target.y--initX는 원래 존재하는 속성값이 아닌 이름을 정해서 변수처럼 사용하는것

 		elseif( event.phase == "moved" ) then

 			if ( event.target.isFocus ) then
 				-- 드래그 중일 때
 				event.target.x = event.xStart + event.xDelta
 				event.target.y = event.yStart + event.yDelta
 			end

 		elseif ( event.phase == "ended" or event.phase == "cancelled") then
 			display.getCurrentStage():setFocus( nil )
 			event.target.isFocus = false
 			-- 드래그 끝났을 때
 			if(event.target.x>bunny.x-50 and event.target.x<bunny.x+50 
 				and event.target.y>bunny.y-50 and event.target.y<bunny.y+50 )then--현재 이벤트 타겟의 위치가 토끼의 위치에 있는지 따져보기 오차범위 50내에 있으면 인식이 되도록 
 			
				display.remove(event.target)--토끼에게 당근을 줬다고 인식되면 당근 없애기
 				score.text=score.text+1--점수 올려주기

 				if( score.text == '5') then--당근 5
 					score.text = '성공!'
 					time.alpha = 0--시간은 게임이 끝났으니 필요없다
 					composer.gotoScene('ending')--게임이 끝나면 엔딩으로 전환하기(성공)
 				end

 			else
 				--event.target.x = event.xStart --이 방식은 오차가 생김
 				--event.target.y = event.yStart --xStart사용하지 않고 x,y좌표 처음 위치값 저장해두었다가 사용하기
 				event.target.x = event.target.initX
 				event.target.y = event.target.initY
 			end
 		end
 	end

 	for i = 1, 5 do
 		carrot[i]:addEventListener("touch", dragCarrot)--당근 1번부터 5번까ㅈㅣ 이벤트 리스너 추가하기
 	end

 	local function counter( event )--카운터라는 이벤트 리스너 추가
 		time.text = time.text - 1--시간이 줄어야 

 		if( time.text == '5' ) then--시간이 5라면 색을 빨갛게
 			time:setFillColor(1, 0, 0)
 		end

 		if( time.text == '-1') then--시간이 -1인경우
 			time.alpha = 0--게임이 끝났으니 투명도가 0

 			if( score.text ~= '성공!' ) then--스코어가 성공이 아니라면
 				score.text = '실패!'--실패 글자가 뜨게하기
 				bunny:rotate(90)--토끼가 쓰러지게 하기--오브젝트 돌릴때는 rotate 함수
 			
 				for i = 1, 5 do--게임이 끝나면 당근 못움직이게 하기
 					carrot[i]:removeEventListener("touch", dragCarrot)--당근에 씌어진 드래그 함수가 사라짐 			
 				end
 				composer.gotoScene('ending2')--게임이 끝나면 엔딩으로 전환하기(실패)
 			end
		end
 	end
 
	timeAttack = timer.performWithDelay(1000, counter, 11)--1초 뒤에 시작,11번 반복(-1까지 갈거니까)

	--설정버튼 만들기
 	local setting = display.newText("설정", display.contentWidth*0.8, display.contentHeight*0.15)
 	setting.size = 50
 	setting:setFillColor(0.3)

 	function setting:tap( event )
 		timer.pause(timeAttack)--설정창 켰을떄 타이머 일시정지
 		composer.setVariable("timeAttack",timeAttack)--앞의 타임어택은 별명같은 느낌이 뒤에서 변수값 넘겨주기
 		
 		composer.showOverlay('setting')--게임화면 위에 띄우기
 	end
 	setting:addEventListener("tap", setting)

 	sceneGroup:insert(setting)

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
	
		composer.removeScene('game')--게임이 끝났을 때 정상적으로 ending.lua로 이동, 그러나, 다시 game으로 돌아오면 원래 상태 그대로이니 다시 돌아왔을때 다시 시작하려면 composer.removeScene()을 사용해 씬을 삭제해주면 불러올 씬이 사라진거니 다시 create()함수가 실행되며 새롭게 다시 시작이 가능하다
		timer.cancel(timeAttack)--오류가 안나게 타이머가 끝나게끔,타이머는 장면이 바뀌여도 실행이 되서 필요없어진 타이머는 꼭 삭제해줘야함 특히 무한반복 타이머는 꼭 고려하기
		--will에다 작성하는 이유는 did에다가 작성할 경우, 오류는 나지 않지만 가끔 scene을 삭제하는 타이밍이 늦어서 이미지가 깨지는 현상이 나타나기때문
	
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
