extends Control

export(PackedScene) var PauseMenuScene
var PauseMenu = null

export(PackedScene) var StartMenuScene
var StartMenu = null

var game_scene = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	SetTime(game_scene.winTimer.get_time_left())

func Init(GameScene):
	game_scene = GameScene
	game_scene.Cheese.connect('CheeseBitten',self,'CheckCheeseLive')
	SetCheeseLife(game_scene.Cheese.CurrentLive)

func SetTime(Time):
	var _time = int(Time)
	$TimeLabel.text = 'Время: ' + str(_time)

func SetCheeseLife(Life):
	$CheeseLifeLabel.text = 'Сыры: ' + str(Life)

func CheckCheeseLive(Live):
	SetCheeseLife(Live)

func ShowePauseMenu(value:bool):
	if value:
		if PauseMenu == null:
			PauseMenu = PauseMenuScene.instance()
			PauseMenu.Gui = self
			add_child(PauseMenu)
	else:
		if PauseMenu != null:
			PauseMenu.queue_free()
			PauseMenu = null

func ShowStartMenu(value:bool):
	if value:
		if StartMenu == null:
			StartMenu = StartMenuScene.instance()
			StartMenu.Init(self, game_scene)
			add_child(StartMenu)
	else:
		if StartMenu != null:
			StartMenu.queue_free()
			StartMenu = null
