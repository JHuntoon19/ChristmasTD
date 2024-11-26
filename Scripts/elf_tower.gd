extends "res://Scripts/tower.gd"
signal Elfattack(tower : Vector2, enemy : Vector2)
#Overwrites the default attack function and emits signal to level
func attack() -> void:
#	Give level info on the position of tower and the targeted enemy
	Elfattack.emit(position,enems[0].get_parent().position)
