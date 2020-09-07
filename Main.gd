extends Node2D

onready var player = get_node("Snake")
onready var food = load("res://Food.tscn")
var curr_food

func _ready():
	curr_food = get_node("Food")
	randomize()

func _on_Snake_food_eaten():
	curr_food.queue_free()
	spawn_food()

func _on_Snake_wall_hit():
	get_tree().reload_current_scene()
	print("game over")

func spawn_food():
	var f = food.instance()
	call_deferred("add_child",f)
	
	get_node("Snake/Timer").wait_time -= 0.03
	curr_food = f
	f.position = Vector2(round(rand_range(2,18)),round(rand_range(2,9)))
	f.position = f.position*16
