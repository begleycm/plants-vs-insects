extends Node

@export var map_length:int = 32
@export var map_height:int = 18

@export var start = [-(map_length / 2) + 1, -(map_height / 2)]
@export var end = [(map_length / 2) - 2, (map_height / 2) - 1]
var tile_map:TileMap

# Called when the node enters the scene tree for the first time.
func create_path(tile_map_main):
	tile_map = tile_map_main
	display_grass()
	
	#This generates a random number generator that is used to place blocks
	var rng = RandomNumberGenerator.new()
	spawn_blocks(rng)
	
	#Places a block for testing so I know where the path starts
	tile_map.set_cell(0, Vector2i(start[0], start[1]), 0, (Vector2i(3, 1)))
	tile_map.set_cell(0, Vector2i(end[0], end[1]), 0, (Vector2i(3, 1)))
	
func display_grass():
	# Places grass in the length x height(ex. 16x9)
	for n in range (-map_length / 2, map_length / 2):
		for i in range (-map_height / 2, map_height / 2):
			tile_map.set_cell(0, Vector2i(n, i), 0, (Vector2i(3, 0)))

'''This function spawns in blocks at random across the map. It places
1 block for every 10 on the map.'''
func spawn_blocks(rng:RandomNumberGenerator):
	var amount_blocks = (map_height * map_length) / 1
	
	for i in range (0, amount_blocks):
		# This places a block at random across the map
		var rand_l:int = rng.randf_range((-map_length / 2) - 1, map_length / 2)
		var rand_h:int = rng.randf_range((-map_height / 2) - 1, map_height / 2)
		
		'''This checks to see if the block placed will block the exit. If so, 
		it cannot be placed'''
		if is_placeable(rand_l, rand_h):
			tile_map.set_cell(0, Vector2i(rand_l, rand_h), 0, (Vector2i(6, 2)))
		
func is_placeable(rand_l:int, rand_h:int):
	var can_place:bool = true
	
	var path_alg = PathAlg.new()
	
	var current_block_texture = tile_map.get_cell_atlas_coords(0, Vector2i(rand_l, rand_h))
	'''If current block has a block already OR you can't reach the end by 
	placing this block, return false'''
	if (current_block_texture == Vector2i(6, 2) or
	 !path_alg.can_reach_end(tile_map, start, end)):
		can_place = false
	
	return can_place
	
