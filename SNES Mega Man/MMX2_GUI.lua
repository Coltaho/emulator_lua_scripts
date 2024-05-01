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
local myweapons = {	"crystal", "bubble", "silk", "wheel", "slicer", "chain", "magnet", "burner", "giga", "tracer" }
local weaponIcons = {}
local weaponuIcons = {}
local chStageIcons = {}
local tanks = {}
local mytanks = { nil, "crab", nil, nil, nil, "sponge", "centipede", "stag" }
local etankIcon = nil
local hearts = {}
local myhearts = { "snail", "crab", "moth", "gator", "ostrich", "sponge", "centipede", "stag" }
local heartIcon = nil
local upgrades = {}
local myupgrades = { "legs", "head", "body", "arm", "shoryuken" }
local zero = {}
local myzero = { "legs", "head", "body" }
local upgradeIcons = {}					
local upgradeuIcons = {}					
local selectedWeapon = 0
local imagesloaded = false
local chStage = 0
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
		loadImage("./images/crystal"),
		loadImage("./images/bubble"),
		loadImage("./images/silk"),
		loadImage("./images/wheel"),
		loadImage("./images/slicer"),	
		loadImage("./images/chain"),
		loadImage("./images/magnet"),
		loadImage("./images/burner"),
		loadImage("./images/giga"),
		loadImage("./images/tracer")
	}
						
	weaponuIcons = {
		loadImage("./images/crystalu"),
		loadImage("./images/bubbleu"),
		loadImage("./images/silku"),
		loadImage("./images/wheelu"),
		loadImage("./images/sliceru"),	
		loadImage("./images/chainu"),
		loadImage("./images/magnetu"),
		loadImage("./images/burneru"),
		loadImage("./images/gigau"),
		loadImage("./images/traceru")
	}

	chStageIcons = {
		loadImage("./images/ch_1"),
		loadImage("./images/ch_2"),
		loadImage("./images/ch_3"),
		loadImage("./images/X2refights"),
		loadImage("./images/X2sigma"),
		loadImage("./images/X2sigmadead")
	}

	etankIcon = loadImage("./images/etank")
	heartIcon = loadImage("./images/heart")

	upgradeIcons = {
		loadImage("./images/X2legs"),
		loadImage("./images/X2helmet"),
		loadImage("./images/X2body"),
		loadImage("./images/X2arm"),
		loadImage("./images/headband")
	}
						
	upgradeuIcons = {
		loadImage("./images/X2legsu"),
		loadImage("./images/X2helmetu"),
		loadImage("./images/X2bodyu"),
		loadImage("./images/X2armu")
	}
	
	zeroIcons = {
		loadImage("./images/ZLegs"),
		loadImage("./images/ZHead"),
		loadImage("./images/ZBody")
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
	for i = 1, 10 do
		if weapons[myweapons[i]] then
			putImage(i * 16 - 12, 207, weaponIcons[i], 16, 16)
			if i <= 8 then
				weaponCount = weaponCount + 1
			end
		else
			putImage(i * 16 - 12, 207, weaponuIcons[i], 16, 16)
		end
	end
    
	--If we have Shoryuken or are at final stage, stop drawing hearts/subtanks
	if chStage < 4 then
		if not upgrades.hado then
			--Draw hearts  
			for i = 1, 8 do
				if hearts[myhearts[i]] then
					putImage((i * 16) - 12, 199, heartIcon, 16, 16, 0.9)
				end
			end
			
			--Draw subtanks
			for i = 1, 8 do
				if tanks[mytanks[i]] then
					putImage((i * 16) - 4, 199, etankIcon, 16, 16, 0.9)
				end
			end
		end
	end

	--Draw Current Counter Hunter stage unlocked
	if weaponCount == 8 and chStage == 0 then 
		putImage(166, 207, chStageIcons[chStage + 1], 16, 16)
	elseif chStage > 0 then
		putImage(166, 207, chStageIcons[chStage + 1], 16, 16)
	end
	
	--Draw Current Armor Upgrades
	for i = 1, 4 do
		if upgrades[myupgrades[i]] then
			putImage(168 + (i * 16), 207, upgradeIcons[i], 16, 16)
		else
			putImage(168 + (i * 16), 207, upgradeuIcons[i], 16, 16)
		end
	end
	
	--Draw Current Zero parts
	for i = 1, 3 do
		if zero[myzero[i]] then
			-- putImage(168 + (i * 16), 191, zeroIcons[i], 16, 16)		
			putImage(88 + (i * 16), 0, zeroIcons[i], 16, 16)		
		end
	end
	
	--Draw Shoryuken upgrade over helmet if we have it
	if upgrades[myupgrades[5]] then
		putImage(200, 207, upgradeIcons[5], 16, 16)
	end	

	--Draw a box around the selected weapon icon
	if selectedWeapon ~= 0 then
		if is_snes9x then
			gui.box(selectedWeapon * 16 - 11, 208, (selectedWeapon * 16) + 2, 221, "#FFFFFF00", "#FFFF00FF")
		else 
			gui.drawBox(selectedWeapon * 16 - 11, 208, (selectedWeapon * 16) + 2, 221, "#FFFFFF00")
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

	--Reads selected weapon (multiple of 2 so divided by two for 1 - 10)
	selectedWeapon = memory.readbyte(adjustAddr(0x7E0A0B)) / 2
	
	--location
	chStage = memory.readbyte(adjustAddr(0x7E1FAE))
	
	--Obtained weapons
	weapons.crystal = memory.readbyte(adjustAddr(0x7E1FBB)) > 20
	weapons.bubble = memory.readbyte(adjustAddr(0x7E1FBD)) > 20
	weapons.silk = memory.readbyte(adjustAddr(0x7E1FBF)) > 20
	weapons.wheel = memory.readbyte(adjustAddr(0x7E1FC1)) > 20
	weapons.slicer = memory.readbyte(adjustAddr(0x7E1FC3)) > 20
	weapons.chain = memory.readbyte(adjustAddr(0x7E1FC5)) > 20
	weapons.magnet = memory.readbyte(adjustAddr(0x7E1FC7)) > 20
	weapons.burner = memory.readbyte(adjustAddr(0x7E1FC9)) > 20
	weapons.giga = memory.readbyte(adjustAddr(0x7E1FCB)) > 20
	weapons.tracer = memory.readbyte(adjustAddr(0x7E1FCD)) > 20
	
	local mybyte = memory.readbyte(adjustAddr(0x7E1FB1))
	upgrades.shoryuken = mybyte % 256 >= 128
		
	--Armor upgrades and Subtank bitflags
	mybyte = memory.readbyte(adjustAddr(0x7E1FD0))
	upgrades.head = mybyte % 2 == 1
	upgrades.arm = mybyte % 4 >= 2
	upgrades.body = mybyte % 8 >= 4
	upgrades.legs = mybyte % 16 >= 8
	tanks.centipede = mybyte % 32 >= 16
	tanks.stag = mybyte % 64 >= 32
	tanks.sponge = mybyte % 128 >= 64
	tanks.crab = mybyte % 256 >= 128
	
	--Heart bitflags
	mybyte = memory.readbyte(adjustAddr(0x7E1FD3))
	hearts.moth = mybyte % 2 == 1
	hearts.stag = mybyte % 4 >= 2
	hearts.ostrich = mybyte % 8 >= 4
	hearts.centipede = mybyte % 16 >= 8
	hearts.snail = mybyte % 32 >= 16
	hearts.gator = mybyte % 64 >= 32
	hearts.crab = mybyte % 128 >= 64
	hearts.sponge = mybyte % 256 >= 128
	
	--Zero Parts
	zero.legs = memory.readbyte(adjustAddr(0x7E1FD6)) >= 128
	zero.head = memory.readbyte(adjustAddr(0x7E1FD7)) >= 128
	zero.body = memory.readbyte(adjustAddr(0x7E1FD8)) >= 128

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
	emu.registerafter(readValues)
	gui.register(DrawGUIOverlay)
else
    -- bizhawk:
	memory.usememorydomain("WRAM")
	print("Domain: " .. memory.getcurrentmemorydomain());
	event.onexit(cleanUp)
    while true do
        readValues()
        DrawGUIOverlay()
        emu.frameadvance()
    end
end

