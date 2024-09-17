extends Node2D
@export var checkpoints:Array[Vector2] = []
func check_checkpoint(current_checkpoint:int, car_pos:Vector2, car_speed:Vector2)->int:
	if current_checkpoint >= checkpoints.size()-1:
		print_debug("Winner?")
		return 99
	
	return current_checkpoint
func checkpoint_counter(current_checkpoint:int)->int:
	return current_checkpoint+1
