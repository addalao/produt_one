extends RigidBody2D

var speed = 4
var angular_speed = PI
var widgetSize:Vector2 =  Vector2.ZERO

func  _ready() -> void:
	var widget = $Sprite2D
	widgetSize = widget.get_rect().size * widget.scale
	



func _process(_d: float) -> void:

	var direction = 0
	if Input.is_action_pressed("move_left"):
		direction = -1
	if Input.is_action_pressed("move_right"):
		direction = 1
		

	rotation +=((angular_speed * direction ) / 70)


	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		velocity = Vector2.UP.rotated(rotation) * speed

	if Input.is_action_pressed("move_down"):
		velocity = Vector2.DOWN.rotated(rotation) * speed
		
	var p = position + velocity;

	p.x = fmod(p.x,1152 + widgetSize.x)
	if p.x <= 0 -widgetSize.x:
		p.x = 1152 + widgetSize.x
		
	p.y = fmod(p.y,648 + widgetSize.y)
	if p.y <= 0 -widgetSize.y:
		p.y = 648 + widgetSize.y
	
	position = p
	
	
