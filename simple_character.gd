extends Player

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var rectangle_jump_collision: RectangleShape2D;
@export var rectangle_stand_collision: RectangleShape2D;

var _current_color_index: int = 0;

func _ready() -> void:
	animated_sprite_2d.play("default");
	
func _physics_process(delta: float) -> void:
	super(delta);
	if want_change_color:
		want_change_color = false;
		_current_color_index = (_current_color_index + 1) % game_rules.colors.size();
	if velocity.y == -jump_force:
		animated_sprite_2d.play("jump");
		collision_shape_2d.shape = rectangle_jump_collision;
	elif is_on_floor():
		animated_sprite_2d.play("default");
		collision_shape_2d.shape = rectangle_stand_collision;
		
	current_color = game_rules.colors[_current_color_index];
	# set the current color to shader parameter
	animated_sprite_2d.material.set_shader_parameter("current_color", current_color);
