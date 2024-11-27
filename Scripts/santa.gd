extends CharacterBody2D
class_name Santa
var inputD : Vector2 = Vector2.ZERO
var speed : int = 50
var enems : Array[Area2D] = []
var canAttack : bool = true
var presentHolder : bool = false
@onready var attackdelay: Timer = $Attackdelay
#Signals the level with the position and target for snowballs
signal santaAttack(position : Vector2, enemy : Vector2)
#Makes the scale of the dotted circle equal to the range of santa
func _ready() -> void:
	$Range/Sprite2D.scale = Vector2($Range/CollisionShape2D.shape.radius / 559, $Range/CollisionShape2D.shape.radius / 564) * 2
func _process(delta: float) -> void:
	#Sets the velocity of santa
	getInput()
	#If space is pushed and enemies are in range and the timer has gone off we can attack
	if(Input.is_action_pressed("attack") and !enems.is_empty() and canAttack):
		#Start timer
		canAttack = false
		attackdelay.start()
		#Alert level the position of santa and the targeted enemy
		santaAttack.emit(position, enems[0].get_parent().position)
	#Moves santa according to velocity
	move_and_slide()
	#Rotate range circle
	$Range/Sprite2D.rotation += 0.3 * delta
#Gathers the inputed direction to move santa
func getInput() -> void:
	inputD = Input.get_vector("Left","Right","Up","Down")
	velocity = inputD * speed

#When santa is hit by an enemy or projectile
func _on_detect_area_entered(area: Area2D) -> void:
		Global.santaHeart -= 1
#Adds the in range enemies to an array to be targeted
func _on_range_area_entered(area: Area2D) -> void:
	enems.append(area)
func _on_range_area_exited(area: Area2D) -> void:
	enems.erase(area)
#Timer to stop button mash snow balls
func _on_attackdelay_timeout() -> void:
	canAttack = true
