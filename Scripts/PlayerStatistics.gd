class_name PlayerStatistics
extends Resource

@export var gender = Gender.FEMALE;
@export var speed: float = 150.0
@export var sprintMultiplier: float = 1.8;
@export var currentMap: String = "";
@export var previousMap: String = "";
@export var position: Vector2 = Vector2.ZERO;
@export var lastMapPositions: Dictionary = {};
