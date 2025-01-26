extends Camera2D

@export var movement_speed = 150
@export var level:Node2D
@onready var bubble: CharacterBody2D = $"../../Bubble"
var start_position = Vector2.ZERO

func _process(delta: float) -> void:
	if level.started:
		if not bubble.popped:
			position.y -= movement_speed * delta
			position.x = bubble.position.x
