extends CharacterBody2D

var speed = 0
var gravity = 100
var v_direction = 0
var h_direction = 0

var x_direction = 0
var y_direction = 0

func _process(_delta: float) -> void:
	speed = clamp(speed, 0, 600)
	speed = move_toward(speed, 0, 12.5)
	if speed == 0:
		set_process(false)

func _physics_process(delta: float) -> void:
	

	x_direction = Input.get_axis("ui_left", "ui_right")
	y_direction = Input.get_axis("ui_up", "ui_down")

	if not x_direction == 0:
		h_direction = x_direction
	if not y_direction == 0:
		v_direction = y_direction
		
	velocity.x = speed * h_direction
	velocity.y = speed * v_direction
	velocity.y -= gravity
	move_and_slide()

func _input(event: InputEvent) -> void:
	if Input.get_axis("ui_left", "ui_right") or Input.get_axis("ui_up", "ui_down"):
		if event.is_action_pressed("push"):
			speed += 150
			set_process(true)
