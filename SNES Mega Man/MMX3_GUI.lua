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
local myridearmor = { "RAN", "RAK", "RAH", "RAF" }
local ridefull = false
local tanks = {}
local mytanks = { nil, nil,	"catfish", nil, "tiger", nil, "buffalo", "rhino" }
local subtanksall = false
local etankIcon = nil
local hearts = {}
local myhearts = { "seahorse", "hornet", "catfish", "crawfish", "tiger", "beetle", "buffalo", "rhino" }
local heartcount = 0
local heartIcon = nil
local upgrades = {}
local myupgrades = { "legs", "head", "body", "arm", "legs2", "head2", "body2", "arm2", "saber" }
local upgradeIcons = {}					
local upgradeuIcons = {}					
local selectedWeapon = 0
local imagesloaded = false
local sigmaStage = 0
local AP_ROM = false
local mygui = nil
local showWeapons = true
local showSigmaStage = true
local showUpgrades = true
local showHearts = true
local showSubTanks = true
local showRideArmors = true
local showSubTankInfo = false
local showWeaknessInfo = false
local bottomY = 0

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
		loadImage("./images/RAK"),
		loadImage("./images/RAH"),
		loadImage("./images/RAF")
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
	if showWeapons then 
		weaponCount = 0	
		for i = 1, 9 do
			if weapons[myweapons[i]] then
				putImage(i * 16 - 14, 207 + bottomY, weaponIcons[i], 16, 16)
				if i <= 8 then
					weaponCount = weaponCount + 1
				end
			else
				putImage(i * 16 - 14, 207 + bottomY, weaponuIcons[i], 16, 16)
			end
		end
		--Draw a box around the selected weapon icon
		if selectedWeapon ~= 0 then
			if is_snes9x then
				gui.box(selectedWeapon * 16 - 13, 208, (selectedWeapon * 16), 221, "#FFFFFF00", "#FFFF00FF")
			else 
				gui.drawBox(selectedWeapon * 16 - 13, 208 + bottomY, (selectedWeapon * 16), 221 + bottomY, "#FFFFFF00")
			end
		end	
	end
    
	--If we are at final stage stop drawing hearts/subtanks
	if sigmaStage < 3 then
		if showHearts then 
			--Draw hearts unless maxed
			-- if heartcount < 255 then
				for i = 1, 8 do
					if hearts[myhearts[i]] then
						putImage((i * 16) - 14, 199 + bottomY, heartIcon, 16, 16, 0.9)
					end
				end
			-- end
		end
		
		if showSubTanks then
			--Draw subtanks unless maxed
			-- if not subtanksall then
				for i = 1, 8 do
					if tanks[mytanks[i]] then
						putImage((i * 16) - 6, 199 + bottomY, etankIcon, 16, 16, 0.9)
					end
				end
			-- end
		end
	end
	
	if showSigmaStage then
		--Draw Current Sigma stage unlocked
		if weaponCount == 8 and sigmaStage == 0 then 
			putImage(152, 207 + bottomY, sigmaStageIcons[sigmaStage + 1], 16, 16)
		elseif sigmaStage > 0 then
			putImage(152, 207 + bottomY, sigmaStageIcons[sigmaStage + 1], 16, 16)
		end
	end
	
	if showUpgrades then
		--Draw Current Armor Upgrades
		for i = 1, 4 do
			if upgrades[myupgrades[i]] then
				putImage(158 + (i * 16), 207 + bottomY, upgradeIcons[i], 16, 16)
			else
				putImage(158 + (i * 16), 207 + bottomY, upgradeuIcons[i], 16, 16)
			end
		end
	
		--Draw Current Chip Upgrades
		for i = 5, 8 do
			if upgrades[myupgrades[i]] then
				putImage(158 + ((i - 4) * 16), 207 + bottomY, upgradeIcons[i], 16, 16)
			end
		end
		
		--Draw Saber upgrade
		if upgrades[myupgrades[9]] then
			putImage(238, 207 + bottomY, upgradeIcons[9], 16, 16)
		end	
	end
	
	if showRideArmors then 
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
	end
	
	if showSubTankInfo then
		gui.text(10, 0, "Sub Tank1: " .. round(tank1/14 * 100, 0) .. "%")
		gui.text(10, 16, "Sub Tank2: " .. round(tank2/14 * 100, 0) .. "%")
		gui.text(10, 32, "Sub Tank3: " .. round(tank3/14 * 100, 0) .. "%")
		gui.text(10, 48, "Sub Tank4: " .. round(tank4/14 * 100, 0) .. "%")
	end
	
	if showWeaknessInfo then
	
	end
