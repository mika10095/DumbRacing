extends Node2D
var move_counter:int = 0
@onready var checkpoint_manager = %CheckpointManager
@onready var map = %Map
@onready var car_sprite = $CarOffset/Sprite2D
@onready var car_offset = $CarOffset
@export var start_pos_offset:Vector2
var current_pos:Vector2
var current_checkpoint:int = 0
@export var is_manual:bool = false
@export var is_automatic:bool = false
var moves:Array[Vector2] = []
@export var speed:Vector2
var crashed:bool = false
func randomize_position()->void:
	car_offset.position = Vector2(randf()*3,randf()*3)
	car_sprite.skew = deg_to_rad(randf_range(-5,5))
	car_sprite.rotation = deg_to_rad(randf_range(-5,5))
func _ready():
	car_sprite.set_self_modulate(Color(randf(),randf(),randf()))
	randomize_position()
func move() -> bool:
	move_counter+=1
	randomize_position()
	if(!crashed):
		print("old position:" + str(current_pos) + "speed" + str(speed))
		self.global_position += speed * 16
		current_pos += speed
		print("new position:" + str(current_pos) + "tile under new pos:" + str(map.get_cell_atlas_coords(current_pos+start_pos_offset)))
		if map.checkmove(current_pos+start_pos_offset):
			print("You have crashed")
			crashed = true
			map.set_cell(current_pos+start_pos_offset,0,Vector2(7,0))
			return false
		print("previous checkpoint " + str(current_checkpoint))
		current_checkpoint = checkpoint_manager.check_checkpoint(current_checkpoint,current_pos,speed)
		print("current checkpoint " + str(current_checkpoint))
		return true
	elif(is_manual):
		get_tree().reload_current_scene()
	return false
func _physics_process(delta):
	if is_manual:
		if Input.is_action_just_pressed("ui_right"):
			speed += Vector2(1,0)
			move()
		elif Input.is_action_just_pressed("ui_left"):
			speed += Vector2(-1,0)
			move()
		elif Input.is_action_just_pressed("ui_up"):
			speed += Vector2(0,-1)
			move()
		elif Input.is_action_just_pressed("ui_down"):
			speed += Vector2(0,1)
			move()
		elif Input.is_action_just_pressed("skip"):
			speed += Vector2(0,0)
			move()
	elif is_automatic:
		if Input.is_action_just_pressed("skip"):
			move()
func _load_moves(moves:PackedVector2Array):
	is_manual = false
	is_automatic = true
	
