extends Node2D

signal food_eaten
signal wall_hit

onready var head = get_node("Head")

enum {UP,DOWN,LEFT,RIGHT}
var direction = UP
var parts = []
var dontRemove = false
onready var part = load("res://Body.tscn")

onready var sprite = head.get_node("Sprite")

func _ready():
	parts.append(get_node("Body2"))
	parts.append(get_node("Body"))
	
func _process(delta):
	grab_input()

func grab_input():
	if Input.is_action_just_pressed("UP"):
		direction = UP
		sprite.frame = 1
	if Input.is_action_just_pressed("DOWN"):
		direction = DOWN
		sprite.frame = 3
	if Input.is_action_just_pressed("LEFT"):
		direction = LEFT
		sprite.frame = 4
	if Input.is_action_just_pressed("RIGHT"):
		direction = RIGHT
		sprite.frame = 2

func move():
	match direction:
		UP:
			head.position.y -= 16
		DOWN:
			head.position.y += 16
		LEFT:
			head.position.x -= 16
		RIGHT:
			head.position.x += 16
	pass
	
func _on_Timer_timeout():
	var p = part.instance()
	add_child(p)
	parts.append(p)
	p.position = head.position
	
	move()
	if dontRemove == false:
		parts[0].queue_free()
		parts.remove(0)
	elif dontRemove == true:
		dontRemove = false

func _on_Area2D_area_entered(area):
	if area.collision_layer == 1:
		emit_signal("food_eaten")
		dontRemove = true
	if area.collision_layer == 2:
		emit_signal("wall_hit")
