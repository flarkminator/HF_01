"""
This is the interface for all States. This class doesn't do anything except
define the methods that all state must implement.
"""
extends Node

signal finished(next_state)

func enter():
	return

func exit():
	return

func handle_input(event):
	return

func update(delta):
	return

func _on_animation_finished(anim_name):
	return
