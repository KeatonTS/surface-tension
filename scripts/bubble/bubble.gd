extends CharacterBody2D

@onready var pop_sfx: AudioStreamPlayer = $SFX/Pop
@onready var swim_sfx: AudioStreamPlayer = $SFX/Swim
@onready var screen_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

@export var level: Node2D

var speed = 0
var gravity = 100
var v_direction = 0
var h_direction = 0
var x_direction = 0
var y_direction = 0
var popped = false
var in_danger = false

func _process(_delta: float) -> void:
	speed = clamp(speed, 0, 400)
	speed = move_toward(speed, 0, 8)
	if speed == 0:
		set_process(false)

func _physics_process(delta: float) -> void:

	x_direction = Input.get_axis("left", "right")
	y_direction = Input.get_axis("up", "down")

	if not popped:
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
		if event.is_action_pressed("push") and not popped:
			swim_sfx.volume_db = randi_range(-10, -5)
			swim_sfx.pitch_scale = randf_range(0.8, 1.2)
			swim_sfx.play()
			speed += 125
			set_process(true)

func respawn():
	await get_tree().create_timer(2, false).timeout
	show()
	level.camera_2d.position_smoothing_speed = 1
	gravity = 100
	popped = false

func pop():
	if popped:
		return
	popped = true
	pop_sfx.play()
	gravity = 0
	hide()
	level.reset()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	in_danger = true
	await get_tree().create_timer(1, false).timeout
	if not screen_notifier.is_on_screen() and not popped or not in_danger:
		pop()


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	in_danger = false
