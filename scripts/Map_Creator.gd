extends Node2D

@export var map_length:int = 32
@export var map_height:int = 18

@export var start = [-(map_length / 2) + 1, -(map_height / 2)]
@export var end = [(map_length / 2) - 2, (map_height / 2) - 1]

@onready var start_place = get_node("start_place")
var tile_map:TileMap

# Called by main to make the map
func create_map(map):
	tile_map = map
	
	display_grass()
	
	spawn_start()

	#Enables navigation for layer 0
	tile_map.set_layer_navigation_enabled(0, true)
	
	
	#Random number generator that is used to place blocks
	var rng = RandomNumberGenerator.new()
	spawn_blocks(rng)
	
	#Places test blocks
	tile_map.set_cell(0, Vector2i(start[0], start[1]), 0, (Vector2i(3, 1)))
	tile_map.set_cell(0, Vector2i(end[0], end[1]), 0, (Vector2i(3, 1)))
	
func display_grass():
	# Places grass in the length x height(ex. 16x9)
	for n in range (-map_length / 2, map_length / 2):
		for i in range (-map_height / 2, map_height / 2):
			tile_map.set_cell(0, Vector2i(n, i), 0, (Vector2i(3, 0)))

'''
This function spawns in blocks at random across the map. It places
1 block for every 10 on the map.
'''
func spawn_blocks(rng:RandomNumberGenerator):
	var amount_blocks = (map_height * map_length) / 10
	
	for i in range (0, amount_blocks):
		# This places a block at random across the map
		var rand_l:int = rng.randf_range((-map_length / 2) - 1, map_length / 2)
		var rand_h:int = rng.randf_range((-map_height / 2) - 1, map_height / 2)
		
		'''
		This checks to see if the block placed will block the exit. If so, 
		it cannot be placed
		'''
		if is_placeable(rand_l, rand_h):
			tile_map.set_cell(0, Vector2i(rand_l, rand_h), 0, (Vector2i(6, 2)))
		
func is_placeable(rand_l:int, rand_h:int):
	var can_place:bool = true
	
	var path_alg = PathAlg.new(tile_map, start, end)
	# If you can't reach the end after placing this block, don't allow it
	if !path_alg.can_reach_end():
		can_place = false
	
	return can_place
	
func spawn_start():
	var start_sprite = Sprite2D.new()
	start_sprite.texture = load("res://assets/darktile.png")
	start_sprite.position = Vector2(start[0], start[1])
	
	# Explicitly get the node
	var target_node = get_node("res://scenes/main.tscn")
	#print(target_node.get_path())
	
	# Check if the node is valid
	if target_node:
		print("Adding sprite...")
		target_node.add_child(start_sprite)
		print("Sprite addded!")
	else:
		print("Error: Target node is null or invalid")
