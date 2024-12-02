extends Node
# Array holds the possible upgrades left witha n increased chance of getting hearts
var upgradeType : Array = ["Heart", "Heart","Heart", "ElfTower", "SnowmanTower", "GnomeTower", "Shield", "Santa"]
var type : String
func upgrade() -> String:
	#Assigns a random upgade
	newType()
	#Most basic just adds hearts
	if(type.match("Heart")):
		print(Global.santaHeart)
		Global.santaHeart += 2
		print(Global.santaHeart)
		return "Hearts increased by 2"
	#On all Towers
	#If the tower level is less than three it upgrades the tower
	#Otherwise it removes its choice from the array 
	#Might return error but that is caught by the UI
	if(type.match("ElfTower")):
		if(Global.elfLevel < 3):
			Global.elfLevel += 1
			Global.elfCost -= 3
			return "Elf Tower Level Increased"
		else:
			upgradeType.erase("ElfTower")
	if(type.match("SnowmanTower")):
		if(Global.snowLevel < 3):
			Global.snowLevel += 1
			Global.snowCost -= 3
			return "Snowman Tower Level Increased"
		else:
			upgradeType.erase("SnowmanTower")
	if(type.match("GnomeTower")):
		if(Global.gnomeLevel < 3):
			Global.gnomeLevel += 1
			Global.gnomeCost -= 3
			return "Gnome Tower Level Increased"
		else:
			upgradeType.erase("GnomeTower")
	if(type.match("Shield")):
		if(Global.shieldLevel < 3):
			Global.shieldLevel += 1
			Global.shieldCost -= 3
			return "Shield Tower Level Increased"
		else:
			upgradeType.erase("Shield")
	if(type.match("Santa")):
		if(Global.santaLevel < 3):
			Global.santaLevel += 1
			return "Santa Level Increased"
		else:
			upgradeType.erase("Santa")
	return "Error"
#Assigns a new random upgrade
func newType():
	type = upgradeType.pick_random()
	
