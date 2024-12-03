extends CharacterBody2D
class_name Santa
var inputD : Vector2 = Vector2.ZERO
var speed : int = 50
var enems : Array[Area2D] = []
var canAttack : bool = true
var presentHolder : bool = false
var dashEarned : bool = false
var canDash : bool = true
var dashing : bool = false
@onready var attackdelay: Timer = $Attackdelay
@onready var dash_timer: Timer = $DashTimer
var normColor : Color = Color.WHITE
var dashColor : Color = Color("b7a3bc74")
var size : float = 1
var rangeSize : float = 1
var attackSpeed : float = 0.25
#Signals the level with the position and target for snowballs
signal santaAttack(position : Vector2, enemy : Vector2)
#Makes the scale of the dotted circle equal to the range of santa
func _ready() -> void:
	upgrade()
	$Range/Sprite2D.scale = Vector2($Range/CollisionShape2D.shape.radius / 559, $Range/CollisionShape2D.shape.radius / 564) * 2
	$Attackdelay.wait_time = attackSpeed
	
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
	if(dashEarned and Input.is_action_just_pressed("Dash") and canDash):
		canDash = false
		dashing = true
		dash_timer.start()
	if(dashing):
		modulate = dashColor
		velocity *= 5
	#Moves santa according to velocity
	move_and_slide()
	#Rotate range circle
	$Range/Sprite2D.rotation += 0.3 * delta
func upgrade() -> void:
	for level : int in range(Global.santaLevel + 1):
		match level:
			0:
				size = 1
				speed = 50
				dashEarned = false
				attackSpeed = 0.25
			1:
				dashEarned = true
			2:
				attackSpeed = 0.2
			3:
				attackSpeed = 0.15
				size = 0.75
				rangeSize = 1.5
				scale = Vector2(size, size)
				$Range/CollisionShape2D.shape.radius *= rangeSize
#Gathers the inputed direction to move santa
func getInput() -> void:
	inputD = Input.get_vector("Left","Right","Up","Down")
	velocity = inputD * speed

#When santa is hit by an enemy or projectile
func _on_detect_area_entered(area: Area2D) -> void:
	if(!dashing):
		Global.santaHeart -= 1
#Adds the in range enemies to an array to be targeted
func _on_range_area_entered(area: Area2D) -> void:
	enems.append(area)
func _on_range_area_exited(area: Area2D) -> void:
	enems.erase(area)
#Timer to stop button mash snow balls
func _on_attackdelay_timeout() -> void:
	canAttack = true
func _on_dash_timer_timeout() -> void:
	canDash = true
	dashing = false
	modulate = normColor
