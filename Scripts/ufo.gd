extends Node2D
class_name UFO

@onready var laser: LaserNode = $Laser
@export var minLaserTime : float
@export var maxLaserTime : float
#Fire timer is how long the ufo is warning player. until fire timer is time between fires
@onready var fire_timer: Timer = $FireTimer
@onready var until_fire_timer: Timer = $UntilFireTimer
#White timer is how long the laser is white
@onready var white_timer: Timer = $whiteTimer
#Show timer is how long the laser "aims" at the player. controls laser visibility
@onready var show_timer: Timer = $ShowTimer
#Firing means we are warning player to move. laser is half white and doesn't follow player anymore
var firing : bool = false
#Laser is red and follows player
var aiming : bool = true
#Whether the laser is visible or not
var showing : bool = false
#Sets the lasers whit timer to be in sync with the UFO
func _ready() -> void:
	laser.updateTimer(white_timer.wait_time)
func _process(delta: float) -> void:
	#Handles if the laser is visible or not
	laser.visible = showing
	#The laser is red and follows player
	if not firing:
			#If we are aiming keep laser red. Otherwise turn it to green and start firing
			if aiming:
				laser.firing = false
			else:
				laser.firing = true
				firing = true
				aiming = false
#Its time to show laser and start aiming
func _on_until_fire_timer_timeout() -> void:
	show_timer.start()
	showing = true
#Time to shoot!
func _on_fire_timer_timeout() -> void:
	fire()
#Do damage along path and turn laser white for an amount of time
func fire():
	laser.shoot()
	white_timer.start()
#The laser no longer aims and turns half white to warn player
func _on_show_timer_timeout() -> void:
	aiming = false
	fire_timer.start()
#Time to turn laser invisible to give player rest. Laser aims at player again.
func _on_white_timer_timeout() -> void:
	showing = false
	aiming = true
	firing = false
	#Sets the laser to fire at unexpected times
	until_fire_timer.wait_time = randf_range(minLaserTime,maxLaserTime)
	until_fire_timer.start()
