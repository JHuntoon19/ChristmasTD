extends Tower
signal snowmanAttack(tower : Area2D, projNum : Area2D)
#Overwrites default attack method
func attack() -> void:
#	Gives level info on tower position and the amount of carrots to shoot
	snowmanAttack.emit(self, 6)
