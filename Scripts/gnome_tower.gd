extends "res://Scripts/tower.gd"
signal gnomeAttack(tower : Vector2, enemy : Vector2)
#Overwrites default attack method
func attack() -> void:
#	Gives level info on tower position and the amount of carrots to shoot
	gnomeAttack.emit(position, enems[0].get_parent().position)
