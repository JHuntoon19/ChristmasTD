extends CanvasLayer
func _ready() -> void:
	var presentsSaved : int = 5 - Global.monsterPresentNum
	updatePresents(presentsSaved)
	#Removes all heart children that will be later be added to the correct amount
	for n in %HeartHolder.get_children():
		n.queue_free()
	#Connects the hearupdate signal and emits that to display the players heart count
	Global.connect("heartUpdate", updateHeart)
	Global.heartUpdate.emit(Global.santaHeart)
func updatePresents(presentNum : int) -> void:
	for present in presentNum:
		%PresentHolder.get_child(present).visible = true
#Emited from Global
#Displays the correct amount of hearts to the player
func updateHeart(heartNum : int) -> void:
	for heart in heartNum:
		var heartScene = preload("res://UI/heart_i.tscn").instantiate()
		%HeartHolder.call_deferred("add_child", heartScene)


func _on_present_mouse_entered() -> void:
	%Present.get_child(0).get_child(0).custom_minimum_size *= 2
	hovered(%Present)
func _on_present_mouse_exited() -> void:
	%Present.get_child(0).get_child(0).custom_minimum_size *= 0.5
	unHovered(%Present)
func _on_present_2_mouse_entered() -> void:
	%Present2.get_child(0).get_child(0).custom_minimum_size *= 2
	hovered(%Present2)
func _on_present_2_mouse_exited() -> void:
	%Present2.get_child(0).get_child(0).custom_minimum_size *= 0.5
	unHovered(%Present2)
func _on_present_3_mouse_entered() -> void:
	%Present3.get_child(0).get_child(0).custom_minimum_size *= 2
	hovered(%Present3)
func _on_present_3_mouse_exited() -> void:
	%Present3.get_child(0).get_child(0).custom_minimum_size *= 0.5
	unHovered(%Present3)
func _on_present_4_mouse_entered() -> void:
	%Present4.get_child(0).get_child(0).custom_minimum_size *= 2
	hovered(%Present4)
func _on_present_4_mouse_exited() -> void:
	%Present4.get_child(0).get_child(0).custom_minimum_size *= 0.5
	unHovered(%Present4)
func _on_present_5_mouse_entered() -> void:
	%Present5.get_child(0).get_child(0).custom_minimum_size *= 2
	hovered(%Present5)
func _on_present_5_mouse_exited() -> void:
	%Present5.get_child(0).get_child(0).custom_minimum_size *= 0.5
	unHovered(%Present5)
func hovered(background : PanelContainer) -> void:
		background.self_modulate = Color("ff82ff")
func unHovered(background : PanelContainer) -> void:
	background.self_modulate = Color.WHITE
