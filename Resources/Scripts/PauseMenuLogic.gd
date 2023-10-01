extends Control

var Gui = null

func _ready():
	pass # Replace with function body.


func _on_CountinueButton_pressed():
	get_tree().paused = false
	Gui.ShowePauseMenu(false)


func _on_ExitButton_pressed():
	get_tree().quit()
