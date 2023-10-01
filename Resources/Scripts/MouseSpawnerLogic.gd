extends Node

export(float) var SpawnPeriod
export(float) var MinMouseSpeed = 1
export(float) var MaxMouseSpeed = 5
export(Array, Vector2) var Points
export(PackedScene) var MouseObject
export(NodePath) var MainScenePath
export(NodePath) var Cheese


var SpawnTimer
var MainScene
var rng = RandomNumberGenerator.new()

func _ready():
	randomize()
	SpawnTimer = $Timer;
	MainScene = get_node(MainScenePath)
	$Timer.wait_time = SpawnPeriod
	$Timer.start()

func SpawnMouse():
	$MousePath/MouseSpawnLocation.offset = randi()
	$MousePath/MouseHomeLocation.offset = randi()
	var NewMouse = MouseObject.instance()
	MainScene.add_child(NewMouse)
	NewMouse.position = $MousePath/MouseSpawnLocation.position
	NewMouse.SetSpeed(rng.randf_range(MinMouseSpeed,MaxMouseSpeed))
	NewMouse.HomeLocation = $MousePath/MouseHomeLocation.position
	NewMouse.SpawnLocation = $MousePath/MouseSpawnLocation.position
	NewMouse.Set_go_to_cheese(get_node(Cheese))

func _on_Timer_timeout():
	SpawnMouse()
