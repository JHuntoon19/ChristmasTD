extends Sprite2D
class_name ShieldSeg
var health : int
@onready var area_2d: Area2D = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_2d.connect("area_entered",areaEntered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func hurt():
	health -= 1
	print(health)
	if health <= 0:
		queue_free()
func areaEntered(area : Area2D):
	hurt()
