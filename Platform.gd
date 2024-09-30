@tool
extends AnimatableBody2D

@export var tile_map_platform: TileMapLayer;

var platform_type: Color:
	get:
		return _platform_type;
	set(value):
		if tile_map_platform:
			_platform_type = value;
			# duplicate material to lose ref
			tile_map_platform.material = tile_map_platform.material.duplicate();
			# set shader parameters glow color by platform type
			tile_map_platform.material.set_shader_parameter("current_color", _platform_type);
		else:
			printerr("tile_map_platform is null");
			

var _platform_type: Color;

@onready var platform_width = $CollisionShape2D.shape.get_rect().size.x;
