extends Node2D
class_name LaserNode
#Laser stops following player and warns player that it will shoot soon
var firing : bool = false
#Laser is still and white. Shows the laser is shot
var white : bool = false
#The laser
@onready var laser_node: Sprite2D = $LaserNode
#The raycast that will peirce all things in its path
@onready var ray_cast_2d: RayCast2D = $RayCast2D
func _process(delta: float) -> void:
	#If we are not firing then we follow the player and are red
	if not firing:
		laser_node.frame = 0
		look_at(Global.santaPos)
	#We warn player that laser will shoot soon. Stops following player. turns half white
	else:
		laser_node.frame = 1
	#If white then the laser is full white
	if white:
		laser_node.frame = 2
#Does damage to everything in laser's path
func shoot():
	#Turns the laser white for the white timer length.
	white = true
	#White timer waits a time given by UFO
	$whiteTimer.start()
	#Clears previous collisions
	ray_cast_2d.clear_exceptions()
	#Scans every collision one by one
	while ray_cast_2d.is_colliding():
		var area : Area2D = ray_cast_2d.get_collider()
		#Calls the hurt method on either an enemy or player
		area.get_parent().hurt()
		#Only want to collide with an area once
		ray_cast_2d.add_exception(area)
		#Updates to get next collision in the same frame
		ray_cast_2d.force_raycast_update()
#Sets the wait time for the white timer given by UFO
func updateTimer(wTime : float):
	$whiteTimer.wait_time = wTime
#Resets the laser to follow player again and be red
func _on_white_timer_timeout() -> void:
	white = false
