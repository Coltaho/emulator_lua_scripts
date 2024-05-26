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
local ridearmorall = false
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
Enemies[0] = { name = "Weapon Get cutscene" }
Enemies[1] = { name = "???" }
Enemies[2] = { name = "What?" }
Enemies[3] = { name = "Blady" }
Enemies[4] = { name = "Boss Defeated Obj" }
Enemies[5] = { name = "Elevating Platform" }
Enemies[6] = { name = "Earth Commander" }
Enemies[7] = { name = "Title Screen 3" }
Enemies[8] = { name = "Notor Banger" }
Enemies[9] = { name = "Escanail" }
Enemies[10] = { name = "Carry Arm" }
Enemies[11] = { name = "Caterkiller" }
Enemies[12] = { name = "Drimole-W" }
Enemies[13] = { name = "Helit" }
Enemies[14] = { name = "Wall Cancer" }
Enemies[15] = { name = "Carry Arm start?" }
Enemies[16] = { name = "???" }
Enemies[17] = { name = "Crablaster" }
Enemies[18] = { name = "Destructable Ice Block" }
Enemies[19] = { name = "Tornado Destructable" }
Enemies[20] = { name = "Spycopter BG" }
Enemies[21] = { name = "Ride Armor Test Boss" }
Enemies[22] = { name = "Meta Capsule" }
Enemies[23] = { name = "Spycopter" }
Enemies[24] = { name = "Head Gunner" }
Enemies[25] = { name = "X-mark elevator platform" }
Enemies[26] = { name = "Ride Armor Destructable Block" }
Enemies[27] = { name = "Spike ball generator" }
Enemies[28] = { name = "Mine Tortoise" }
Enemies[29] = { name = "Wild Tank" }
Enemies[30] = { name = "Victoroid" }
Enemies[31] = { name = "Tombort" }
Enemies[32] = { name = "Collapsing ceiling piece" }
Enemies[33] = { name = "Breaking glass" }
Enemies[34] = { name = "Atareeter" }
Enemies[35] = { name = "Snow Soldier + Snow Slider" }
Enemies[36] = { name = "Blizzard machine" }
Enemies[37] = { name = "Falling bullet-shaped platform" }
Enemies[38] = { name = "Multidirectional elevator platform" }
Enemies[39] = { name = "Worm Seeker-R", SubID = 0, weakness1 = 0xD, weakness2 = 0x7 }
Enemies[40] = { name = "Walk Blaster" }
Enemies[41] = { name = "De Voux" }
Enemies[42] = { name = "Crawfish Reactor" }
Enemies[43] = { name = "Drill Waying" }
Enemies[44] = { name = "Genjibo" }
Enemies[45] = { name = "Hamma Hamma" }
Enemies[46] = { name = "Rising Lava" }
Enemies[47] = { name = "Ride Armor platform" }
Enemies[48] = { name = "Hell Crusher", weakness1 = 0xE, weakness2 = 0x1C }
Enemies[49] = { name = "Vile stage elevator" }
Enemies[50] = { name = "Electric spark" }
Enemies[51] = { name = "Boulder" }
Enemies[52] = { name = "Suspended Boulder" }
Enemies[53] = { name = "Ganseki Carrier" }
Enemies[54] = { name = "Descending spike ceiling" }
Enemies[55] = { name = "Gravity-charged platform" }
Enemies[56] = { name = "Crushing wall" }
Enemies[57] = { name = "Vile stage falling bridge block" }
Enemies[58] = { name = "Ride Armor destructable floor" }
Enemies[59] = { name = "???" }
Enemies[60] = { name = "Charged Thunder destructable platform" }
Enemies[61] = { name = "Trapper" }
Enemies[62] = { name = "Descending spike ceiling (Whole)" }
Enemies[63] = { name = "Falling sand" }
Enemies[64] = { name = "Vile stage destruction" }
Enemies[65] = { name = "Crushing wall sequence" }
Enemies[66] = { name = "Hotareeca", weakness1 = 0xD, weakness2 = 0x9 }
Enemies[67] = { name = "Godkarmachine parts" }
Enemies[68] = { name = "Kaiser Sigma parts" }
Enemies[69] = { name = "Godkarmachine O' Inary checker" }
Enemies[70] = { name = "Bit", weakness1 = 0x9, weakness2 = 0xD }
Enemies[71] = { name = "Byte", weakness1 = 0xE, weakness2 = 0x1C }
Enemies[72] = { name = "Dr. Doppler", weakness1 = 0x7 }
Enemies[73] = { name = "Vile's Kangaroo Ride Armor", weakness1 = 0x1C, weakness2 = 0xA }
Enemies[74] = { name = "Volt Kurageil", SubID = 0, weakness1 = 0x9, weakness2 = 0xD }
Enemies[75] = { name = "Buster Destructable crate" }
Enemies[76] = { name = "Hangerter" }
Enemies[77] = { name = "Light Capsule" }
Enemies[78] = { name = "Light Capsule lightning strike" }
Enemies[79] = { name = "Shurikein", weakness1 = 0x7 }
Enemies[80] = { name = "Maoh the Giant" }
Enemies[81] = { name = "REX-2000", weakness1 = 0xD, weakness2 = 0xA }
Enemies[82] = { name = "Blizzard Buffalo", weakness1 = 0x8 }
Enemies[83] = { name = "Blast Hornet", weakness1 = 0xC }
Enemies[84] = { name = "Crush Crawfish", weakness1 = 0x9 }
Enemies[85] = { name = "Tunnel Rhino", weakness1 = 0x7 }
Enemies[86] = { name = "Neon Tiger", weakness1 = 0xA }
Enemies[87] = { name = "Toxic Seahorse", weakness1 = 0xD }
Enemies[88] = { name = "Volt Catfish", weakness1 = 0xE }
Enemies[89] = { name = "Gravity Beetle", weakness1 = 0x1C }
Enemies[90] = { name = "Press Disposer", SubID = 0, weakness1 = 0xE, weakness2 = 0x1C }
Enemies[91] = { name = "Mosquitus" }
Enemies[92] = { name = "Dialogue Box" }
Enemies[93] = { name = "Godkarmachine", weakness1 = 0x1C }
Enemies[94] = { name = "Captain America Sigma", weakness1 = 0xD, weakness2 = 0xA }
Enemies[95] = { name = "Kaiser Sigma", weakness1 = 0x3, weakness2 = 0x2 }
Enemies[96] = { name = "Virus Sigma" }
Enemies[97] = { name = "Vile", weakness1 = 0x1C, weakness2 = 0xA }
Enemies[98] = { name = "Mac" }
Enemies[99] = { name = "Vile's Goliath Armor", weakness1 = 0x8, weakness2 = 0xE }
Enemies[100] = { name = "Sigma Virus cutscene" }
Enemies[101] = { name = "Item dispenser" }
Enemies[102] = { name = "???" }
Enemies[103] = { name = "???" }
Enemies[104] = { name = "???" }
Enemies[105] = { name = "Boss Intro object" }
Enemies[106] = { name = "???" }
Enemies[107] = { name = "???" }

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
	
	Weaknesses[0] = { name = "Lemon", icon = loadImage("./images/lemon") }
	Weaknesses[1] = { name = "Charge Shot L1", charged = true, icon = loadImage("./images/lemon") }
	Weaknesses[2] = { name = "Z-Saber (Slash)", icon = loadImage("./images/X3Saber") }
	Weaknesses[3] = { name = "Charge Shot L2", charged = true, icon = loadImage("./images/lemon") }
	Weaknesses[4] = { name = "Z-Saber (Beam)", charged = true, icon = loadImage("./images/X3Saber") }
	Weaknesses[5] = { name = "Z-Saber (Beam slashes)", charged = true, icon = loadImage("./images/X3Saber") }
	Weaknesses[6] = { name = "Dash Lemon", charged = true, icon = loadImage("./images/lemon") }
	Weaknesses[7] = { name = "Acid Burst", icon = loadImage("./images/Acid") }
	Weaknesses[8] = { name = "Parasitic Bomb", icon = loadImage("./images/Bomb") }
	Weaknesses[9] = { name = "Triad Thunder", icon = loadImage("./images/Thunder") }
	Weaknesses[10] = { name = "Spinning Blade", icon = loadImage("./images/Blade") }
	Weaknesses[11] = { name = "???" }
	Weaknesses[12] = { name = "Gravity Well", icon = loadImage("./images/Hole") }
	Weaknesses[13] = { name = "Frost Shield", icon = loadImage("./images/Frost") }
	Weaknesses[14] = { name = "Tornado Fang", icon = loadImage("./images/Tornado") }
	Weaknesses[15] = { name = "???" }
	Weaknesses[16] = { name = "Charged Acid Burst", charged = true, icon = loadImage("./images/Acid") }
	Weaknesses[17] = { name = "Charged Parasitic Bomb", charged = true, icon = loadImage("./images/Bomb") }
	Weaknesses[18] = { name = "Charged Triad Thunder", charged = true, icon = loadImage("./images/Thunder") }
	Weaknesses[19] = { name = "Charged Spinning Blade", charged = true, icon = loadImage("./images/Blade") }
	Weaknesses[20] = { name = "???" }
	Weaknesses[21] = { name = "Charged Gravity Well", charged = true, icon = loadImage("./images/Hole") }
	Weaknesses[22] = { name = "Charged Frost Shield (On Hand)", charged = true, icon = loadImage("./images/Frost") }
	Weaknesses[23] = { name = "Charged Tornado Fang", charged = true, icon = loadImage("./images/Tornado") }
	Weaknesses[24] = { name = "Acid Burst (Small uncharged bubbles)", icon = loadImage("./images/Acid") }
	Weaknesses[27] = { name = "Triad Thunder (Thunder)", icon = loadImage("./images/Thunder") }
	Weaknesses[28] = { name = "Ray Splasher", icon = loadImage("./images/Ray") }
	Weaknesses[29] = { name = "Charged Shot L3", charged = true, icon = loadImage("./images/lemon") }
	Weaknesses[31] = { name = "Charged Shot L4 (Main Shot)", charged = true, icon = loadImage("./images/lemon") }
	Weaknesses[32] = { name = "Charged Shot L4 (Secondary Shot)", charged = true, icon = loadImage("./images/lemon") }
	Weaknesses[33] = { name = "Charged Frost Shield (Lotus)", charged = true, icon = loadImage("./images/Frost") }

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
			for i = 1, 8 do
				if tanks[mytanks[i]] then
					putImage((i * 16) - 6, 199 + bottomY, etankIcon, 16, 16, 0.9)
				end
			end
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
	
	if showRideArmors and unpaused then 
		--Draw Current Ride Armor parts
		if sigmaStage < 3 then
			for i = 1, 4 do
				if ridearmor[myridearmor[i]] then	
					putImage(80 + (i * 16), 0, ridearmorIcons[i], 16, 16)		
				end
			end
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
				if enemySlots[i].onscreen == 1 or enemySlots[i].onscreen == 0x80 then
					if Enemies[enemySlots[i].ID] and Enemies[enemySlots[i].ID].name and Enemies[enemySlots[i].ID].weakness1 then
						if Enemies[enemySlots[i].ID].SubID and Enemies[enemySlots[i].ID].SubID ~= enemySlots[i].SubID then
							break
						end
						gui.text(10, y, "Enemy: " .. Enemies[enemySlots[i].ID].name .. " HP: " .. enemySlots[i].CurrentHP .. " WEAKNESS1: " .. Weaknesses[Enemies[enemySlots[i].ID].weakness1].name, nil, "topright")
						-- gui.text(10, y, "Slot: " .. i .. " EnemySubID: " .. enemySlots[i].SubID .. " HP: " .. enemySlots[i].CurrentHP .. " WEAKNESS1: " .. Weaknesses[Enemies[enemySlots[i].ID].weakness1].name, nil, "topright")
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
						if Enemies[enemySlots[i].ID] and Enemies[enemySlots[i].ID].name then
							-- gui.text(10, y, "Slot: " .. i .. " EnemyID: " .. enemySlots[i].ID .. " name: " .. Enemies[enemySlots[i].ID].name .. " HP: " .. enemySlots[i].CurrentHP, nil, "topright")
							-- y = y + 16
						else
							-- gui.text(10, y, "Slot: " .. i .. " EnemyID: " .. enemySlots[i].ID .. " name: NEEDED HP: " .. enemySlots[i].CurrentHP, nil, "topright")
							-- y = y + 16
						end
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
	ridearmorall = ridearmor.RAN and ridearmor.RAK and ridearmor.RAH and ridearmor.RAF
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
	
	unpaused = memory.readbyte(adjustAddr(0x7E1F37)) == 0

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