end

--Rounds for us
function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
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
	
	--Subtank Info
	tank1 = memory.readbyte(adjustAddr(0x7E1FB7)) % 16
	tank2 = memory.readbyte(adjustAddr(0x7E1FB8)) % 16
	tank3 = memory.readbyte(adjustAddr(0x7E1FB9)) % 16
	tank4 = memory.readbyte(adjustAddr(0x7E1FBA)) % 16
	
	--Ride armor and chips
	mybyte = memory.readbyte(adjustAddr(0x7E1FD7))
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
	forms.destroyall()
end

function updateOptions()
	showWeapons = forms.ischecked(chkWeapons)
	showSigmaStage = forms.ischecked(chkSigmaStage)
	showUpgrades = forms.ischecked(chkUpgrades)
	showHearts = forms.ischecked(chkHearts)
	showSubTanks = forms.ischecked(chkSubTanks)
	showRideArmors = forms.ischecked(chkRideArmors)
	showSubTankInfo = forms.ischecked(chkSubTankInfo)
	showWeaknessInfo = forms.ischecked(chkWeaknessInfo)
	
	if forms.ischecked(chkGamePad) then
		client.SetGameExtraPadding(0, 16, 0, 16)
		bottomY = 33
	else
		client.SetGameExtraPadding(0, 0, 0, 0)
		bottomY = 0
	end
end

function createOptionsForm()
	mygui = forms.newform(290, 172, "MMX3 GUI Options")
	chkWeapons = forms.checkbox(mygui, "Weapons", 20, 6)
	chkSigmaStage = forms.checkbox(mygui, "Sigma Stage", 20, 26)
	chkUpgrades = forms.checkbox(mygui, "Upgrades", 20, 46)
	chkHearts = forms.checkbox(mygui, "Hearts", 20, 66)
	chkSubTanks = forms.checkbox(mygui, "Sub Tanks", 20, 86)
	chkRideArmors = forms.checkbox(mygui, "Ride Armors", 20, 106)
	chkGamePad = forms.checkbox(mygui, "Outside Game", 140, 6)
	chkSubTankInfo = forms.checkbox(mygui, "Sub Tank Info", 140, 26)
	chkWeaknessInfo = forms.checkbox(mygui, "Weakness Info", 140, 46)
	forms.setproperty(chkWeapons, "Checked", "true")
	forms.setproperty(chkSigmaStage, "Checked", "true")
	forms.setproperty(chkUpgrades, "Checked", "true")
	forms.setproperty(chkHearts, "Checked", "true")
	forms.setproperty(chkSubTanks, "Checked", "true")
	forms.setproperty(chkRideArmors, "Checked", "true")
	forms.setproperty(chkGamePad, "Checked", "true")
	forms.setproperty(chkSubTankInfo, "Checked", "true")
	forms.setproperty(chkWeaknessInfo, "Checked", "true")
	forms.addclick(chkWeapons, updateOptions)
	forms.addclick(chkSigmaStage, updateOptions)
	forms.addclick(chkUpgrades, updateOptions)
	forms.addclick(chkHearts, updateOptions)
	forms.addclick(chkSubTanks, updateOptions)
	forms.addclick(chkRideArmors, updateOptions)
	forms.addclick(chkGamePad, updateOptions)
	forms.addclick(chkSubTankInfo, updateOptions)	
	forms.addclick(chkWeaknessInfo, updateOptions)
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
	createOptionsForm()
	updateOptions()
    while true do
        readValues()
        DrawGUIOverlay()
        emu.frameadvance()
    end
end

