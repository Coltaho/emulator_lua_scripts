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
local heartcount = 0
local heartIcon = nil
local upgrades = {}
local myupgrades = { "legs", "head", "body", "arm", "hado" }
local upgradeIcons = {}					
local upgradeuIcons = {}					
local selectedWeapon = 0
local imagesloaded = false
local sigmaStage = 0
local paused = false
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
local enemySlots = { }
enemySlots[0] = { }
enemySlots[1] = { }
enemySlots[2] = { }
enemySlots[3] = { }
enemySlots[4] = { }
enemySlots[5] = { }
enemySlots[6] = { }
enemySlots[7] = { }
enemySlots[8] = { }
enemySlots[9] = { }
enemySlots[10] = { }
enemySlots[11] = { }
enemySlots[12] = { }
enemySlots[13] = { }
local Weaknesses = {}
local weaknessesloaded = false
local Enemies = {}
Enemies[0] = { name = "Nothing" }
Enemies[1] = { name = "Hoganmer" }
Enemies[2] = { name = "Chill Penguin", weakness1 = 0xA }
Enemies[3] = { name = "Volt Slime" }
Enemies[4] = { name = "Flammingle" }
Enemies[5] = { name = "Boomer Kuwanger", weakness1 = 0x7 }
Enemies[6] = { name = "Planty" }
Enemies[7] = { name = "Launch Octopus", weakness1 = 0x9 }
Enemies[8] = { name = "Launch Octopus Fish Missile" }
Enemies[9] = { name = "RT-55J", weakness1 = 0xD }
Enemies[10] = { name = "Sting Chameleon", weakness1 = 0xD }
Enemies[11] = { name = "Axe Max" }
Enemies[12] = { name = "Flame Mammoth", weakness1 = 0xB }
Enemies[13] = { name = "Rush Loader" }
Enemies[14] = { name = "Flame Mammoth Trunk" }
Enemies[15] = { name = "Crusher" }
Enemies[16] = { name = "Sine Faller" }
Enemies[17] = { name = "Road Attacker" }
Enemies[18] = { name = "???" }
Enemies[19] = { name = "Dodge Blaster" }
Enemies[20] = { name = "Armored Armadillo", weakness1 = 0xC }
Enemies[21] = { name = "Spiky" }
Enemies[22] = { name = "Turn Cannon's floating platform" }
Enemies[23] = { name = "Turn Cannon" }
Enemies[24] = { name = "Falling rock generator" }
Enemies[25] = { name = "Bomb Been" }
Enemies[26] = { name = "Road Attacker deployer" }
Enemies[27] = { name = "Unknown" }
Enemies[28] = { name = "Sea Attacker" }
Enemies[29] = { name = "Gulpfer" }
Enemies[30] = { name = "Mad Pecker" }
Enemies[31] = { name = "Creeper" }
Enemies[32] = { name = "Amenhopper" }
Enemies[33] = { name = "Anglerge" }
Enemies[34] = { name = "Bee Blader" }
Enemies[35] = { name = "Utuboros head" }
Enemies[36] = { name = "Utuboros body section" }
Enemies[37] = { name = "Utuboros tail" }
Enemies[38] = { name = "Velguarder", weakness1 = 0xE }
Enemies[39] = { name = "Deerball" }
Enemies[40] = { name = "Cruiziler Object" }
Enemies[41] = { name = "Gun Volt" }
Enemies[42] = { name = "Broken Utuboros head scrap Robo" }
Enemies[43] = { name = "Mine cart platform" }
Enemies[44] = { name = "Mole Borer" }
Enemies[45] = { name = "Bat Bone Batton M-501" }
Enemies[46] = { name = "Met C-15" }
Enemies[47] = { name = "Ride Armor Armor Soldier" }
Enemies[48] = { name = "Dig Labour" }
Enemies[49] = { name = "Spark Mandrill", weakness1 = 0xE }
Enemies[50] = { name = "Vile in Mech (Intro)" }
Enemies[51] = { name = "Zero" }
Enemies[52] = { name = "Crag Man" }
Enemies[53] = { name = "Metal Wing" }
Enemies[54] = { name = "Jamminger" }
Enemies[55] = { name = "Hotarion" }
Enemies[56] = { name = "Flamer floating platform" }
Enemies[57] = { name = "Conveyor belt crusher" }
Enemies[58] = { name = "Tombot" }
Enemies[59] = { name = "Ladder Yadder" }
Enemies[60] = { name = "Dialogue character picture" }
Enemies[61] = { name = "Tower elevator platform" }
Enemies[62] = { name = "Unknown" }
Enemies[63] = { name = "Slide Cannon sliding platform" }
Enemies[64] = { name = "Spring" }
Enemies[65] = { name = "Breakable glass object" }
Enemies[66] = { name = "Laser" }
Enemies[67] = { name = "Four-way lasers" }
Enemies[68] = { name = "Laser trap" }
Enemies[69] = { name = "Power plant spark generator" }
Enemies[70] = { name = "Airport destructable wall object" }
Enemies[71] = { name = "Flame Pillar" }
Enemies[72] = { name = "Death Rogumer platform" }
Enemies[73] = { name = "Sky Claw" }
Enemies[74] = { name = "Cruiziler missile explosion" }
Enemies[75] = { name = "Cruiziler missile" }
Enemies[76] = { name = "Lava Drip" }
Enemies[77] = { name = "Light Capsule" }
Enemies[78] = { name = "Light Capsule lightning strike" }
Enemies[79] = { name = "Rolling Gabyool" }
Enemies[80] = { name = "Death Rogumer cannon" }
Enemies[81] = { name = "Ray Bit" }
Enemies[82] = { name = "Storm Eagle", weakness1 = 0x8 }
Enemies[83] = { name = "Snow Shooter" }
Enemies[84] = { name = "Snowball" }
Enemies[85] = { name = "Storm Eagle eaglet egg" }
Enemies[86] = { name = "Storm Eagle eaglet" }
Enemies[87] = { name = "Igloo destructable object" }
Enemies[88] = { name = "Unknown" }
Enemies[89] = { name = "Long pillar" }
Enemies[90] = { name = "Unknown" }
Enemies[91] = { name = "Mega Tortoise" }
Enemies[92] = { name = "Light Portrait" }
Enemies[93] = { name = "Rangda Bangda", weakness1 = 0x8 }
Enemies[94] = { name = "Rangda Bangda eye" }
Enemies[95] = { name = "Rangda Bangda mouth" }
Enemies[96] = { name = "Rangda Bangda wall sides" }
Enemies[97] = { name = "D-Rex", weakness1 = 0xD }
Enemies[98] = { name = "D-Rex base" }
Enemies[99] = { name = "BoSpider", weakness1 = 0xE }
Enemies[100] = { name = "Prison capsule destroyer" }
Enemies[101] = { name = "Sigma", weakness1 = 0xC }
Enemies[102] = { name = "Zero Sigma stage" }
Enemies[103] = { name = "Vile in Mech (Sigma Stage 1)" }
Enemies[104] = { name = "Creeper hole" }
Enemies[105] = { name = "Vile", weakness1 = 0x9 }
Enemies[106] = { name = "Wall Creeper" }
Enemies[107] = { name = "Final Form Sigma Claw" }

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
	
	Weaknesses[0] = { name = "Lemon", icon = loadImage("./images/lemon") }
	Weaknesses[1] = { name = "Charge Shot L1", charged = true, icon = loadImage("./images/lemon") }
	Weaknesses[2] = { name = "Charge Shot L3", charged = true, icon = loadImage("./images/lemon") }
	Weaknesses[3] = { name = "Charge Shot L2", charged = true, icon = loadImage("./images/lemon") }
	Weaknesses[4] = { name = "Hadouken", icon = loadImage("./images/hadouken") }
	Weaknesses[5] = { name = "???" }
	Weaknesses[6] = { name = "Dash Lemon", charged = true, icon = loadImage("./images/lemon") }
	Weaknesses[7] = { name = "Homing Torpedo", icon = loadImage("./images/homing") }
	Weaknesses[8] = { name = "Chameleon Sting", icon = loadImage("./images/sting") }
	Weaknesses[9] = { name = "Rolling Shield", icon = loadImage("./images/shield") }
	Weaknesses[10] = { name = "Fire Wave", icon = loadImage("./images/fire") }
	Weaknesses[11] = { name = "Storm Tornado", icon = loadImage("./images/storm") }
	Weaknesses[12] = { name = "Electric Spark", icon = loadImage("./images/spark") }
	Weaknesses[13] = { name = "Boomerang Cutter", icon = loadImage("./images/cutter") }
	Weaknesses[14] = { name = "Shotgun Ice", icon = loadImage("./images/ice") }
	Weaknesses[15] = { name = "???" }
	Weaknesses[16] = { name = "Charged Homing Torpedo", charged = true, icon = loadImage("./images/homing") }
	Weaknesses[17] = { name = "Charged Chameleon Sting", charged = true, icon = loadImage("./images/sting") }
	Weaknesses[18] = { name = "Charged Rolling Shield", charged = true, icon = loadImage("./images/shield") }
	Weaknesses[19] = { name = "Charged Fire Wave", charged = true, icon = loadImage("./images/fire") }
	Weaknesses[20] = { name = "Charged Storm Tornado", charged = true, icon = loadImage("./images/storm") }
	Weaknesses[21] = { name = "Charged Electric Spark", charged = true, icon = loadImage("./images/spark") }
	Weaknesses[22] = { name = "Charged Boomerang Cutter", charged = true, icon = loadImage("./images/cutter") }
	Weaknesses[23] = { name = "Charged Shotgun Ice", charged = true, icon = loadImage("./images/ice") }
	Weaknesses[29] = { name = "Charged Shot L3 Shockwave", charged = true, icon = loadImage("./images/lemon") }

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
		local weaponCount = 0	
		for i = 1, 8 do
			if weapons[myweapons[i]] then
				putImage(i * 16, 207 + bottomY, weaponIcons[i], 16, 16)
				weaponCount = weaponCount + 1
			else
				putImage(i * 16, 207 + bottomY, weaponuIcons[i], 16, 16)
			end
		end
		--Draw a box around the selected weapon icon
		if selectedWeapon ~= 0 then
			if is_snes9x then
				gui.box(selectedWeapon * 16 + 1, 208, (selectedWeapon * 16) + 14, 221, "#FFFFFF00", "#FFFF00FF")
			else 
				gui.drawBox(selectedWeapon * 16 + 1, 208 + bottomY, (selectedWeapon * 16) + 14, 221 + bottomY, "yellow")
			end
		end	
	end
    
	--If are at final Sigma stage, stop drawing hearts/subtanks
	if sigmaStage < 3 then
		if showHearts then 
			--Draw hearts  
			for i = 1, 8 do
				if hearts[myhearts[i]] then
					putImage((i * 16), 199 + bottomY, heartIcon, 16, 16, 0.9)
				end
			end
		end
			
		if showSubTanks then
			--Draw subtanks
			for i = 1, 8 do
				if tanks[mytanks[i]] then
					putImage((i * 16) + 8, 199 + bottomY, etankIcon, 16, 16, 0.9)
				end
			end
		end
	end

	if showSigmaStage then
		--Draw Current Sigma stage unlocked
		if weaponCount == 8 and sigmaStage == 0 then 
			putImage(146, 207 + bottomY, sigmaStageIcons[sigmaStage + 1], 16, 16)
		elseif sigmaStage > 0 then
			putImage(146, 207 + bottomY, sigmaStageIcons[sigmaStage + 1], 16, 16)
		end
	end
	
	if showUpgrades then
		--Draw Current Armor Upgrades
		for i = 1, 4 do
			if upgrades[myupgrades[i]] then
				putImage(148 + (i * 16), 207 + bottomY, upgradeIcons[i], 16, 16)
			else
				putImage(148 + (i * 16), 207 + bottomY, upgradeuIcons[i], 16, 16)
			end
		end
		
		--Draw Hado upgrade over helmet if we have it
		if upgrades[myupgrades[5]] then
			putImage(180, 207 + bottomY, upgradeIcons[5], 16, 16)
		end	
	end	
	
	if showSubTankInfo then
		gui.text(10, 0, "Sub Tank1: " .. round(tank1/14 * 100, 0) .. "%")
		gui.text(10, 16, "Sub Tank2: " .. round(tank2/14 * 100, 0) .. "%")
		gui.text(10, 32, "Sub Tank3: " .. round(tank3/14 * 100, 0) .. "%")
		gui.text(10, 48, "Sub Tank4: " .. round(tank4/14 * 100, 0) .. "%")
	end
	
	if showWeaknessInfo then
		local y = 0;
		for i = 0, 13, 1 do
			if enemySlots[i] then
				if enemySlots[i].onscreen == 1 or enemySlots[i].onscreen == 0xFF then
					if Enemies[enemySlots[i].ID] and Enemies[enemySlots[i].ID].name and Enemies[enemySlots[i].ID].weakness1 then
						gui.text(10, y, "Enemy: " .. Enemies[enemySlots[i].ID].name .. " HP: " .. enemySlots[i].CurrentHP .. " WEAKNESS1: " .. Weaknesses[Enemies[enemySlots[i].ID].weakness1].name, nil, "topright")
						if Enemies[enemySlots[i].ID].weakness2 then
							y = y + 16
							gui.text(10, y, "WEAKNESS2: " .. Weaknesses[Enemies[enemySlots[i].ID].weakness2].name, nil, "topright")
						end
						if unpaused and enemySlots[i].CurrentHP > 0 and Weaknesses[Enemies[enemySlots[i].ID].weakness1].icon then
							putImage(232, 112, Weaknesses[Enemies[enemySlots[i].ID].weakness1].icon, 16, 16)
							if Weaknesses[Enemies[enemySlots[i].ID].weakness1].charged == true then
								if is_snes9x then
									gui.box(246, 113, 233, 126, "#FFFFFF00", "#FFFF00FF")
								else 
									gui.drawBox(246, 113, 233, 126, "green")
								end
							end	
							if Weaknesses[Enemies[enemySlots[i].ID].weakness2] and Weaknesses[Enemies[enemySlots[i].ID].weakness2].icon then
								putImage(232, 128, Weaknesses[Enemies[enemySlots[i].ID].weakness2].icon, 16, 16)
								if Weaknesses[Enemies[enemySlots[i].ID].weakness2].charged == true then
									if is_snes9x then
										gui.box(246, 129, 233, 142, "#FFFFFF00", "#FFFF00FF")
									else 
										gui.drawBox(246, 129, 233, 142, "green")
									end
								end
							end	
						end
						y = y + 16
					else
						-- gui.text(10, y, "Enemy: " .. Enemies[enemySlots[i].ID].name .. " HP: " .. enemySlots[i].CurrentHP, nil, "topright")
						-- y = y + 16
					end										
				end
			end
		end
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
	
	--Subtank Info
	tank1 = memory.readbyte(adjustAddr(0x7E1F83)) % 16
	tank2 = memory.readbyte(adjustAddr(0x7E1F84)) % 16
	tank3 = memory.readbyte(adjustAddr(0x7E1F85)) % 16
	tank4 = memory.readbyte(adjustAddr(0x7E1F86)) % 16
	
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
	
	unpaused = memory.readbyte(adjustAddr(0x7E00C9)) == 0 or memory.readbyte(adjustAddr(0x7E00C9)) == 2
	
	if showWeaknessInfo then
		enemies()
	end
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
	mygui = forms.newform(290, 172, "MMX1 GUI Options")
	chkWeapons = forms.checkbox(mygui, "Weapons", 20, 6)
	chkSigmaStage = forms.checkbox(mygui, "Sigma Stage", 20, 26)
	chkUpgrades = forms.checkbox(mygui, "Upgrades", 20, 46)
	chkHearts = forms.checkbox(mygui, "Hearts", 20, 66)
	chkSubTanks = forms.checkbox(mygui, "Sub Tanks", 20, 86)
	chkGamePad = forms.checkbox(mygui, "Outside Game", 140, 6)
	chkSubTankInfo = forms.checkbox(mygui, "Sub Tank Info", 140, 26)
	chkWeaknessInfo = forms.checkbox(mygui, "Weakness Info", 140, 46)
	forms.setproperty(chkWeapons, "Checked", "true")
	forms.setproperty(chkSigmaStage, "Checked", "true")
	forms.setproperty(chkUpgrades, "Checked", "true")
	forms.setproperty(chkHearts, "Checked", "true")
	forms.setproperty(chkSubTanks, "Checked", "true")
	forms.setproperty(chkGamePad, "Checked", "true")
	forms.setproperty(chkSubTankInfo, "Checked", "true")
	forms.setproperty(chkWeaknessInfo, "Checked", "true")
	forms.addclick(chkWeapons, updateOptions)
	forms.addclick(chkSigmaStage, updateOptions)
	forms.addclick(chkUpgrades, updateOptions)
	forms.addclick(chkHearts, updateOptions)
	forms.addclick(chkSubTanks, updateOptions)
	forms.addclick(chkGamePad, updateOptions)
	forms.addclick(chkSubTankInfo, updateOptions)
	forms.addclick(chkWeaknessInfo, updateOptions)
