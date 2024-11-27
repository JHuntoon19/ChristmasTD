extends Tower
signal snowmanAttack(tower : Area2D, projNum : Area2D)
#holds the amount of carrots he shoots
var projAmount : int = 6
#Overwrites default attack method
func attack() -> void:
#	Gives level info on tower position and the amount of carrots to shoot
	snowmanAttack.emit(self, projAmount, projSpeed)
#Called on on ready
func upgrade():
	#Loops through and applies level upgrades for all levels
	for level in range(Global.snowLevel + 1):
		match level:
			1:
				#Increases carrot shot and attack speed
				projAmount += 2
				attackSpeed = 0.7
			2:
				#Increases range, carrot amount and speed of the carrot
				projAmount += 2
				range = 40
				$Range/CollisionShape2D.shape.radius = range
				projSpeed = 1.5
			3:
				#Increases carrot amount, attack speed, and the speed of the carrot
				projAmount += 2
				attackSpeed = 0.4
				projSpeed = 3
