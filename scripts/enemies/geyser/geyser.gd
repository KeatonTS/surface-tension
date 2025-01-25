extends Sprite2D
@export var direction: String = "Left"
@export var player: CharacterBody2D
@onready var area_2d = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if area_2d.overlaps_body(player):
		if direction == "Left":
			player.h_direction = 1
			player.speed += 5
		if direction == "Right":
			player.h_direction = -1
			player.speed += 5

func _on_area_2d_body_entered(body):
	if body.name == "Bubble":
		set_physics_process(true)

func _on_area_2d_body_exited(body):
	if body.name == "Bubble":
		body.h_direction = 0
		body.v_direction = 0
		body.speed = 0
		set_physics_process(false)
