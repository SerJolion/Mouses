extends Node

export(int) var Second_to_win
export(NodePath) var Cheese_path

var world = null
var CheeseObj = null

func _ready():
	world = find_parent('*')
	CheeseObj = get_node(Cheese_path)
	$WinTimer.wait_time = Second_to_win
	$WinTimer.start()
	CheeseObj.connect('CheeseBitten',self,"FailConditionCheck")

func _input(event):
	pass

func FailConditionCheck(Health):
	if Health <= 0:
		print('Вы проиграли!')
		get_tree().quit()

func _on_WinTimer_timeout():
	print('Вы выйграли!')
	get_tree().quit() # default behavior
