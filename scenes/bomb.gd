extends RigidBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var power: float

func _ready():
	apply_impulse(Vector2(power, 0), position)
	
	await get_tree().create_timer(3.0).timeout
	explosion_start()

func explosion_start():
	rotation_degrees = 0
	lock_rotation = true
	animated_sprite_2d.animation = 'explode'

func _on_animated_sprite_2d_animation_finished():
	if animated_sprite_2d.animation == 'explode':
		queue_free()
