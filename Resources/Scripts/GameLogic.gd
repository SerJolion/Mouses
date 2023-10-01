extends Node

export(int) var DisplayWidth = 500
export(int) var DisplayHeight = 500
export(int,'Легко', "Средне", "Сложно") var Difficult

const DIFFICULT_EASY = 0
const DIFFICULT_MEDIUM = 1
const DIFFICULT_HARD = 2

export(NodePath) var CheesePath

var MouseSpawner
var GameObjects
var Gui
var winTimer

var Cheese = null

func _ready():
	MouseSpawner = $LogicObjects/MouseSpawner
	GameObjects = $GameObjects
	Gui = $GUI
	winTimer = $LogicObjects/WinTimer

	Cheese = get_node(CheesePath)
	Cheese.connect('CheeseBitten',self,"FailConditionCheck")
	Gui.Init(self)
	get_tree().paused = true
	Gui.ShowStartMenu(true)


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().paused = true
		Gui.ShowePauseMenu(true)

func Init():
	pass

func Start():
	get_tree().paused = false
	winTimer.start()

func SetDifficult(value):
	Difficult = value
	match Difficult:
		0:
			Cheese.SetMaxLife(30)
			winTimer.wait_time = 30
			MouseSpawner.SpawnPeriod = 0.8
			MouseSpawner.MinMouseSpeed = 1
			MouseSpawner.MaxMouseSpeed = 2
		1:
			Cheese.SetMaxLife(20)
			winTimer.wait_time = 40
			MouseSpawner.SpawnPeriod = 0.6
			MouseSpawner.MinMouseSpeed = 2
			MouseSpawner.MaxMouseSpeed = 4
		2:
			Cheese.SetMaxLife(10)
			winTimer.wait_time = 60
			MouseSpawner.SpawnPeriod = 0.4
			MouseSpawner.MinMouseSpeed = 4
			MouseSpawner.MaxMouseSpeed = 6

func FailConditionCheck(Health):
	if Health <= 0:
		print('Вы проиграли!')
		get_tree().quit()

func _on_WinTimer_timeout():
	print('Вы выйграли!')
	get_tree().quit()
