--Script by Coltaho 4/26/2024
--Supports Snes9x-RR 1.60 and Bizhawk
--Art by Kammesennin and Coltaho

if not event then
	print("Found: Snes9x-RR")
    is_snes9x = true
else
	print("Found Bizhawk with core: " .. emu.getsystemid())
end

local weapons = {}
local myweapons = {	"homing", "sting", "shield", "fire", "storm", "spark", "cutter", "ice" }
local weaponIcons = {}
local weaponuIcons = {}
local sigmaStageIcons = {}
local tanks = {}
local mytanks = { nil, nil,	"armadillo", "mammoth", "eagle", "mandrill", nil, nil }
local etankIcon = nil
local hearts = {}
local myhearts = { "octopus", "chameleon", "armadillo", "mammoth", "eagle", "mandrill", "kuwanger", "penguin" }
local access = {}
local myaccess = { "octopus", "chameleon", "armadillo", "mammoth", "eagle", "mandrill", "kuwanger", "penguin" }
local heartIcon = nil
local upgrades = {}
local myupgrades = { "legs", "head", "body", "arm", "hado" }
local upgradeIcons = {}					
local upgradeuIcons = {}					
local selectedWeapon = 0
local imagesloaded = false
local sigmaStage = 0
local AP_ROM = false


local loadImage = function (image)
	if is_snes9x then
		local file = io.open(image .. ".gdstr", "r")
		img = file:read("*all")
		file:close()
		return img
	else
		return image .. ".png"
	end
end

--Function used to initialize all images into their variables
local function loadImages()
	weaponIcons = {
		loadImage("./images/homing"),
		loadImage("./images/sting"),
		loadImage("./images/shield"),
		loadImage("./images/fire"),
		loadImage("./images/storm"),	
		loadImage("./images/spark"),
		loadImage("./images/cutter"),
		loadImage("./images/ice")
	}
						
	weaponuIcons = {
		loadImage("./images/homingu"),
		loadImage("./images/stingu"),
		loadImage("./images/shieldu"),
		loadImage("./images/fireu"),
		loadImage("./images/stormu"),	
		loadImage("./images/sparku"),
		loadImage("./images/cutteru"),
		loadImage("./images/iceu")
	}

	sigmaStageIcons = {
		loadImage("./images/sig_1"),
		loadImage("./images/sig_2"),
		loadImage("./images/sig_3"),
		loadImage("./images/X1sigma"),
		loadImage("./images/X1sigmadead")
	}

	etankIcon = loadImage("./images/etank")
	heartIcon = loadImage("./images/heart")

	upgradeIcons = {
		loadImage("./images/legs"),
		loadImage("./images/helmet"),
		loadImage("./images/body"),
		loadImage("./images/arm"),
		loadImage("./images/headband")
	}
						
	upgradeuIcons = {
		loadImage("./images/legsu"),
		loadImage("./images/helmetu"),
		loadImage("./images/bodyu"),
		loadImage("./images/armu")
	}

	imagesloaded = true
end

--Selects proper draw function for an image based on emulator
function putImage(x, y, img, w, h, alpha)
	if is_snes9x then 
		if alpha == nil then alpha = 1.0 end
		gui.gdoverlay(x, y, img, 0, 0, w, h, alpha)
	else 
		gui.drawImage(img, x, y)
	end	
end

--Function for drawing GUI
function DrawGUIOverlay()
	--Draw weapons
	local weaponCount = 0	
	for i = 1, 8 do
		if weapons[myweapons[i]] then
			putImage(i * 16, 207, weaponIcons[i], 16, 16)
			weaponCount = weaponCount + 1
		else
			putImage(i * 16, 207, weaponuIcons[i], 16, 16)
		end
	end
    
	--If we have hado or are at final Sigma stage, stop drawing hearts/subtanks
	if sigmaStage < 3 then
		if not upgrades.hado then
			--Draw hearts  
			for i = 1, 8 do
				if hearts[myhearts[i]] then
					putImage((i * 16), 199, heartIcon, 16, 16, 0.9)
				end
			end
			
			--Draw subtanks
			for i = 1, 8 do
				if tanks[mytanks[i]] then
					putImage((i * 16) + 8, 199, etankIcon, 16, 16, 0.9)
				end
			end
		end
	end

	--Draw Current Sigma stage unlocked
	if weaponCount == 8 and sigmaStage == 0 then 
		putImage(146, 207, sigmaStageIcons[sigmaStage + 1], 16, 16)
	elseif sigmaStage > 0 then
		putImage(146, 207, sigmaStageIcons[sigmaStage + 1], 16, 16)
	end
	
	--Draw Current Armor Upgrades
	for i = 1, 4 do
		if upgrades[myupgrades[i]] then
			putImage(148 + (i * 16), 207, upgradeIcons[i], 16, 16)
		else
			putImage(148 + (i * 16), 207, upgradeuIcons[i], 16, 16)
		end
	end
	
	--Draw Hado upgrade over helmet if we have it
	if upgrades[myupgrades[5]] then
		putImage(180, 207, upgradeIcons[5], 16, 16)
	end	

	--Draw a box around the selected weapon icon
	if selectedWeapon ~= 0 then
		if is_snes9x then
			gui.box(selectedWeapon * 16 + 1, 208, (selectedWeapon * 16) + 14, 221, "#FFFFFF00", "#FFFF00FF")
		else 
			gui.drawBox(selectedWeapon * 16 + 1, 208, (selectedWeapon * 16) + 14, 221, "yellow")
		end
	end
	
	--Draw a box around stages with access codes if AP ROM and at stage select
	if AP_ROM then 
		if STAGE_SELECT then
			if is_snes9x then
				if access.octopus then gui.box(82, 18, 125, 60, 0, "green") end
				if access.penguin then gui.box(130, 18, 173, 60, 0, "green") end
				if access.armadillo then gui.box(35, 65, 77, 108, 0, "green") end
				if access.mammoth then gui.box(178, 65, 220, 108, 0, "green") end
				if access.eagle then gui.box(35, 113, 77, 156, 0, "green") end
				if access.kuwanger then gui.box(178, 113, 220, 156, 0, "green") end
				if access.mandrill then gui.box(82, 161, 125, 203, 0, "green") end
				if access.chameleon then gui.box(130, 161, 173, 203, 0, "green") end
			else 
				if access.octopus then gui.drawRectangle(82, 18, 43, 42, "lime") end
				if access.penguin then gui.drawRectangle(130, 18, 43, 42, "lime") end
				if access.armadillo then gui.drawRectangle(35, 65, 42, 43, "lime") end
				if access.mammoth then gui.drawRectangle(178, 65, 42, 43, "lime") end
				if access.eagle then gui.drawRectangle(35, 113, 42, 43, "lime") end
				if access.kuwanger then gui.drawRectangle(178, 113, 42, 43, "lime") end
				if access.mandrill then gui.drawRectangle(82, 161, 43, 42, "lime") end
				if access.chameleon then gui.drawRectangle(130, 161, 43, 42, "lime") end
			end
		end
	end
	
