-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	physics.start()
	physics.setDrawMode( "hybrid" )
	   
	local background = display.newImageRect("image/ocean.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local ground = {}
	ground[1] = display.newImageRect("image/ground.png", 192, 96)
	ground[1].x, ground[1].y = 544, 670
	ground[2] = display.newImageRect("image/ground.png", ground[1].width, ground[1].height)
	ground[2].x, ground[2].y = 736, 670
	ground[3] = display.newImageRect("image/ground.png", ground[1].width, ground[1].height)
	ground[3].x, ground[3].y = 960, 470
	ground[4] = display.newImageRect("image/ground.png", ground[1].width, ground[1].height)
	ground[4].x, ground[4].y = 724, 232
	ground[5] = display.newImageRect("image/ground.png", ground[1].width, ground[1].height)
	ground[5].x, ground[5].y = 436, 334
	ground[6] = display.newImageRect("image/ground.png", ground[1].width, ground[1].height)
	ground[6].x, ground[6].y = 100, 270

	local wall = {}
	wall[1] = display.newRect(0, background.y, 30, background.height)
	wall[2] = display.newRect(background.width, background.y, 30, background.height)
	wall[3] = display.newRect(background.x, 0, background.width, 30)
	wall[4] = display.newRect(background.x, background.height, background.width, 30)

	sceneGroup:insert(background)

	for i = 1, #ground do 
		physics.addBody(ground[i], "static")
		sceneGroup:insert(ground[i])
	end
	
	for i = 1, #wall do
		physics.addBody(wall[i], "static")
		sceneGroup:insert(wall[i])
		wall[i].name = "wall"
	end

	local chest = display.newImageRect("image/chest.png", 64, 48)
	local chest_outline = graphics.newOutline(1, "image/chest.png")
	chest.x, chest.y = 760, 600
	chest.name = "chest"
	physics.addBody(chest, "static",{outline=chest_outline})--상자는 사각형이 아니지만 충돌 라인이 사격형이다 이를 해결하 싶다면 graphics.newOutline(거칠기,이미지파일이름,[선택])을 사용하여 상자의 충돌 라인을 섬세하게 잡아낼수 있다
	sceneGroup:insert(chest)

	local arrow = {}--좌우버튼과 점프버튼 추가
	arrow[1] = display.newImageRect("image/arrow_left.png", 38, 64)
	arrow[1].x, arrow[1].y = 900, 625
	arrow[1].name = "left"
	arrow[2] = display.newImageRect("image/arrow_center.png", 84, 84)
	arrow[2].x, arrow[2].y = arrow[1].x+86, 625
	arrow[2].name = "center"
	arrow[3] = display.newImageRect("image/arrow_right.png", 38, 64)
	arrow[3].x, arrow[3].y = arrow[2].x+86, 625
	arrow[3].name = "right"

	arrow[4] = "right"    -- 토끼의 방향 정보 적어주기,디폴트 값은 right

	local player = display.newImageRect("image/rabbit.png", 52, 50)

	--outline은 좌우반전이 되지 않기에 토끼 이미지는 2가지 준비해주기
	local player_outline_none = graphics.newOutline(1, "image/rabbit.png")
	local player_outline_flip = graphics.newOutline(1, "image/rabbit_flip.png")
	
	player.x, player.y = background.x, background.y+200
	player.name = "player"

	--물리엔진 추가
	physics.addBody(player, {friction=1, outline=player_outline_none})
	player.isFixedRotation = true 
	sceneGroup:insert(player)
	player.isFixedRotation = true--토끼가 회전하며 착지하는 현상 막기

	--바튼을 누르면 토끼가 이동하도록
	function arrowTab( event )
		x = player.x--플레이어의 현 위치 잡아주기
		y = player.y
		
		if (event.target.name == "center") then
			if (event.target.name == "left") then
				transition.to(player, {time=100, x=(x-100), y=(y-200)})
			else
			    transition.to(player, {time=100, x=(x+100), y=(y-200)})
			end
		else 
			if (event.target.name == arrow[4]) then--target.name는 오른쪽버튼인지 왼쪽버튼인지 정보에 대한 변수
				if (event.target.name == "left") then--왼쪽 버튼을 누를때
			       transition.to(player, {time=100, x=(x-50)})
			    else--오른쪽 버튼을 누를떄 
			       transition.to(player, {time=100, x=(x+50)})
			    end
		    else
			    arrow[4] = event.target.name--현재토끼의 방향 바꿔주기
			    player:scale(-1, 1)--토끼 이미지 바꿔주기
			    physics.removeBody(player)--플레이어의 물리엔진 삭제

			    if (event.target.name == "left") then
			       physics.addBody(player, {friction=1, outline=player_outline_flip})
			       transition.to(player, {time=100, x=(x-50)})
			    else
			       physics.addBody(player, {friction=1, outline=player_outline_none})
			       transition.to(player, {time=100, x=(x+50)})
			    end
			    player.isFixedRotation = true--토끼가 회전하며 착지하는 현상 막기
		    end
		end
	end	

	for i=1,3 do
		arrow[i]:addEventListener("tap", arrowTab)
		sceneGroup:insert(arrow[i])
	end

	--포션추가하기(중력 영향x,플레이어의 충돌만을 감지)
	--kinematic을 설정,inSensor을 설정 플레이어와 충돌이 물리효과없이 충돌감지만 체크

	local potion = display.newImageRect("image/potion_red.png", 60, 60)
	local potion_outline = graphics.newOutline(1, "image/potion_red.png")
	potion.x, potion.y = 500, 590
	potion.name = "potion"

	physics.addBody(potion, "kinematic", {outline=potion_outline, isSensor=true})    
	-- isSensor를 설정하면 플레이어와 부딪혀도 튕겨나가지 않는다!
	sceneGroup:insert(potion)

	local score = 0
	local flag=false

	function rabbit( self, event )
		if(event.phase=="ended" and flag==false)then
			if(event.other.name=="chest" or event.other.name=="potion")then
				flag=true
				if(event.other.name == "chest") then--event.other을 통해 충돌한 요소의 정보를 알수있음
					score=score+100
				else
					score=score-100
				end
				timer.performWithDelay( 500, function()
					physics.removeBody( event.other )
				    flag = false
				end )
				print(score)
			end
		end
	end

	--충돌감지를 확인하려면 collision리스너를 추가해야
	player.collision=rabbit--rabbit은 cliiision 이벤트 리스너의 함수
	player:addEventListener("collision")

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





-- 물리엔진
-- 실제 세계의 물리 법칙에 따라 움직이도록 처리하는 프로그램
-- 솔라 2d는 이러한 물리 엔진구현을 위해 physics 라이브러리 사용
-- physics 라이브러리 사용하려면 물리 엔진을 사용하겠다는 의미로 physics.start적어주기
-- composer 라이브러리와 달리 따로 선언해주지 않아도 된다
-- physics.setDrawMode("hybrid")->디스플레이에 효과가 어떻게 적용되어 있는지 확인 가능
-- physics.pause() 물리 엔진 일시정지 하고싶을때
-- physics.stop 물리 엔진 재시작 없이 아예 그만두고 싶을때
-- 물리효과를 적용하고 싶은 디스플레이 오브젝트를 
-- physics.addBody(요소이름,[bodyType],[물리정보])
-- 라는 메쏘드의 매개변수로 전달 
-- bodyType이란?
-- 물리 오브젝트 유형
-- static,dynamic,kinematic 3가지를 말함
-- static: 다른 물리 오브젝트와 충돌해도 어떤 반응 없이 고정되어 있어 지면으로 많이 사용+벽
-- dynamic: 물리 정보에 기반해 실시간으로 요소의 상태 결정,주변 영향을 많이 받아 플레이어로 많이 사용
-- kinematic: 중력에 영향을 많이 받지 않아 장애물,비행체 따위로 많이 사용
-- static은 dynamic 충돌만 인식(kinematic 인식 x) 
-- kinematic은 dynamic 충돌만 인식(static 인식 x)
-- 물리 정보?
-- 속이 꽉 찬 정도인 밀도 (density)
-- 다른 오브젝트와 부딪혔을때 날아가거나 되돌아오는 속도를 결정하는 탄성 (bounce)
-- 거칠어질수록 커지는 마찰(friction)
-- 충돌만 감지하는 isSensor
-- 특정 충돌만 감지하는 filter
