class_name PathAlg

var tile_map:TileMap
var start:Array
var end:Array
var current:Array
var grass:Vector2i

# Called when the node enters the scene tree for the first time.
func _init(tile_map:TileMap, start:Array, end:Array):
	self.tile_map = tile_map
	self.start = start
	self.end = end
	self.current = start.duplicate()
	self.grass = Vector2i(3, 0)

'''Returns true if the path can be reached, false if not'''
func can_reach_end():
	var end_open:bool = true
	
	return end_open
	




#func is_grass(new_tile:Vector2i):
	#return (grass.x == new_tile.x) and (grass.y == new_tile.y)

#func search():
	#if (current == end):
		#return
	## If tile to right is grass, go there
	#if (is_grass(tile_map
	#.get_cell_atlas_coords(0, Vector2i(current[0] + 1, current[1])))):
		#current[0] += 1
		#print("right")
	## If tile below is grass, go there
	#elif (is_grass(tile_map
	#.get_cell_atlas_coords(0, Vector2i(current[0], current[1] + 1)))):
		#current[1] += 1
		#print("down")
	## If tile to left is grass, go there
	#elif (is_grass(tile_map
	#.get_cell_atlas_coords(0, Vector2i(current[0] - 1, current[1])))):
		#current[0] -= 1
		#print("left")
	## If tile above is grass, go there
	#elif (is_grass(tile_map.get_cell_atlas_coords(0, Vector2i(current[0], current[1] - 1)))):
		#current[1] -= 1
		#print("up")
	#search()
	#
