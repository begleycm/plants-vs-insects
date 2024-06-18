extends Node

@export var path_tile:PackedScene

@export var map_length:int = 16
@export var map_height:int = 9

var _pg:PathGenerator

# Called when the node enters the scene tree for the first time.
func _ready():
	_pg = PathGenerator.new(map_length, map_height)
	print(_pg.generate_path())
	_display_path()

func _display_path():
	var _path:Array[Vector2i] = _pg.generate_path()
	print(_path)
	# Places tiles
	for element in _path:
		var tile:Node2D = path_tile.instantiate()
		add_child(tile)
		tile.global_position = Vector2(element.x, element.y)
