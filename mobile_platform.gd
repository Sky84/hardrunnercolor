extends BaseObject

@onready var start_position: Vector2 = position;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super();

# move the platform in like sinusoidale movement y 
func _process(delta: float) -> void:
	var position_in_percentage = (position + start_position) / get_viewport_rect().size;
	position.y = start_position.y - sin(position_in_percentage.x * 10) * 100;
