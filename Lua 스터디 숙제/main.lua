-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- show default status bar (iOS)
display.setStatusBar( display.DefaultStatusBar )

-- include Corona's "widget" library
local widget = require "widget"
local composer = require "composer"


-- event listeners for tab buttons:
local function onFirstView( event )--첫번째로 불러올 루아 파일이름
	composer.gotoScene( "week2" )
end



onFirstView()	-- invoke first tab button's onPress event manually
