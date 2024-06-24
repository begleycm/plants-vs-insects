extends Node2D

@export var map_length:int = 32
@export var map_height:int = 18

@export var start = [-(map_length / 2), -(map_height / 2)]
@export var end = [(map_length / 2) - 1, (map_height / 2) - 1]

var start_mark:Marker2D

var tile_map:TileMap

func create_map(map, start_m):
	tile_map = map
	start_mark = start_m
	
	display_grass()

	tile_map.set_layer_navigation_enabled(0, true)
	
	var rng = RandomNumberGenerator.new()
	spawn_blocks(rng)
	
	tile_map.set_cell(0, Vector2i(start[0], start[1]), 0, Vector2i(3, 1))
	tile_map.set_cell(0, Vector2i(end[0], end[1]), 0, Vector2i(3, 1))
	
	spawn_start()

func display_grass():
	for n in range(-map_length / 2, map_length / 2):
		for i in range(-map_height / 2, map_height / 2):
			tile_map.set_cell(0, Vector2i(n, i), 0, Vector2i(3, 0))

func spawn_blocks(rng:RandomNumberGenerator):
	var amount_blocks:int = (map_height * map_length) / 4
	
	for i in range(0, amount_blocks):
		var rand_l:int = rng.randf_range((-map_length / 2) - 1, map_length / 2)
		var rand_h:int = rng.randf_range((-map_height / 2) - 1, map_height / 2)
		
		tile_map.set_cell(0, Vector2i(rand_l, rand_h), 0, Vector2i(6, 2))
			
func spawn_start():
	start_mark.position = Vector2i(start[0] * 16, start[1] * 16)

func is_end_reachable():
	var nav_test = NavigationAgent2D.new()
	var vec = Vector2(end[0] * 16, end[1] * 16)
	nav_test.target_position = vec
	
	start_mark.add_child(nav_test)
	
	nav_test.debug_enabled = true
	
	return nav_test.is_target_reachable()
