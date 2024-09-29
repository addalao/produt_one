extends StaticBody2D

@export var group_name:String = "wall"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#groups
	add_to_group(group_name)
	pass # Replace with function body.