end

--Adjusts address based on emulator
function adjustAddr(addr)
	if not is_snes9x then
		return addr - 0x7E0000
	end
	return addr
end

--Reads values of tracked items every emulated frame
function readValues()

	--Reads selected weapon (multiple of 2 so divided by two for 1 - 8)
	selectedWeapon = memory.readbyte(adjustAddr(0x7E0BDB)) / 2
	
	--location
	sigmaStage = memory.readbyte(adjustAddr(0x7E1F7B))
	
	--Obtained weapons
	weapons.homing = memory.readbyte(adjustAddr(0x7E1F88)) > 1
	weapons.sting = memory.readbyte(adjustAddr(0x7E1F8A)) > 20
	weapons.shield = memory.readbyte(adjustAddr(0x7E1F8C)) > 20
	weapons.fire = memory.readbyte(adjustAddr(0x7E1F8E)) > 20
	weapons.storm = memory.readbyte(adjustAddr(0x7E1F90)) > 20
	weapons.spark = memory.readbyte(adjustAddr(0x7E1F92)) > 20
	weapons.cutter = memory.readbyte(adjustAddr(0x7E1F94)) > 20
	weapons.ice = memory.readbyte(adjustAddr(0x7E1F96)) > 20
	
	--Hado Visits, turns to 128 + visit count when gotten
	upgrades.hado = memory.readbyte(adjustAddr(0x7E1F7E)) >= 128
	
	--Armor upgrades and Subtank bitflags
	local mybyte = memory.readbyte(adjustAddr(0x7E1F99))
	upgrades.head = mybyte % 2 == 1
	upgrades.arm = mybyte % 4 >= 2
	upgrades.body = mybyte % 8 >= 4
	upgrades.legs = mybyte % 16 >= 8
	tanks.eagle = mybyte % 32 >= 16
	tanks.armadillo = mybyte % 64 >= 32
	tanks.mandrill = mybyte % 128 >= 64
	tanks.mammoth = mybyte % 256 >= 128
	
	--Heart bitflags
	mybyte = memory.readbyte(adjustAddr(0x7E1F9C))
	hearts.penguin = mybyte % 2 == 1
	hearts.armadillo = mybyte % 4 >= 2
	hearts.eagle = mybyte % 8 >= 4
	hearts.chameleon = mybyte % 16 >= 8
	hearts.mammoth = mybyte % 32 >= 16
	hearts.kuwanger = mybyte % 64 >= 32
	hearts.mandrill = mybyte % 128 >= 64
	hearts.octopus = mybyte % 256 >= 128
	
	--Stage Access for AP
	if AP_ROM then 
		access.octopus = memory.readbyte(adjustAddr(0x7FEE41)) == 1
		access.chameleon = memory.readbyte(adjustAddr(0x7FEE42)) == 1
		access.armadillo = memory.readbyte(adjustAddr(0x7FEE43)) == 1
		access.mammoth = memory.readbyte(adjustAddr(0x7FEE44)) == 1
		access.eagle = memory.readbyte(adjustAddr(0x7FEE45)) == 1
		access.mandrill = memory.readbyte(adjustAddr(0x7FEE46)) == 1
		access.kuwanger = memory.readbyte(adjustAddr(0x7FEE47)) == 1
		access.penguin = memory.readbyte(adjustAddr(0x7FEE48)) == 1
		
		STAGE_SELECT = memory.readbyte(adjustAddr(0x7E00D2)) == 0 and memory.readbyte(adjustAddr(0x7E00D3)) == 1
	end

end

--Ensure we have the images loaded before we try to use them
if not imagesloaded then loadImages() end

function cleanUp()
	print("Exiting...")
	gui.clearGraphics()
	gui.clearImageCache()
end

if is_snes9x then
    -- snes9x-rr:
	if memory.readbyte(0x7FEE41) <= 1 then
		AP_ROM = true
		print ("AP ROM Found!")
	end	
	emu.registerafter(readValues)
	gui.register(DrawGUIOverlay)
else
    -- bizhawk:
	memory.usememorydomain("CARTROM")
	if memory.readbyte(0x17FFE1) ~= 0xFF then
		AP_ROM = true
		print ("AP ROM Found!")
	end	
	memory.usememorydomain("WRAM")
	print("Domain: " .. memory.getcurrentmemorydomain());
	event.onexit(cleanUp)
    while true do
        readValues()
        DrawGUIOverlay()
        emu.frameadvance()
    end
end

