extends CanvasLayer
@onready var money_text = %MoneyText
signal elfTowerClicked()
signal snowTowerClicked()
signal gnomeTowerClicked()
signal shieldTowerClicked()
#Automaticly closes the side panel
func _ready():
	$SideVisible.visible = false
	$SideHidden.visible = true
	#Set costs of towers
	%ElfCostLabel.text = str(Global.elfCost)
	%SnowCostLabel.text = str(Global.snowCost)
	%ShieldCostLabel.text = str(Global.shieldCost)
	%GnomeCostLabel.text = str(Global.gnomeCost)
	#Connects the global signals
	Global.connect("moneyChanged",updateMoneyText)
	Global.connect("heartUpdate", updateHearts)
#Keeps the money amount to 4 digits
func updateMoneyText(amount : String) -> void:
	var mText = "0000" + amount
	mText = mText.substr(mText.length() - 4)
	money_text.text = mText
#Hides and reveals the side panel
func _on_show_side_button_pressed():
	$SideHidden.visible = false
	$SideVisible.visible = true
func _on_hide_side_button_pressed():
	$SideHidden.visible = true
	$SideVisible.visible = false
#Highlights the hovered tower
func _on_elf_tower_button_mouse_entered():
	buttonHovered(%ElfTowerButton.get_parent().get_parent())
func _on_snowman_tower_mouse_entered():
	buttonHovered(%SnowmanTower.get_parent().get_parent())
func buttonHovered(background : PanelContainer):
	background.self_modulate = Color("ff82ff")
func buttonUnHovered(background : PanelContainer):
	background.self_modulate = Color.WHITE
func _on_snowman_tower_mouse_exited():
	buttonUnHovered(%SnowmanTower.get_parent().get_parent())
func _on_elf_tower_button_mouse_exited():
	buttonUnHovered(%ElfTowerButton.get_parent().get_parent())
func _on_shield_mouse_entered() -> void:
	buttonHovered(%Shield.get_parent().get_parent())
func _on_shield_mouse_exited() -> void:
	buttonUnHovered(%Shield.get_parent().get_parent())
func _on_gnome_mouse_entered() -> void:
	buttonHovered(%gnome.get_parent().get_parent())
func _on_gnome_mouse_exited() -> void:
	buttonUnHovered(%gnome.get_parent().get_parent())
	
#Alerts level that the elf button was clicked
func _on_elf_tower_button_pressed():
	_on_hide_side_button_pressed()
	elfTowerClicked.emit()

#ALerts the level that the snowman button was clicked
func _on_snowman_tower_pressed():
	_on_hide_side_button_pressed()
	snowTowerClicked.emit()
#Updates the amount of hearts on the top of the screen
func updateHearts(heartNum : int) -> void:
	#Gets the amount of hearts currently displayed
	var currentHeart = %HeartHolder.get_child_count()
	#Constantly adds hearts until the amount is met
	while(currentHeart < heartNum):
		%HeartHolder.call_deferred("add_child", preload("res://UI/heart_i.tscn").instantiate())
		currentHeart += 1
	#Constantyl removes hearts until the amount is met
	while(currentHeart > heartNum):
		%HeartHolder.get_child(- 1).queue_free()
		currentHeart -= 1
#Alerts level that the gnome was clicked
func _on_gnome_pressed() -> void:
	_on_hide_side_button_pressed()
	gnomeTowerClicked.emit()
#Alerts level that shield was clicked
func _on_shield_pressed() -> void:
	_on_hide_side_button_pressed()
	shieldTowerClicked.emit()
