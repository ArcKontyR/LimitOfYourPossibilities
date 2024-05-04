extends CharacterBody2D

signal teleportInitiate;

var stats: PlayerStatistics = PlayerStatistics.new();

@onready var inventory: UIInventory = get_parent().get_node("UI/Inventory");
@onready var task: TaskContainer = get_parent().get_node("UI/TaskContainer");
var animationTree: AnimationTree;

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: float;
var currentSpeed = stats.speed;

func _ready():
	animationTree = $WAnimationTree if GlobalSettings.playerGender == GlobalSettings.Gender.FEMALE else $MAnimationTree;
	animationTree.active = true;
	
func _process(_delta):
	_animationUpdate();
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle jump.
	# No jump for you, fatty
	#if Input.is_action_just_pressed("up") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
	
	currentSpeed = stats.speed;
	if Input.is_action_pressed("sprint"):
		currentSpeed *= stats.sprintMultiplier;

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * currentSpeed
	else:
		velocity.x = move_toward(velocity.x, 0, currentSpeed)

	move_and_slide()

func _input(_event):
	if (Input.is_action_just_pressed("interact") && has_meta("collidesWith")):
		var interactedItem = get_meta("collidesWith");
		print(interactedItem);
		if (interactedItem is UIItem):
			print("Collides with: %s" % interactedItem.item.title);
			var isAdded = inventory.addItem(interactedItem.item.uniqueId);
			if isAdded:
				interactedItem.disable();
		if (interactedItem is Teleport):
			print("Is teleport")
			teleportInitiate.emit(interactedItem);
		#set_meta("collidesWith", null)

func _animationUpdate():
	if direction == 0:
		animationTree["parameters/conditions/idle"] = true;
		animationTree["parameters/conditions/isMoving"] = false;
	else:
		animationTree["parameters/conditions/idle"] = false;
		animationTree["parameters/conditions/isMoving"] = true;
		
	if direction != 0:
		animationTree["parameters/Idle/blend_position"] = direction;
		animationTree["parameters/Walk/blend_position"] = direction;
