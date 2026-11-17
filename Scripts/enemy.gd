extends PathFollow2D
class_name Enemy
@export var speed : float = 0.05
@export var health : int = 10
var forward : bool = true
var presentHolder : bool = false
signal dead(enemy : PathFollow2D, holder : bool)
signal ended(enemy : PathFollow2D)
signal begined(enemy : PathFollow2D)
@onready var alien_hit: AudioStreamPlayer2D = $AlienHit
@onready var animation_player: AnimationPlayer = $AnimationPlayer

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
#Takes damage and calls the method to play hurt animations
func _on_hitbox_area_entered(area):
	hitAnim()
	alien_hit.play()
	health -= 1
#method will be used by children to show hurt animation
func hitAnim():
	pass
