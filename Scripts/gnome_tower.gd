extends Tower
signal gnomeAttack(tower : Vector2, enemy : Vector2, spinSpeed : float, size : float)
var rotateSpeed : float = 1
var projSize : float = 1
#Overwrites default attack method
func attack() -> void:
#	Gives level info on tower position and the amount of carrots to shoot
	gnomeAttack.emit(position, enems[0].get_parent().position, rotateSpeed, projSize)
#Called on initilization
func upgrade() -> void:
	#Loops through and applies upgrades based on level
	for level : int in range(Global.gnomeLevel + 1):
		match level:
			0:
				#default values
				attackSpeed = 2
				towerRange = 25
				rotateSpeed = 1
				projSize = 1
			1:
				#Increaes attack speed, range, and the rotate speed of the pickaxe
				attackSpeed = 1.5
				towerRange = 30
				rotateSpeed = 1.5
			2:
				#More upgrades but with a bigger pickaxe
				attackSpeed = 1
				towerRange = 35
				rotateSpeed = 2
				projSize = 1.5
			3:
				#OP upgrades
				attackSpeed = 0.5
				towerRange = 40
				rotateSpeed = 2.5
				projSize = 2
