extends RigidBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var power: float
var thrower: CharacterBody2D
func _ready():
	max_contacts_reported = 1
	contact_monitor = true

	apply_impulse(Vector2(power, 0), position)
	
	await get_tree().create_timer(2).timeout
	explosion_start()

func explosion_start():
	sleeping = true
	animated_sprite_2d.rotation = -rotation
	animated_sprite_2d.animation = 'explode'

func _on_animated_sprite_2d_animation_finished():
	if animated_sprite_2d.animation == 'explode':
		queue_free()

func _on_area_2d_body_exited(body):
	if body == thrower:
		self.collision_mask |= 0b100 # adding collision with player
