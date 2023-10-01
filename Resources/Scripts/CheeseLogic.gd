extends StaticBody2D

export(int) var MaxLive = 10
var CurrentLive = 10

signal CheeseBitten(Live);

func _ready():
	CurrentLive = MaxLive

func Bite():
	CurrentLive -= 1
	UpdateVisual()
	emit_signal("CheeseBitten",CurrentLive);

func SetMaxLife(value):
	MaxLive = value
	CurrentLive = value

func UpdateVisual():
	var procent = CurrentLive * 100 / MaxLive
	if procent < 100 and procent > 75:
		$AnimatedSprite.frame = 1
	elif procent < 75 and procent > 50:
		$AnimatedSprite.frame = 2
	elif procent < 50 and procent > 25:
		$AnimatedSprite.frame = 3
