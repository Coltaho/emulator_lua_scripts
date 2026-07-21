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
local showEnemyHealthBar = false
local bottomY = 0
local gamePadding = 0
local xm = (client.screenwidth() - client.borderwidth() * 2) / client.bufferwidth()
local ym = (client.screenheight() - client.borderheight() * 2) / client.bufferheight()
local enemyMaxHP = { }
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
local weakBase = 0x7FEC00
local Weaknesses = {}
local weaknessesloaded = false
local Enemies = {}
Enemies[0] = { Name = "Nothing" }
Enemies[1] = { Name = "Hoganmer" }
Enemies[2] = { Name = "Chill Penguin", weakness1 = 0xA }
Enemies[3] = { Name = "Volt Slime" }
Enemies[4] = { Name = "Flammingle" }
Enemies[5] = { Name = "Boomer Kuwanger", weakness1 = 0x7 }
Enemies[6] = { Name = "Planty" }
Enemies[7] = { Name = "Launch Octopus", weakness1 = 0x9 }
Enemies[8] = { Name = "Launch Octopus Fish Missile" }
Enemies[9] = { Name = "RT-55J", weakness1 = 0xD }
Enemies[10] = { Name = "Sting Chameleon", weakness1 = 0xD }
Enemies[11] = { Name = "Axe Max" }
Enemies[12] = { Name = "Flame Mammoth", weakness1 = 0xB }
Enemies[13] = { Name = "Rush Loader" }
Enemies[14] = { Name = "Flame Mammoth Trunk", Ignore = true }
Enemies[15] = { Name = "Crusher" }
Enemies[16] = { Name = "Sine Faller" }
Enemies[17] = { Name = "Road Attacker" }
Enemies[18] = { Name = "Vehicle", Ignore = true }
Enemies[19] = { Name = "Dodge Blaster" }
Enemies[20] = { Name = "Armored Armadillo", weakness1 = 0xC }
Enemies[21] = { Name = "Spiky" }
Enemies[22] = { Name = "Turn Cannon platform", Ignore = true }
Enemies[23] = { Name = "Turn Cannon" }
Enemies[24] = { Name = "Falling Rock Generator", Ignore = true }
Enemies[25] = { Name = "Bomb Been" }
Enemies[26] = { Name = "Road Attacker Deployer", Ignore = true }
Enemies[27] = { Name = "Road Attacker Spawner", Ignore = true }
Enemies[28] = { Name = "Sea Attacker" }
Enemies[29] = { Name = "Gulpfer" }
Enemies[30] = { Name = "Mad Pecker" }
Enemies[31] = { Name = "Creeper" }
Enemies[32] = { Name = "Amenhopper" }
Enemies[33] = { Name = "Anglerge" }
Enemies[34] = { Name = "Bee Blader" }
Enemies[35] = { Name = "Utuboros Head" }
Enemies[36] = { Name = "Utuboros Body", Ignore = true }
Enemies[37] = { Name = "Utuboros Tail" }
Enemies[38] = { Name = "Velguarder", weakness1 = 0xE }
Enemies[39] = { Name = "Deerball" }
Enemies[40] = { Name = "Cruiziler Object" }
Enemies[41] = { Name = "Gun Volt" }
Enemies[42] = { Name = "Broken Utuboros Head" }
Enemies[43] = { Name = "Minecart platform", Ignore = true }
Enemies[44] = { Name = "Mole Borer" }
Enemies[45] = { Name = "Bat Bone" }
Enemies[46] = { Name = "Met C-15" }
Enemies[47] = { Name = "Ride Armor Soldier" }
Enemies[48] = { Name = "Dig Labour" }
Enemies[49] = { Name = "Spark Mandrill", weakness1 = 0xE }
Enemies[50] = { Name = "Vile in Mech (Intro)" }
Enemies[51] = { Name = "Zero" }
Enemies[52] = { Name = "Crag Man" }
Enemies[53] = { Name = "Metal Wing" }
Enemies[54] = { Name = "Jamminger" }
Enemies[55] = { Name = "Hotarion" }
Enemies[56] = { Name = "Flamer" }
Enemies[57] = { Name = "Conveyor Crusher" }
Enemies[58] = { Name = "Tombot" }
Enemies[59] = { Name = "Ladder Yadder" }
Enemies[60] = { Name = "Dialogue Character Portrait", Ignore = true }
Enemies[61] = { Name = "Tower Elevator platform", Ignore = true }
Enemies[62] = { Name = "Unknown" }
Enemies[63] = { Name = "Slide Cannon platform" }
Enemies[64] = { Name = "Spring", Ignore = true }
Enemies[65] = { Name = "Breakable Glass" }
Enemies[66] = { Name = "Laser", Ignore = true }
Enemies[67] = { Name = "Four-way lasers", Ignore = true }
Enemies[68] = { Name = "Laser Trap", Ignore = true }
Enemies[69] = { Name = "Power Plant Spark Generator", Ignore = true }
Enemies[70] = { Name = "Airport Destructable Wall" }
Enemies[71] = { Name = "Flame Pillar", Ignore = true }
Enemies[72] = { Name = "Death Rogumer platform", Ignore = true }
Enemies[73] = { Name = "Sky Claw" }
Enemies[74] = { Name = "Cruiziler missile explosion", Ignore = true }
Enemies[75] = { Name = "Cruiziler missile" }
Enemies[76] = { Name = "Lava Drip", Ignore = true }
Enemies[77] = { Name = "Light Capsule", Ignore = true }
Enemies[78] = { Name = "Light Capsule lightning strike", Ignore = true }
Enemies[79] = { Name = "Rolling Gabyool" }
Enemies[80] = { Name = "Death Rogumer Cannon" }
Enemies[81] = { Name = "Ray Bit" }
Enemies[82] = { Name = "Storm Eagle", weakness1 = 0x8 }
Enemies[83] = { Name = "Snow Shooter" }
Enemies[84] = { Name = "Snowball" }
Enemies[85] = { Name = "Storm Eagle Eaglet Egg" }
Enemies[86] = { Name = "Storm Eagle Eaglet" }
Enemies[87] = { Name = "Igloo Destructable" }
Enemies[88] = { Name = "Long pillar A", Ignore = true }
Enemies[89] = { Name = "Long pillar B", Ignore = true }
Enemies[90] = { Name = "Long pillar C", Ignore = true }
Enemies[91] = { Name = "Mega Tortoise" }
Enemies[92] = { Name = "Light Portrait", Ignore = true }
Enemies[93] = { Name = "Rangda Bangda", weakness1 = 0x8 }
Enemies[94] = { Name = "Rangda Bangda Eye" }
Enemies[95] = { Name = "Rangda Bangda Mouth" }
Enemies[96] = { Name = "Rangda Bangda Wall", Ignore = true }
Enemies[97] = { Name = "D-Rex", weakness1 = 0xD }
Enemies[98] = { Name = "D-Rex base", Ignore = true }
Enemies[99] = { Name = "BoSpider", weakness1 = 0xE }
Enemies[100] = { Name = "Prison Capsule Destroyer", Ignore = true }
Enemies[101] = { Name = "Sigma", weakness1 = 0xC }
Enemies[102] = { Name = "Zero" }
Enemies[103] = { Name = "Vile in Mech (Sigma Stage 1)", Ignore = true }
Enemies[104] = { Name = "Creeper Hole", Ignore = true }
Enemies[105] = { Name = "Vile", weakness1 = 0x9 }
Enemies[106] = { Name = "Wall Creeper" }
Enemies[107] = { Name = "Final Form Sigma Claw", Ignore = true }

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
	
	Weaknesses[0] = { Name = "Lemon", icon = loadImage("./images/lemon") }
	Weaknesses[1] = { Name = "Charge Shot L1", charged = true, icon = loadImage("./images/lemon") }
	Weaknesses[2] = { Name = "Charge Shot L3", charged = true, icon = loadImage("./images/lemon") }
	Weaknesses[3] = { Name = "Charge Shot L2", charged = true, icon = loadImage("./images/lemon") }
	Weaknesses[4] = { Name = "Hadouken", icon = loadImage("./images/hadouken") }
	Weaknesses[5] = { Name = "???" }
	Weaknesses[6] = { Name = "Dash Lemon", charged = true, icon = loadImage("./images/lemon") }
	Weaknesses[7] = { Name = "Homing Torpedo", icon = loadImage("./images/homing") }
	Weaknesses[8] = { Name = "Chameleon Sting", icon = loadImage("./images/sting") }
	Weaknesses[9] = { Name = "Rolling Shield", icon = loadImage("./images/shield") }
	Weaknesses[10] = { Name = "Fire Wave", icon = loadImage("./images/fire") }
	Weaknesses[11] = { Name = "Storm Tornado", icon = loadImage("./images/storm") }
	Weaknesses[12] = { Name = "Electric Spark", icon = loadImage("./images/spark") }
	Weaknesses[13] = { Name = "Boomerang Cutter", icon = loadImage("./images/cutter") }
	Weaknesses[14] = { Name = "Shotgun Ice", icon = loadImage("./images/ice") }
	Weaknesses[15] = { Name = "???" }
	Weaknesses[16] = { Name = "Charged Homing Torpedo", charged = true, icon = loadImage("./images/homing") }
	Weaknesses[17] = { Name = "Charged Chameleon Sting", charged = true, icon = loadImage("./images/sting") }
	Weaknesses[18] = { Name = "Charged Rolling Shield", charged = true, icon = loadImage("./images/shield") }
	Weaknesses[19] = { Name = "Charged Fire Wave", charged = true, icon = loadImage("./images/fire") }
	Weaknesses[20] = { Name = "Charged Storm Tornado", charged = true, icon = loadImage("./images/storm") }
	Weaknesses[21] = { Name = "Charged Electric Spark", charged = true, icon = loadImage("./images/spark") }
	Weaknesses[22] = { Name = "Charged Boomerang Cutter", charged = true, icon = loadImage("./images/cutter") }
	Weaknesses[23] = { Name = "Charged Shotgun Ice", charged = true, icon = loadImage("./images/ice") }
	Weaknesses[29] = { Name = "Charged Shot L3 Shockwave", charged = true, icon = loadImage("./images/lemon") }
	Weaknesses[255] = { Name = "AP ERROR" }

	imagesloaded = true
