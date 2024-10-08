extends Player

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var rectangle_jump_collision: RectangleShape2D;
@export var rectangle_stand_collision: RectangleShape2D;

var _current_color_index: int = 0;

func on_first_play() -> void:
	super();
	set_physics_process(true);
	_play_animation("default");
	animated_sprite_2d.animation_looped.connect(on_score_should_increase);

func _ready() -> void:
	set_physics_process(false);
	_play_animation("idle", 1);
	
func _physics_process(delta: float) -> void:
	super(delta);
	if want_change_color:
		want_change_color = false;
		_current_color_index = (_current_color_index + 1) % game_rules.colors.size();
	if velocity.y == -jump_force:
		_play_animation("jump");
		collision_shape_2d.shape = rectangle_jump_collision;
	elif is_on_floor():
		_play_animation("default");
		collision_shape_2d.shape = rectangle_stand_collision;
		
	current_color = game_rules.colors[_current_color_index];
	# set the current color to shader parameter
	animated_sprite_2d.material.set_shader_parameter("current_color", current_color);

func _play_animation(animation_name: String, forced_speed_animation: float = 0.0) -> void:
	animated_sprite_2d.play(animation_name, forced_speed_animation || speed_animation);
