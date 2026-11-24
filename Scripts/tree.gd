extends Node2D
class_name ChristmasTree
@onready var ornament_sprite: Sprite2D = $OrnamentSprite
var ornamentFrame : int
enum TreeState{FULL,HALF,SMALL,DEAD}
@onready var animation_player: AnimationPlayer = $TreeAnim
@onready var range_anim: AnimationPlayer = $RangeAnim
var state : TreeState = TreeState.FULL
signal deadTree(position : Vector2)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Sets up the tree with a random ornament color
	var orn = randi_range(0,3)
	if orn == 0:
		ornamentFrame = 0
	elif orn == 1:
		ornamentFrame = 6
	else:
		ornamentFrame = 12
	ornament_sprite.frame = ornamentFrame
	animation_player.play("IdleFull")

#Called to shrink tree down
func shrink():
	if state == TreeState.FULL:
		state = TreeState.HALF
		ornamentFrame += 2
		ornament_sprite.frame = ornamentFrame
		animation_player.play("IdleHalf")
		range_anim.play("HalfPhase")
	elif state == TreeState.HALF:
		state = TreeState.SMALL
		ornamentFrame += 2
		ornament_sprite.frame = ornamentFrame
		animation_player.play("IdleSmall")
		range_anim.play("SmallPhase")
	elif state == TreeState.SMALL:
		state = TreeState.DEAD
		deadTree.emit(position)
		print("Place resource")
		queue_free()

#Santa entered the range
func _on_area_2d_area_entered(area: Area2D) -> void:
	if state == TreeState.FULL:
		range_anim.play("StartPhase")
	elif state == TreeState.HALF:
		range_anim.play("HalfPhase")
	elif state == TreeState.SMALL:
		range_anim.play("SmallPhase")

#Santa left the range
func _on_area_2d_area_exited(area: Area2D) -> void:
	if state == TreeState.FULL:
		range_anim.play_backwards("StartPhase")
	elif state == TreeState.HALF:
		range_anim.play_backwards("HalfPhase")
	elif state == TreeState.SMALL:
		range_anim.play_backwards("SmallPhase")
