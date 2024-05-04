extends Node
enum Gender{
	MALE = 0,
	FEMALE = 1
}

@export var playerGender = GlobalSettings.Gender.FEMALE;
@export var save: SaveGame;
