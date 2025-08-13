extends RigidBody2D
## Abstract base class for all "Ball" objects.
class_name ball


@export var force : int = 100 ## The force at which the ball will move.
@export var friction : float = 15 ## Friction coefficient.
@export var team : int = 0 ## Color of the ball. 0 means red, 1 means blue.
@export var opponent : ball ## Gives access to opponent node.


@onready var redBallSprite = $redBall
@onready var blueBallSprite = $blueBall


var falling : bool = false ## Whether or not the player has been ejected from the arena and is falling into the abyss.
# Set properties:
var dir : float = 0.0 ## Movement direction, in degrees.
# Get properties:
var opDir : float = 0.0 ## Opponent movement direction, in degrees.
var pos : Vector2 = Vector2.ZERO ## Position, in pixels.
var opPos : Vector2 = Vector2.ZERO ## Opponent position, in pixels.
var velocity : Vector2 = Vector2.ZERO ## Linear velocity in pixels per second.
var opVelocity : Vector2 = Vector2.ZERO ## Opponent linear velocity in pixels per second.


const centerOffset : Vector2 = Vector2(576, 324) ## Offset of the arena's (0, 0) from the actual (0, 0).


func _ready() -> void:
	if team == 0:
		blueBallSprite.hide()
	else:
		redBallSprite.hide()


func _physics_process(_delta: float) -> void:
	var frameForce : Vector2 = Vector2(cos(rad(dir)), sin(rad(dir)) * -1) * force  # Calculate force from input degree measure (dir) to be applied this frame.
	var frictionForce : Vector2 = linear_velocity.normalized() * -1 * friction # Calculate friction force to be applied this frame.
	apply_central_force(frameForce)
	apply_central_force(frictionForce)
	# Update property variables.
	opDir = opponent.dir
	pos = Vector2(position.x, position.y * -1) - centerOffset
	opPos = Vector2(opponent.position.x, opponent.position.y * -1) - centerOffset
	velocity = Vector2(linear_velocity.x, linear_velocity.y * -1)
	opVelocity = Vector2(opponent.linear_velocity.x, opponent.linear_velocity.y * -1)
	# Visually shrink if falling into the abyss
	if falling:
		blueBallSprite.scale *= 1.2
		redBallSprite.scale *= 1.2

## Methodised conversion of degrees to radians.
func rad(degrees : float):
	return degrees * (PI/180)

## Methodized conversion of radians to degrees.
func deg(rads : float):
	return rads * (180/PI)

## Methodized conversion of vector to direction, in degrees.
func directionalize(vector : Vector2):
	vector = vector.normalized()
	if vector.y == 0: # Special case considered to avoid dividing by zero.
		return deg(acos(vector.x))
	else:
		return deg(acos(vector.x)) * asin(vector.y)/abs(asin(vector.y)) * -1

## Ejects the ball from the arena.
func eject() -> void:
	apply_central_impulse((position - centerOffset) * 3)
	falling = true
