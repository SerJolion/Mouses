extends Control

var Gui = false
var game_scene = false

func _ready():
	pass

func Init(GUI, GameScene):
	Gui = GUI
	game_scene = GameScene

func _on_EasyDifficultButton_pressed():
	game_scene.SetDifficult(game_scene.DIFFICULT_EASY)
	game_scene.Start()
	Gui.ShowStartMenu(false)


func _on_MediunDifficultButton_pressed():
	game_scene.SetDifficult(game_scene.DIFFICULT_MEDIUM)
	game_scene.Start()
	Gui.ShowStartMenu(false)


func _on_HardDifficultButton_pressed():
	game_scene.SetDifficult(game_scene.DIFFICULT_HARD)
	game_scene.Start()
	Gui.ShowStartMenu(false)


func _on_ExitButton_pressed():
	get_tree().quit()
