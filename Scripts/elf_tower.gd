extends Tower
class_name ElfTower
signal Elfattack(tower : Vector2, enemy : Vector2, projSpeed : int)
#Overwrites the default attack function and emits signal to level
func attack() -> void:
#	Give level info on the position of tower and the targeted enemy
	Elfattack.emit(position,enems[0].get_parent().position, projSpeed)
#Called during on ready
func upgrade() -> void:
	#Loops through the values so that a level three tower still get all 
	#The upgrades from levels 1 and 2
	for level : int in range(Global.elfLevel + 1):
		#Works like a switch
		match level:
			0:
				#Default valus for the range, attack speed, and projectile speed
				towerRange = 40
				attackSpeed = 0.3
				projSpeed = 1
			1:
				#Increases speed he attacks and speed of candycanes
				attackSpeed = 0.2
				projSpeed = 2
			2:
				#Increases speed of candy canes and increases range
				projSpeed = 3
				towerRange = 60
			3:
				#Increases attack speed and speed of candycanes
				attackSpeed = 0.07
				projSpeed = 5
