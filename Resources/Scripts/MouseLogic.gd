extends KinematicBody2D

enum States{idle, go_to_cheese, go_home, grab, go_scary}
var CurrentState = States.idle
#----Доступные состояния: idle, go, scary, grab

export(float, 0, 6) var MaxMouseSpeed = 6
export(float, 0, 6) var CurrentSpeed = 3
export(States) var StartState

var Target = null
var Speed = 0
var Velocity = null
#----Переменные собсвенных объектов----
var PortableObject = null
var world = null
#----Тестовые переменные----
var HomeLocation = null
var SpawnLocation = null

func _ready():
	set_process_input(true)
	Velocity = Vector2(0,0)
	Speed = CurrentSpeed
	CurrentState = StartState
	world = find_parent('*')

func _physics_process(delta):
	PlayState()

#----Функции----

func SetSpeed(NewSpeed:float):
	Speed = NewSpeed

func Move(TargetPosition:Vector2):
	Velocity = (TargetPosition - position).normalized() * Speed
	move_and_collide(Velocity)

func GrabObject(Obj):
	PortableObject = Obj
	add_child(Obj)

func DropObject():
	world.add_child(PortableObject)
	PortableObject = null

func PlayState():
	match CurrentState:
		States.idle:
			Processing_idle()
		States.go_to_cheese:
			Processing_go_to_cheese()
		States.go_home:
			Processing_go_home()
		States.grab:
			Processing_grab()
		States.go_scary:
			Processing_go_scary()

#----Состояние движения к сыру----
func Set_go_to_cheese(Cheese):
	Target = Cheese
	if CurrentState == States.idle:
		print('Мышь пошла за сыром')
		CurrentState = States.go_to_cheese
	else:
		print('Ошибка мышиной логики')

func Processing_go_to_cheese():
	Move(Target.position)
	var length = (Target.position - position).length()
	if length < 5:
		Set_grab(Target)

#----Состояние подбора сыра----
func Set_grab(Obj):
	Target = Obj
	if CurrentState == States.go_to_cheese:
		print('Мышь хватает сыр')
		CurrentState = States.grab
	else:
		print('Ошибка мышиной логики(grab)')

func Processing_grab():
	Target.Bite()
	Set_go_home()

#---Состояние убегания за экран----
func Set_go_home():
	if CurrentState == States.grab:
		print('Мышь с сыром собирается домой')
		CurrentState = States.go_home
	elif CurrentState == States.go_to_cheese:
		print('Mышь идет домой без сыра')
		CurrentState = States.go_home 
	else:
		print('Ошибка мышиной логики(home)')

func Processing_go_home():
	Move(HomeLocation)
	var length = (HomeLocation - position).length()
	if length < 5:
		queue_free()

#----Состояние ожидания----
func Set_idle():
	pass

func Processing_idle():
	pass

#----Состояние убегания в страхе----
func Set_go_scary():
	$Particles2D.emitting = true
	Speed = MaxMouseSpeed
	if CurrentState == States.grab:
		print('Мышь не успевает взять сыр и в страхе убегает')
		CurrentState = States.go_scary
	elif CurrentState == States.go_to_cheese:
		print('Mышь в страхе убегает')
		CurrentState = States.go_scary
	elif CurrentState == States.go_home:
		print('Мышь бросает сыр и в страхе убегает')
		#Вствить выбрасывание сыра
		CurrentState = States.go_scary
	elif CurrentState == States.go_scary:
		pass
	else:
		print('Ошибка мышиной логики(scary)')

func Processing_go_scary():
	Move(SpawnLocation)
	var length = (SpawnLocation - position).length()
	if length < 5:
		queue_free()

func _on_InteractiveZone_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == 1:
			Set_go_scary()