end

function enemies()
	local base
	local weakBase = 0x7FED00
	local start = 0xE68	
	local finalSigma = false
	for i = 0, 13 , 1 do		
		base = start + (i * 0x40)		
		if i == 0 then
			base = start
		end
		
		enemySlots[i].onscreen = memory.readbyte(adjustAddr(0x7E0000 + base))
		enemySlots[i].ID = memory.readbyte(adjustAddr(0x7E0000 + base + 0xA))
		-- enemySlots[i].SubID = memory.readbyte(adjustAddr(0x7E0000 + base + 0xB))
		enemySlots[i].CurrentHP = memory.readbyte(adjustAddr(0x7E0000 + base + 0x27))
		
		if enemySlots[i].ID == 107 then
			finalSigma = true
		end
	end
	
	if finalSigma == true then
		if AP_ROM then
			Enemies[101].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x8 * 15))) --Wolf Sigma
			Enemies[101].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x8 * 15) + 1))
		else
			Enemies[101].weakness1 = 0x9
		end
	else
		if AP_ROM then
			Enemies[101].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x8 * 14))) --Jedi Sigma
			Enemies[101].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x8 * 14) + 1))
		else
			Enemies[101].weakness1 = 0xC
		end
	end
	
	if AP_ROM and not weaknessesloaded then		
		Enemies[10].weakness1 = memory.readbyte(adjustAddr(weakBase)) --Chameleon
		Enemies[10].weakness2 = memory.readbyte(adjustAddr(weakBase + 1))
		Enemies[82].weakness1 = memory.readbyte(adjustAddr(weakBase + 0x8)) --Eagle
		Enemies[82].weakness2 = memory.readbyte(adjustAddr(weakBase + 0x8 + 1))
		Enemies[12].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x8 * 2))) --Mammoth
		Enemies[12].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x8 * 2) + 1))
		Enemies[2].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x8 * 3))) --Penguin
		Enemies[2].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x8 * 3) + 1))
		Enemies[49].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x8 * 4))) --Mandrill
		Enemies[49].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x8 * 4) + 1))
		Enemies[20].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x8 * 5))) --Armadillo
		Enemies[20].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x8 * 5) + 1))
		Enemies[7].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x8 * 6))) --Octopus
		Enemies[7].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x8 * 6) + 1))
		Enemies[5].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x8 * 7))) --Kuwanger
		Enemies[5].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x8 * 7) + 1))
		Enemies[3].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x8 * 8))) --Thunder Slimer
		Enemies[3].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x8 * 8) + 1))
		Enemies[105].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x8 * 9))) --Vile
		Enemies[105].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x8 * 9) + 1))
		Enemies[99].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x8 * 10))) --Bospider
		Enemies[99].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x8 * 10) + 1))
		Enemies[93].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x8 * 11))) --Rangda Total Health
		Enemies[93].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x8 * 11) + 1))
		Enemies[97].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x8 * 12))) --D-Rex
		Enemies[97].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x8 * 12) + 1))
		Enemies[38].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x8 * 13))) --Velguarder
		Enemies[38].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x8 * 13) + 1))
		Enemies[101].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x8 * 14))) --Sigma
		Enemies[101].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x8 * 14) + 1))
		weaknessesloaded = true
	end
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

