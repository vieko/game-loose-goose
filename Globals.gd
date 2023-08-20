extends Node

# Constants
const Modes = { WALK = "walk", POOP = "poop", HOVER = "hover" }
const Groups = { DAMAGEABLES =  "damageables" }

# Variables
var startHealth: int = 3
var poopStarting: int = 10
var poopMax: int = 20
var walkingSpeed: float = 80
var cameraSpeed: float = 60

# Signals
signal on_player_health_changed(health)
signal on_poop_meter_changed(poop)
