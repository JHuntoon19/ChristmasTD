extends CanvasLayer
var presentsSaved : int
func _ready() -> void:
	#Stores amount of saved presents
	presentsSaved = 5 - Global.monsterPresentNum
	#Hides the next level button
	$Middle/ExitButton.visible = false
	#Displays correct amount of presents
	updatePresents(presentsSaved)
	#Connects the hearupdate signal and emits that to display the players heart count
	Global.connect("heartUpdate", updateHeart)
	Global.heartUpdate.emit(Global.santaHeart)
func updatePresents(presentNum : int) -> void:
	#hides all presents before going through and showing the correct amount
	for present in %PresentHolder.get_child_count():
		%PresentHolder.get_child(present).visible = false
	for present in presentNum:
		%PresentHolder.get_child(present).visible = true
#Emited from Global
#Displays the correct amount of hearts to the player
func updateHeart(heartNum : int) -> void:
	#Gets the amount of hearts currently displayed
	var currentHeart = %HeartHolder.get_child_count()
	#Constantly adds hearts until the amount is met
	while(currentHeart < heartNum):
		%HeartHolder.call_deferred("add_child", preload("res://UI/heart_i.tscn").instantiate())
		currentHeart += 1
	#Constantyl removes hearts until the amount is met
	while(currentHeart > heartNum):
		%HeartHolder.get_child(0).free()
		currentHeart -= 1


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


func onePButtonPressed() -> void:
	presentPressed(%Present)

func twoPButtonPressed() -> void:
	presentPressed(%Present2)

func threePButtonPressed() -> void:
	presentPressed(%Present3)

func fourPButtonPressed() -> void:
	presentPressed(%Present4)

func fivePButtonPressed() -> void:
	presentPressed(%Present5)
#Called when a present is clicked
func presentPressed(present : PanelContainer) -> void:
	presentsSaved -= 1
	#Gets a random upgrade
	upgrade()
	present.visible = false
	#Hides the panel if all presents are gone
	if(presentsSaved == 0):
		$Middle/PanelContainer.visible = false 
		#Shows next level button
		$Middle/ExitButton.visible = true
#Gets a random upgrade
func upgrade() -> void:
	#If an error occurs then we recall the upgrade to get a real upgrade
	var valuable : bool = false
	while(!valuable):
		var upText : String = Upgrades.upgrade()
		if(upText != "Error"):
			valuable = true
			%upgradeText.text = upText
	

#Returns to the default level when pressed
func _on_next_level_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/level.tscn")
