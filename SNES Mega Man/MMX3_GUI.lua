--Script by Coltaho 5/20/2024
--Supports Snes9x-RR 1.60 and Bizhawk
--Art by Kammesennin and Coltaho

if not event then
	print("Found: Snes9x-RR")
    is_snes9x = true
else
	print("Found Bizhawk with core: " .. emu.getsystemid())
end

local weapons = {}
local myweapons = {	"acid", "bomb", "thunder", "blade", "ray", "hole", "frost", "tornado", "hyper" }
local weaponIcons = {}
local weaponuIcons = {}
local sigmaStageIcons = {}
local ridearmorIcons = {}
local ridearmor = {}
local myridearmor = { "RAN", "RAF", "RAH", "RAK" }
local ridefull = false
local tanks = {}
local mytanks = { nil, nil,	"catfish", nil, "tiger", nil, "buffalo", "rhino" }
local subtanksall = false
local etankIcon = nil
local hearts = {}
local myhearts = { "seahorse", "hornet", "catfish", "crawfish", "tiger", "beetle", "buffalo", "rhino" }
local heartcount = 0
local access = {}
local myaccess = { "seahorse", "hornet", "catfish", "crawfish", "tiger", "beetle", "buffalo", "rhino" }
local heartIcon = nil
local upgrades = {}
local myupgrades = { "legs", "head", "body", "arm", "legs2", "head2", "body2", "arm2", "saber" }
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
		loadImage("./images/Acid"),
		loadImage("./images/Bomb"),
		loadImage("./images/Thunder"),
		loadImage("./images/Blade"),
		loadImage("./images/Ray"),	
		loadImage("./images/Hole"),
		loadImage("./images/Frost"),
		loadImage("./images/Tornado"),
		loadImage("./images/Hyper")
	}
						
	weaponuIcons = {
		loadImage("./images/Acidu"),
		loadImage("./images/Bombu"),
		loadImage("./images/Thunderu"),
		loadImage("./images/Bladeu"),
		loadImage("./images/Rayu"),	
		loadImage("./images/Holeu"),
		loadImage("./images/Frostu"),
		loadImage("./images/Tornadou"),
		loadImage("./images/Hyperu")
	}

	sigmaStageIcons = {
		loadImage("./images/Doppler1"),
		loadImage("./images/Doppler2"),
		loadImage("./images/X3Refights"),
		loadImage("./images/X3Sigma"),
		loadImage("./images/X3Sigmadead")
	}

	etankIcon = loadImage("./images/etank")
	heartIcon = loadImage("./images/heart")

	upgradeIcons = {
		loadImage("./images/X3LegsC"),
		loadImage("./images/X3HelmC"),
		loadImage("./images/X3BodyC"),
		loadImage("./images/X3ArmC"),
		loadImage("./images/X3LegsG"),
		loadImage("./images/X3HelmG"),
		loadImage("./images/X3BodyG"),
		loadImage("./images/X3ArmG"),
		loadImage("./images/X3Saber")
	}
						
	upgradeuIcons = {
		loadImage("./images/X3Legsu"),
		loadImage("./images/X3Helmu"),
		loadImage("./images/X3Bodyu"),
		loadImage("./images/X3Armsu")
	}
	
	ridearmorIcons = {
		loadImage("./images/RAN"),
		loadImage("./images/RAF"),
		loadImage("./images/RAH"),
		loadImage("./images/RAK")
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
	for i = 1, 9 do
		if weapons[myweapons[i]] then
			putImage(i * 16 - 14, 207, weaponIcons[i], 16, 16)
			if i <= 8 then
				weaponCount = weaponCount + 1
			end
		else
			putImage(i * 16 - 14, 207, weaponuIcons[i], 16, 16)
		end
	end
    
	--If we are at final stage stop drawing hearts/subtanks
	if sigmaStage < 3 then
		--Draw hearts unless maxed
		if heartcount < 255 then
			for i = 1, 8 do
				if hearts[myhearts[i]] then
					putImage((i * 16) - 14, 199, heartIcon, 16, 16, 0.9)
				end
			end
		end
		
		--Draw subtanks unless maxed
		if not subtanksall then
			for i = 1, 8 do
				if tanks[mytanks[i]] then
					putImage((i * 16) - 6, 199, etankIcon, 16, 16, 0.9)
				end
			end
		end
	end
	
	--Draw Current Sigma stage unlocked
	if weaponCount == 8 and sigmaStage == 0 then 
		putImage(152, 207, sigmaStageIcons[sigmaStage + 1], 16, 16)
	elseif sigmaStage > 0 then
		putImage(152, 207, sigmaStageIcons[sigmaStage + 1], 16, 16)
	end
	
	--Draw Current Armor Upgrades
	for i = 1, 4 do
		if upgrades[myupgrades[i]] then
			putImage(158 + (i * 16), 207, upgradeIcons[i], 16, 16)
		else
			putImage(158 + (i * 16), 207, upgradeuIcons[i], 16, 16)
		end
	end
	
	--Draw Current Chip Upgrades
	for i = 5, 8 do
		if upgrades[myupgrades[i]] then
			putImage(158 + ((i - 4) * 16), 207, upgradeIcons[i], 16, 16)
		end
	end
	
	--Draw Current Ride Armor parts
	if sigmaStage < 3 then
		-- if not ridefull then 
			for i = 1, 4 do
				if ridearmor[myridearmor[i]] then
					-- putImage(168 + (i * 16), 191, zeroIcons[i], 16, 16)		
					putImage(80 + (i * 16), 0, ridearmorIcons[i], 16, 16)		
				end
			end
		-- end
	end
	
	--Draw Saber upgrade
	if upgrades[myupgrades[9]] then
		putImage(238, 207, upgradeIcons[9], 16, 16)
	end	

	--Draw a box around the selected weapon icon
	if selectedWeapon ~= 0 then
		if is_snes9x then
			gui.box(selectedWeapon * 16 - 13, 208, (selectedWeapon * 16), 221, "#FFFFFF00", "#FFFF00FF")
		else 
			gui.drawBox(selectedWeapon * 16 - 13, 208, (selectedWeapon * 16), 221, "#FFFFFF00")
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
	selectedWeapon = memory.readbyte(adjustAddr(0x7E0A0B)) / 2
	
	--location
	sigmaStage = memory.readbyte(adjustAddr(0x7E1FAF))
	
	--Obtained weapons
	weapons.acid = memory.readbyte(adjustAddr(0x7E1FBC)) > 1
	weapons.bomb = memory.readbyte(adjustAddr(0x7E1FBE)) > 20
	weapons.thunder = memory.readbyte(adjustAddr(0x7E1FC0)) > 20
	weapons.blade = memory.readbyte(adjustAddr(0x7E1FC2)) > 20
	weapons.ray = memory.readbyte(adjustAddr(0x7E1FC4)) > 20
	weapons.hole = memory.readbyte(adjustAddr(0x7E1FC6)) > 20
	weapons.frost = memory.readbyte(adjustAddr(0x7E1FC8)) > 20
	weapons.tornado = memory.readbyte(adjustAddr(0x7E1FCA)) > 20
	weapons.hyper = memory.readbyte(adjustAddr(0x7E1FCC)) >= 64
	
	--Saber
	upgrades.saber = memory.readbyte(adjustAddr(0x7E1FB2)) >= 128
	
	--Armor upgrades and Subtank bitflags
	local mybyte = memory.readbyte(adjustAddr(0x7E1FD1))
	upgrades.head = mybyte % 2 == 1
	upgrades.arm = mybyte % 4 >= 2
	upgrades.body = mybyte % 8 >= 4
	upgrades.legs = mybyte % 16 >= 8
	tanks.buffalo = mybyte % 32 >= 16
	tanks.catfish = mybyte % 64 >= 32
	tanks.rhino = mybyte % 128 >= 64
	tanks.tiger = mybyte % 256 >= 128
	subtanksall = tanks.buffalo and tanks.catfish and tanks.rhino and tanks.tiger
	
	--Ride armor and chips
	local mybyte = memory.readbyte(adjustAddr(0x7E1FD7))
	ridearmor.RAN = mybyte % 2 == 1
	ridearmor.RAK = mybyte % 4 >= 2
	ridearmor.RAH = mybyte % 8 >= 4
	ridearmor.RAF = mybyte % 16 >= 8
	ridefull = ridearmor.RAN and ridearmor.RAK and ridearmor.RAH and ridearmor.RAF
	upgrades.head2 = mybyte % 32 >= 16
	upgrades.arm2 = mybyte % 64 >= 32
	upgrades.body2 = mybyte % 128 >= 64
	upgrades.legs2 = mybyte % 256 >= 128
	
	--Heart bitflags
	mybyte = memory.readbyte(adjustAddr(0x7E1FD4))
	hearts.hornet = mybyte % 2 == 1
	hearts.buffalo = mybyte % 4 >= 2
	hearts.beetle = mybyte % 8 >= 4
	hearts.seahorse = mybyte % 16 >= 8
	hearts.catfish = mybyte % 32 >= 16
	hearts.crawfish = mybyte % 64 >= 32
	hearts.rhino = mybyte % 128 >= 64
	hearts.tiger = mybyte % 256 >= 128
	heartcount = mybyte

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

