extends Panel


@onready var buttons_container: HFlowContainer = $HFlowContainer;

var _last_pressed_id: String;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in buttons_container.get_children():
		child.pivot_offset = child.size / 2;
		child.get_child(0).modulate.a = 0;
		child.pressed.connect(_on_child_pressed.bind(child))

func _on_child_pressed(child: MainMenuButton) -> void:
	# expand the child and reduce the size of the other childs
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT);
	tween.set_parallel(true);
	for other_child in buttons_container.get_children():
		other_child.z_index = 0 if other_child != child else 1;
		if other_child != child:
			tween.tween_property(other_child.get_child(0), "modulate:a", 0, 0.2);
			tween.tween_property(other_child, "scale", Vector2(1,1), 0.2);
	if child.id == _last_pressed_id:
		_on_confirm_pressed(_last_pressed_id);
		return;
	tween.tween_property(child, "scale", Vector2(1.2, 1.2), 0.2);
	tween.tween_property(child.get_child(0), "modulate:a", 1, 0.2);
	_last_pressed_id = child.id;

func _on_confirm_pressed(button_id: String):
	match button_id:
		"infinite":
			var tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT);
			tween.tween_property(self, "modulate:a", 0, 0.2);
			MenuEventsBus.on_infinite_button_clicked.emit();
