extends Node
var CCScene : PackedScene = preload("res://Projectiles/candy_cane.tscn")

func _on_elf_attack(tower, enemy):
	var CC = CCScene.instantiate()
	var enemyParent = enemy.get_parent()
	var direction = (enemyParent.position - tower.position).normalized()
	CC.position = tower.position
	CC.direction = direction
	CC.rotation = direction.angle()
	$Projectiles.call_deferred("add_child",CC)
