-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- json parsing
local json=require "json"--json 라이브러리 require

function jsonParse( src )--전역변수 jsonParse 함수를 만들어서 파일경로를 매개변수로
	local filename = system.pathForFile( src )--json파일 읽기
	
	local data, pos, msg = json.decodeFile(filename)--json형식의 데이터를 파싱래서 data에 받아주기
	--pos랑 msg는 json파일 형식에 오류가 있을때 몇번째 줄에 어떤 오류가 있는지 정보를 받아오게 된다

	-- 디버깅
	if (data) then--data파싱이 잘 됬으면 data 리턴
		return (data)
	else
		print("WARNING: " .. pos, msg)--오류가 있으면 pos,msg 출력
		return nil--nil값 리턴
	end
end

-- 

local composer = require "composer"

local function onFirstView( event )
	composer.gotoScene( "home" )
end

onFirstView()



