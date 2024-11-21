extends "res://Scripts/tower.gd"
signal Elfattack(tower : Area2D, enemy : Area2D)
#Overwrites the default attack function and emits signal to level
func attack() -> void:
#	Give level info on the position of tower and the targeted enemy
	Elfattack.emit(self,enems[0])
