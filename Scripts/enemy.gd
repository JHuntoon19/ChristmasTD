extends PathFollow2D
class_name Enemy
@export var speed : float = 0.05
@export var health : int = 10
var forward : bool = true
var presentHolder : bool = false
signal dead(enemy : PathFollow2D, holder : bool)
signal ended(enemy : PathFollow2D)
signal begined(enemy : PathFollow2D)
@onready var hit_timer: Timer = $HitTimer
@onready var alien_hit: AudioStreamPlayer2D = $AlienHit

func _process(delta):
	progress_ratio += speed * delta
	#Once the enemy reaches the end of the path it flips around it goes back
	if(progress_ratio == 1):
		$Hitbox/EImage.flip_h = true
		speed *= -1
		#Alerts the level that the enemy has reached the end
		ended.emit(self)
	if(progress_ratio == 0):
		$Hitbox/EImage.flip_h = false
		speed *= -1
		begined.emit(self)
	if(health <= 0):
		dead.emit(self, presentHolder)
#Flashes the color red when it is hit
func _on_hitbox_area_entered(area):
	modulate = Color.RED
	hit_timer.start()
	alien_hit.play()
	health -= 1
#Used to flash the cow when hit
func _on_hit_timer_timeout() -> void:
	modulate = Color.WHITE