end

function loadEnemyInfo()
	if AP_ROM and weaknessesloaded == false then				
		Enemies[10].weakness1 = memory.readbyte(adjustAddr(weakBase)) --Chameleon
		Enemies[10].weakness2 = memory.readbyte(adjustAddr(weakBase + 1))
		Enemies[10].weakness3 = memory.readbyte(adjustAddr(weakBase + 2))
		Enemies[82].weakness1 = memory.readbyte(adjustAddr(weakBase + 0x10)) --Eagle
		Enemies[82].weakness2 = memory.readbyte(adjustAddr(weakBase + 0x10 + 1))
		Enemies[82].weakness3 = memory.readbyte(adjustAddr(weakBase + 0x10 + 2))
		Enemies[12].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x10 * 2))) --Mammoth
		Enemies[12].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x10 * 2) + 1))
		Enemies[12].weakness3 = memory.readbyte(adjustAddr(weakBase + (0x10 * 2) + 2))
		Enemies[2].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x10 * 3))) --Penguin
		Enemies[2].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x10 * 3) + 1))
		Enemies[2].weakness3 = memory.readbyte(adjustAddr(weakBase + (0x10 * 3) + 2))
		Enemies[49].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x10 * 4))) --Mandrill
		Enemies[49].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x10 * 4) + 1))
		Enemies[49].weakness3 = memory.readbyte(adjustAddr(weakBase + (0x10 * 4) + 2))
		Enemies[20].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x10 * 5))) --Armadillo
		Enemies[20].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x10 * 5) + 1))
		Enemies[20].weakness3 = memory.readbyte(adjustAddr(weakBase + (0x10 * 5) + 2))
		Enemies[7].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x10 * 6))) --Octopus
		Enemies[7].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x10 * 6) + 1))
		Enemies[7].weakness3 = memory.readbyte(adjustAddr(weakBase + (0x10 * 6) + 2))
		Enemies[5].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x10 * 7))) --Kuwanger
		Enemies[5].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x10 * 7) + 1))
		Enemies[5].weakness3 = memory.readbyte(adjustAddr(weakBase + (0x10 * 7) + 2))
		Enemies[3].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x10 * 8))) --Thunder Slimer
		Enemies[3].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x10 * 8) + 1))
		Enemies[3].weakness3 = memory.readbyte(adjustAddr(weakBase + (0x10 * 8) + 2))
		Enemies[105].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x10 * 9))) --Vile
		Enemies[105].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x10 * 9) + 1))
		Enemies[105].weakness3 = memory.readbyte(adjustAddr(weakBase + (0x10 * 9) + 2))
		Enemies[99].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x10 * 10))) --Bospider
		Enemies[99].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x10 * 10) + 1))
		Enemies[99].weakness3 = memory.readbyte(adjustAddr(weakBase + (0x10 * 10) + 2))
		Enemies[93].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x10 * 11))) --Rangda Total Health
		Enemies[93].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x10 * 11) + 1))
		Enemies[93].weakness3 = memory.readbyte(adjustAddr(weakBase + (0x10 * 11) + 2))
		Enemies[97].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x10 * 12))) --D-Rex
		Enemies[97].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x10 * 12) + 1))
		Enemies[97].weakness3 = memory.readbyte(adjustAddr(weakBase + (0x10 * 12) + 2))
		Enemies[38].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x10 * 13))) --Velguarder
		Enemies[38].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x10 * 13) + 1))
		Enemies[38].weakness3 = memory.readbyte(adjustAddr(weakBase + (0x10 * 13) + 2))
		Enemies[101].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x10 * 14))) --Sigma
		Enemies[101].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x10 * 14) + 1))
		Enemies[101].weakness3 = memory.readbyte(adjustAddr(weakBase + (0x10 * 14) + 2))
		print("Weaknesses Loaded for AP Rom!")
		weaknessesloaded = true
	end
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
	--Draw enemy healthbars and/names
	if showEnemyHealthBar or showEnemyNames then
		for i = 0, 13, 1 do
			if enemySlots[i] and (enemySlots[i].Active == 1 or enemySlots[i].Active == 0xFF) and not Enemies[enemySlots[i].ID].Ignore then
				if showEnemyNames then
					gui.text((gamePadding + enemySlots[i].X - 9.5) * xm, (gamePadding + enemySlots[i].Y - 23.5) * ym, Enemies[enemySlots[i].ID].Name)
				end
				if showEnemyHealthBar then
					if enemySlots[i].CurrentHP > 0 and enemySlots[i].CurrentHP < 127 then
						gui.text((gamePadding + enemySlots[i].X - 2.5) * xm, (gamePadding + enemySlots[i].Y - 19) * ym, enemySlots[i].CurrentHP .. "/" .. (enemySlots[i].MaxHP or "?"))
						gui.drawRectangle(gamePadding + enemySlots[i].X - 10, gamePadding + enemySlots[i].Y - 20, 20, 4, "black", "white")
						gui.drawRectangle(gamePadding + enemySlots[i].X - 9, gamePadding + enemySlots[i].Y - 19, 18 * (enemySlots[i].CurrentHP / (enemySlots[i].MaxHP or 32)), 2, "red", "red")
					else
						gui.text((gamePadding + enemySlots[i].X - 2.5) * xm, (gamePadding + enemySlots[i].Y - 19) * ym, "-/-")
						gui.drawRectangle(gamePadding + enemySlots[i].X - 10, gamePadding + enemySlots[i].Y - 20, 20, 4, "black", "white")
					end
				end
			end
		end
	end
	
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
				if enemySlots[i].Active == 1 or enemySlots[i].Active == 0xFF then
					if Enemies[enemySlots[i].ID] and Enemies[enemySlots[i].ID].Name and Enemies[enemySlots[i].ID].weakness1 then
						gui.text(10, y, "Enemy: " .. Enemies[enemySlots[i].ID].Name .. " HP: " .. enemySlots[i].CurrentHP .. " WEAKNESS1: " .. Weaknesses[Enemies[enemySlots[i].ID].weakness1].Name, nil, "topright")
						if Enemies[enemySlots[i].ID].weakness2 then
							y = y + 16
							gui.text(10, y, "WEAKNESS2: " .. Weaknesses[Enemies[enemySlots[i].ID].weakness2].Name, nil, "topright")
						end
						if Enemies[enemySlots[i].ID].weakness3 and Enemies[enemySlots[i].ID].weakness3 < 0xFF then
							y = y + 16
							gui.text(10, y, "WEAKNESS3: " .. Weaknesses[Enemies[enemySlots[i].ID].weakness3].Name, nil, "topright")
						end
						if paused and enemySlots[i].CurrentHP > 0 and Weaknesses[Enemies[enemySlots[i].ID].weakness1].icon then
							putImage(gamePadding + 232, 96 + gamePadding, Weaknesses[Enemies[enemySlots[i].ID].weakness1].icon, 16, 16)
							if Weaknesses[Enemies[enemySlots[i].ID].weakness1].charged == true then
								if is_snes9x then
									gui.box(246, 113, 233, 126, "#FFFFFF00", "#FFFF00FF")
								else 
									gui.drawBox(gamePadding + 246, 97 + gamePadding, 249, 126, "green")
								end
							end	
							if Weaknesses[Enemies[enemySlots[i].ID].weakness2] and Weaknesses[Enemies[enemySlots[i].ID].weakness2].icon then
								putImage(gamePadding + 232, 112 + gamePadding, Weaknesses[Enemies[enemySlots[i].ID].weakness2].icon, 16, 16)
								if Weaknesses[Enemies[enemySlots[i].ID].weakness2].charged == true then
									if is_snes9x then
										gui.box(246, 129, 233, 142, "#FFFFFF00", "#FFFF00FF")
									else 
										gui.drawBox(gamePadding + 246, 113 + gamePadding, 249, 142, "green")
									end
								end
							end	
							if Weaknesses[Enemies[enemySlots[i].ID].weakness3] and Weaknesses[Enemies[enemySlots[i].ID].weakness3].icon then
								putImage(gamePadding + 232, 128 + gamePadding, Weaknesses[Enemies[enemySlots[i].ID].weakness3].icon, 16, 16)
								if Weaknesses[Enemies[enemySlots[i].ID].weakness3].charged == true then
									if is_snes9x then
										gui.box(246, 145, 233, 158, "#FFFFFF00", "#FFFF00FF")
									else 
										gui.drawBox(gamePadding + 246, 129 + gamePadding, 249, 158, "green")
									end
								end
							end	
						end
						y = y + 16
					else
						-- gui.text(10, y, "Enemy: " .. Enemies[enemySlots[i].ID].Name .. " HP: " .. enemySlots[i].CurrentHP, nil, "topright")
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
	
	paused = memory.readbyte(adjustAddr(0x7E00C9)) == 0 or memory.readbyte(adjustAddr(0x7E00C9)) == 2
	
	if showWeaknessInfo or showEnemyHealthBar or showEnemyNames then
		loadEnemyInfo()
		readEnemySlots()
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
	showEnemyHealthBar = forms.ischecked(chkEnemyHealthBar)
	showEnemyNames = forms.ischecked(chkEnemyNames)
	
	if forms.ischecked(chkgamePadding) then
		client.SetGameExtraPadding(16, 16, 16, 16)
		bottomY = 33
		gamePadding = 16
	else
		client.SetGameExtraPadding(0, 0, 0, 0)
		client.SetClientExtraPadding(0, 0, 0, 0)
		bottomY = 0
		gamePadding = 0
	end
