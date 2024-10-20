@tool
extends Node
class_name ControllerIconBindsContainer

@export var path: String = "":
	set(_path):
		path = _path
		_on_input_type_changed(ControllerIcons._last_input_type, ControllerIcons._last_controller)

@export var icon_texture_rect_packed: PackedScene
@export var seperator_packed: PackedScene

func _init():
	ControllerIcons.input_type_changed.connect(_on_input_type_changed)

func _ready() -> void:
	_on_input_type_changed(ControllerIcons._last_input_type, ControllerIcons._last_controller)

func _on_input_type_changed(input_type: int, controller: int):
	var count = ControllerIcons.get_matching_event_count(path, input_type, controller)
	for child in get_children():
		child.queue_free()
	
	for i in range(0, count):
		if i > 0 and seperator_packed != null:
			var seperator = seperator_packed.instantiate()
			add_child(seperator)
		
		if icon_texture_rect_packed != null:
			var icon: TextureRect = icon_texture_rect_packed.instantiate()
			icon.texture = icon.texture.duplicate()
			var texture: ControllerIconTexture = icon.texture
			texture.path = path
			texture.index = i
			add_child(icon)
	