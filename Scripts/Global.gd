extends Node
signal moneyChanged(amount : String)
signal heartUpdate(heartNum : int)
#Keeps track of the amount of money the player has
#When the money is updated it alerts the UI
var money : int = 0:
	get:
		return money
	set(value):
		money = value
		moneyChanged.emit(str(money))
#Keeps track of presents in the sled
var presentNum : int = 5
#Keeps track of presents in the monsters sled
var monsterPresentNum : int = 0
#Keeps track of santas hearts and automatically changes ui
var santaHeart : int = 4:
	get:
		return santaHeart
	set(value):
		santaHeart = max(value, 0)
		heartUpdate.emit(santaHeart)
enum TowerType{ELF,SNOW,GNOME,SHIELD}
var elfLevel : int = 0
var elfCost : int = 30
var snowLevel : int = 0
var snowCost : int = 45
var gnomeLevel : int = 0
var gnomeCost : int = 45
var shieldLevel : int = 0
var shieldCost : int = 15
var santaLevel : int = 0
