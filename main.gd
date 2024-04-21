extends Node

const Bomb = preload("res://scenes/bomb.tscn")

func create_bomb(player: CharacterBody2D, power: float):
	var bomb = Bomb.instantiate();
	bomb.power = power
	bomb.position = player.position
	add_child(bomb)

func _on_character_body_2d_bomb_created(player: CharacterBody2D, power: float):
	create_bomb(player, power)