end

function createOptionsForm()
	mygui = forms.newform(290, 172, "MMX1 GUI Options")
	chkWeapons = forms.checkbox(mygui, "Weapons", 20, 6)
	chkSigmaStage = forms.checkbox(mygui, "Sigma Stage", 20, 26)
	chkUpgrades = forms.checkbox(mygui, "Upgrades", 20, 46)
	chkHearts = forms.checkbox(mygui, "Hearts", 20, 66)
	chkSubTanks = forms.checkbox(mygui, "Sub Tanks", 20, 86)
	chkgamePadding = forms.checkbox(mygui, "Outside Game", 140, 6)
	chkSubTankInfo = forms.checkbox(mygui, "Sub Tank Info", 140, 26)
	chkWeaknessInfo = forms.checkbox(mygui, "Weakness Info", 140, 46)
	chkEnemyHealthBar = forms.checkbox(mygui, "Enemy Health", 140, 66)
	chkEnemyNames = forms.checkbox(mygui, "Enemy Names", 140, 86)
	forms.setproperty(chkWeapons, "Checked", "true")
	forms.setproperty(chkSigmaStage, "Checked", "true")
	forms.setproperty(chkUpgrades, "Checked", "true")
	forms.setproperty(chkHearts, "Checked", "true")
	forms.setproperty(chkSubTanks, "Checked", "true")
	forms.setproperty(chkgamePadding, "Checked", "true")
	forms.setproperty(chkSubTankInfo, "Checked", "true")
	forms.setproperty(chkWeaknessInfo, "Checked", "true")
	forms.setproperty(chkEnemyHealthBar, "Checked", "true")
	forms.setproperty(chkEnemyNames, "Checked", "true")
	forms.addclick(chkWeapons, updateOptions)
	forms.addclick(chkSigmaStage, updateOptions)
	forms.addclick(chkUpgrades, updateOptions)
	forms.addclick(chkHearts, updateOptions)
	forms.addclick(chkSubTanks, updateOptions)
	forms.addclick(chkgamePadding, updateOptions)
	forms.addclick(chkSubTankInfo, updateOptions)
	forms.addclick(chkWeaknessInfo, updateOptions)
	forms.addclick(chkEnemyHealthBar, updateOptions)
	forms.addclick(chkEnemyNames, updateOptions)
