-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- show default status bar (iOS)
display.setStatusBar( display.DefaultStatusBar )

-- include Corona's "widget" library
local widget = require "widget"
--여러가지 씬으로 이루어진 게임을 가능하게 하는것이 composer 라이브러리
local composer = require "composer"--라이브러리를 가져오는 부분,c언어의 #include와 유사


-- event listeners for tab buttons:
local function onFirstView( event )--첫번째로 불러올 루아 파일이름
	composer.gotoScene( "game" )--가져온 composer로 gotoScene()이라는 장면을 이동하는 함수를 사용하고 있음,우리는 이 부분을 변경해서 처음 가져올 작품들을 바꿨음
end



onFirstView()	-- invoke first tab button's onPress event manually
