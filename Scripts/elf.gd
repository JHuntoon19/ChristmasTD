extends Area2D
var enems : Array = []
@onready var attack_delay = $AttackDelay
var readyToAttack = true
signal attack(tower, enemy)
func _on_range_area_entered(area):
	enems.append(area)


func _on_range_area_exited(area):
	enems.erase(area)

func _process(delta):
	if(!enems.is_empty()):
		if(readyToAttack):
			readyToAttack = false
			attack_delay.start()
			attack.emit(self, enems[0])


func _on_attack_delay_timeout():
	readyToAttack = true