function enemies()
	local base
	local weakBase = 0x7EF540
	local start = 0xD18	
	for i = 0, 13 , 1 do		
		base = start + (i * 0x40)		
		if i == 0 then
			base = start
		end
		
		enemySlots[i].onscreen = memory.readbyte(adjustAddr(0x7E0000 + base))
		enemySlots[i].ID = memory.readbyte(adjustAddr(0x7E0000 + base + 0xA))
		enemySlots[i].SubID = memory.readbyte(adjustAddr(0x7E0000 + base + 0xB))
		enemySlots[i].CurrentHP = memory.readbyte(adjustAddr(0x7E0000 + base + 0x27))

	end	
	
	if AP_ROM and not weaknessesloaded then		
		Enemies[82].weakness1 = memory.readbyte(adjustAddr(weakBase)) --Buffalo
		Enemies[82].weakness2 = memory.readbyte(adjustAddr(weakBase + 1))
		Enemies[87].weakness1 = memory.readbyte(adjustAddr(weakBase + 0x8)) --Seahorse
		Enemies[87].weakness2 = memory.readbyte(adjustAddr(weakBase + 0x8 + 1))
		Enemies[85].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x8 * 2))) --Rhino
		Enemies[85].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x8 * 2) + 1))
		Enemies[88].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x8 * 3))) --Catfish
		Enemies[88].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x8 * 3) + 1))
		Enemies[84].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x8 * 4))) --Crawfish
		Enemies[84].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x8 * 4) + 1))
		Enemies[86].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x8 * 5))) --Tiger
		Enemies[86].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x8 * 5) + 1))
		Enemies[89].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x8 * 6))) --Beetle
		Enemies[89].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x8 * 6) + 1))
		Enemies[83].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x8 * 7))) --Hornet
		Enemies[83].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x8 * 7) + 1))
		Enemies[66].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x8 * 8))) --Hotareeca
		Enemies[66].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x8 * 8) + 1))
		Enemies[39].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x8 * 9))) --Worm Seeker-R
		Enemies[39].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x8 * 9) + 1))
		Enemies[48].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x8 * 10))) --Hell Crusher
		Enemies[48].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x8 * 10) + 1))
		Enemies[79].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x8 * 11))) --Shurikein
		Enemies[79].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x8 * 11) + 1))
		Enemies[70].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x8 * 12))) --Bit
		Enemies[70].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x8 * 12) + 1))
		Enemies[71].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x8 * 13))) --Byte
		Enemies[71].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x8 * 13) + 1))
		Enemies[97].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x8 * 14))) --Vile
		Enemies[97].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x8 * 14) + 1))
		Enemies[73].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x8 * 14))) --Vile kangaroo (same as regular)
		Enemies[73].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x8 * 14) + 1))
		Enemies[90].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x8 * 15))) --Press Disposal
		Enemies[90].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x8 * 15) + 1))
		Enemies[93].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x8 * 16))) --Godkarmamachine
		Enemies[93].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x8 * 16) + 1))
		Enemies[74].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x8 * 17))) --Doppler 2 boss/ Volt or Vile?
		Enemies[74].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x8 * 17) + 1))
		Enemies[99].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x8 * 18))) --Vile Goliath
		Enemies[99].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x8 * 18) + 1))
		Enemies[72].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x8 * 19))) --Dr. Doppler
		Enemies[72].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x8 * 19) + 1))
		Enemies[94].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x8 * 20))) --Captain Sigma
		Enemies[94].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x8 * 20) + 1))
		Enemies[95].weakness1 = memory.readbyte(adjustAddr(weakBase + (0x8 * 21))) --Kaiser Sigma
		Enemies[95].weakness2 = memory.readbyte(adjustAddr(weakBase + (0x8 * 21) + 1))
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

