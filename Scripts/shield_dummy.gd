extends TowerDummy

func _process(delta):
	#Makes dummy follow mouse
	position = get_global_mouse_position()
	#Checks that the tower is not overlapping any others and does not need to be on a built platform
	# and that the player has enough money
	onPlatform = true
	inTower = false
	onPath = false
	checkIfPlaceable()
	attemptPlace()
	#Removes dummy if User backs out
	if(Input.is_action_just_pressed("back")):
		queue_free()
