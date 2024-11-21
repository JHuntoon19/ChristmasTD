extends CanvasLayer
@onready var money_text = $Money/VBoxContainer/HBoxContainer/MoneyText
func _ready():
	updateMoneyText("0000")
	$SideVisible.visible = false
	$SideHidden.visible = true
func updateMoneyText(amount : String) -> void:
	var mText = "0000" + amount
	mText = mText.substr(mText.length() - 4)
	money_text.text = mText
	


func _on_show_side_button_pressed():
	$SideHidden.visible = false
	$SideVisible.visible = true


func _on_hide_side_button_pressed():
	$SideHidden.visible = true
	$SideVisible.visible = false
