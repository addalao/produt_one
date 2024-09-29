extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -800.0
var node:AnimatedSprite2D
var jumpId: int = 0

func _ready() -> void:

	node = $MyA
	node.centered = true
	
# 二段跳
func twiceJump()-> void:
	if sartFrame != 0 :
		return
	if !is_on_wall() :
		return
	var co = get_slide_collision(0)
	var id = co.get_collider_id()
	if  jumpId != 0 && id == jumpId:
		return;
	jumpId = id;
	#var coNode:Node = co.get_collider()
	flip = node.flip_h
	node.flip_h = !node.flip_h
	wallDeltaFrame = 20
	velocity.y = JUMP_VELOCITY / 1.1

func playNode():
	if node.is_playing() :
		return
	node.play("run")

#蹬墙跳要执行的帧数
var wallDeltaFrame := 0

#记录起跳之后的帧数
var sartFrame := 0;

var flip = false;

func _physics_process(delta: float) -> void:
	if sartFrame > 0:
		sartFrame -= 1
		
	if wallDeltaFrame > 0:
		var s = 1 * SPEED * 3
		velocity.x = s if flip  else -s
		wallDeltaFrame -= 1
	
	#空格是否被按下
	var accept := Input.is_action_just_pressed("ui_accept")
	
	#是否在地板上
	var is_on_floor := is_on_floor();
	
	
	if !is_on_floor :
		velocity += get_gravity() * delta * 2
	else :
		jumpId = 0
	
	
	if accept :
		
		if is_on_floor :
			#开始的几帧内不准二段跳
			sartFrame = 10
			velocity.y = JUMP_VELOCITY 
		else :
			twiceJump()
					
	var left_direction := Input.is_action_pressed("ui_left") 
	var right_direction := Input.is_action_pressed("ui_right")
	if right_direction:
		if(node.flip_h):
			node.flip_h = false

		playNode()
		if wallDeltaFrame<=10 :
			velocity.x = 1 * SPEED * 2
	elif left_direction:
		if(!node.flip_h):
			node.flip_h = true
		playNode()
		if wallDeltaFrame<=10 :
			velocity.x = -(1 * SPEED * 2)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if (!accept):
			node.stop()

	move_and_slide()
