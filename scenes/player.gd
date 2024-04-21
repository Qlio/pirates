extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var power_bar = $PowerBar

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

signal bomb_created(player)

var bomb_timer_start
func _process(_delta):
	if Input.is_action_just_pressed("bomb"):
		power_bar.visible = true
		bomb_timer_start = Time.get_ticks_msec()

	if Input.is_action_just_released("bomb"):
		power_bar.visible = false
		var now = Time.get_ticks_msec()
		var power = (now - bomb_timer_start) * (-1 if velocity.x < 0 else 1)
		bomb_created.emit(self, power)
	
func _physics_process(delta):
	if velocity.x > 0 || velocity.x < 0:
		animated_sprite_2d.animation = 'run'
	else:
		animated_sprite_2d.animation = 'idle'

	if not is_on_floor():
		velocity.y += gravity * delta
		animated_sprite_2d.animation = 'jump'

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED / 10)

	move_and_slide()

	var is_left = velocity.x < 0
	animated_sprite_2d.flip_h = is_left