end

function readEnemySlots()
	local base
	local camx = mainmemory.read_u16_le(0x00B4)
	local camy = mainmemory.read_u16_le(0x00B6)
	xm = (client.screenwidth() - client.borderwidth() * 2) / client.bufferwidth()
	ym = (client.screenheight() - client.borderheight() * 2) / client.bufferheight()
	local finalSigma = false
	for i = 0, 13, 1 do		
		base = 0xE68 + (i * 0x40)
		
		enemySlots[i].Active = memory.readbyte(adjustAddr(0x7E0000 + base))
		enemySlots[i].ID = memory.readbyte(adjustAddr(0x7E0000 + base + 0xA))
		enemySlots[i].CurrentHP = memory.readbyte(adjustAddr(0x7E0000 + base + 0x27))
		enemySlots[i].X = mainmemory.read_u16_le(base + 5) - camx
		enemySlots[i].Y = mainmemory.read_u16_le(base + 8) - camy
		
		--Jedi died, set Sigma MaxHP to 0
		if enemySlots[i].ID == 101 and enemySlots[i].OldActive == 1 and enemySlots[i].Active == 0xFF then			
			enemySlots[i].MaxHP = 0 
		end
		--Sigma claws exist, must be Wolf Sigma
		if enemySlots[1].ID == 107 then
			finalSigma = true			
			enemySlots[0].Y = 42 --override Wolf Sigma Y position
		end
		
		if enemySlots[i].CheckMaxHP and enemySlots[i].CurrentHP < 127 then
			enemySlots[i].MaxHP = enemySlots[i].CurrentHP
			enemySlots[i].CheckMaxHP = nil
			-- print("[" .. i .. "][" .. string.format("%X", base) .. "] Became Active - MaxHP Assigned : " .. enemySlots[i].MaxHP .. " | " .. enemySlots[i].ID .. "-" .. Enemies[enemySlots[i].ID].Name)
		end
		
		--updates MaxHP if it increases like for boss intro, will make Octo wrong if he sucks
		if (enemySlots[i].Active == 1 or enemySlots[i].Active == 0xFF) and enemySlots[i].MaxHP and enemySlots[i].CurrentHP > enemySlots[i].MaxHP and enemySlots[i].CurrentHP < 127 then 
			-- print("[" .. i .. "][" .. string.format("%X", base) .. "] HP increased! " .. enemySlots[i].MaxHP .. " -> " .. enemySlots[i].CurrentHP .. " | " .. enemySlots[i].ID .. "-" .. Enemies[enemySlots[i].ID].Name)
			enemySlots[i].MaxHP = enemySlots[i].CurrentHP
		end
		
		if enemySlots[i].OldActive == 0 and enemySlots[i].Active == 1 then
			enemySlots[i].CheckMaxHP = true
		end
		
		enemySlots[i].OldActive = enemySlots[i].Active
		enemySlots[i].OldHP = enemySlots[i].CurrentHP
	end
	
	if finalSigma == true then
		if AP_ROM then
			Enemies[101].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x10 * 15))) --Wolf Sigma
			Enemies[101].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x10 * 15) + 1))
			Enemies[101].weakness3 = memory.readbyte(adjustAddr(weakBase + (0x10 * 15) + 2))
		else
			Enemies[101].weakness1 = 0x9
		end
	else
		if AP_ROM then
			Enemies[101].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x10 * 14))) --Jedi Sigma
			Enemies[101].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x10 * 14) + 1))
			Enemies[101].weakness3 = memory.readbyte(adjustAddr(weakBase + (0x10 * 14) + 2))
		else
			Enemies[101].weakness1 = 0xC
		end
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
	memory.usememorydomain("WRAM")
	print ("Checking for AP ROM at: " .. string.format("%X", adjustAddr(weakBase)) .. " - 0x" .. string.format("%X", memory.readbyte(adjustAddr(weakBase))))
	if memory.readbyte(adjustAddr(weakBase)) ~= 0x50 then
		AP_ROM = true
		print ("AP ROM Found! at: " .. string.format("%X", adjustAddr(weakBase)) .. " - 0x" .. string.format("%X", memory.readbyte(adjustAddr(weakBase))))
	end	
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

