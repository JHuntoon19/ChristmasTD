extends Area2D
class_name Tower
@onready var attack_delay: Timer = %AttackDelay
@onready var attack_sound: AudioStreamPlayer2D = $AttackSound

#Direction tower shoots in
var attackDir : Vector2 = Vector2.UP
#tower is waiting for mouse input to aim direction
var aiming : bool = true
#Enems is an array that holds all the enemies within range
var enems : Array[Area2D] = []
var canAttack : bool = true
#Multiplies the speed by this number to increase when tower is leveled up
var projSpeed : float = 1
#Holds the range of the tower
var towerRange : int = 9
#Shows how fast the tower will attack
#Automatically changes the timer when updated
var attackSpeed : float
#type of tower set in inspectore of each tower
@export var type: Global.TowerType
@onready var aim_arrow: Node2D = $AimArrow

#Sets up variable values on instantiation
func _init() -> void:
	upgrade()
#Applies variable values to nodes
func _ready() -> void:
	setup()
func _process(delta) -> void:
	#tower was just placed and needs a direction to shoot in
	if(aiming):
		#Gets direction to the mouse position
		attackDir = get_global_mouse_position() - position
		attackDir = attackDir.normalized()
		#Player decides direction and deletes the helper arrow
		if Input.is_action_just_pressed("click"):
			aiming = false
			aim_arrow.queue_free()
#	If the timer has gone off it calls an attack method
	if(not aiming and canAttack):
		canAttack = false
		attack_delay.start()
		attack_sound.play()
		attack()
#			Will be changed by the towers themselves
func attack() -> void:
	print("attack")
func _on_attack_delay_timeout() -> void:
	canAttack = true
func upgrade() -> void:
	pass
#Applies custom time and range on ready
func setup() -> void:
	attack_delay.wait_time = attackSpeed
	$Range/CollisionShape2D.shape.radius = towerRange
	
