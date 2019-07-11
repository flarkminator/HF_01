extends Node


signal scene_instanced( scene )
signal scene_set_as_current()

#func _ready():
#	var root = get_tree().get_root()
#
#	# Global scripts are also children of root, so the last child of root is
#	# always the loaded scene.
#	current_scene = root.get_child(root.get_child_count() - 1)


func goto_scene_path(target_scene_path, params = null):
	"""
	This loads a scene based upon it's reletive path
	We must call this deferred, as the current scene will be deleted and it
	might be running code
	"""
	call_deferred("_deferred_goto", target_scene_path, params, "_get_node_from_path")


func goto_scene_packed(target_scene_pak, params = null):
	"""
	This loads a packed scene. It defers the call.
	"""
	call_deferred("_deferred_goto", target_scene_pak, params, "_get_node_from_pack")


func _deferred_goto(target, params, get_node_function):
	"""
	The steps to this function are as follows:
		1. If target is null, delete current scene and bail
		2. Get the new scene using the appropriate method
		   (we could have been passed a PATH STRING or a PACKED SCENE)
		3. Delete the current_scene
		4. Attach a call_back signal, so we can capture the moment it's added
		5. Add it to the root
	"""
#	If we pass in a null target, it will simply delete the current scene
	if target == null:
		if get_tree().current_scene:
			get_tree().current_scene.free()
		assert( get_tree().current_scene == null )
		return
	
	var new_scene = call( get_node_function, target) # Either it's a path, or a packed scene
	if new_scene:
		emit_signal( "scene_instanced", new_scene )
	else: # If instantiation fails, current_scene will not change
		return 
	
	if get_tree().current_scene:
		get_tree().current_scene.free()
	assert( get_tree().current_scene == null )
	
	# Make it a current scene between its "_enter_tree()" and "_ready()" calls
	# THIS IS SUPER IMPORTANT. It's kind of a hack, but there's no other way to capture this moment
	new_scene.connect("tree_entered", self, "_set_as_current", [new_scene], CONNECT_ONESHOT)
	
	# Add this to the active scene, as a child of root
	get_tree().get_root().add_child( new_scene )
	assert( get_tree().get_root().has_node( new_scene.get_path() ) )


func _set_as_current( new_scene ):
	print( "getting here" )
	get_tree().set_current_scene( new_scene )
	assert( get_tree().current_scene == new_scene )
	emit_signal( "scene_set_as_current" )

func _get_node_from_path(path):
	var node = ResourceLoader.load( path )
	return node.instance() if node else null


func _get_node_from_pack(packed_scene):
	return packed_scene.instance() if packed_scene.can_instance() else null

#
#func goto_scene(path):
#	"""
#	This function will usually be called from a signal callback, or some other
#	function in the current scene. Deleting the current scene at this point is
#	a bad idea, because it may still be executing code. This will result in a
#	crash or unexpected behavior.
#	The solution is to defer the load to a later time, when we can be sure that
#	no code from the current scene is runing.
#	"""
#
#	call_deferred("_deferred_goto_scene", path)
#
#
#func _deferred_goto_scene(path):
#	# It is now safe to remove the current scene
#	current_scene.free()
#
#	# Load the new scene and instanciate it.
#	current_scene = ResourceLoader.load(path).instance()
#
#
#
#	# Add it to the active scene, as a child of root
#	get_tree().get_root().add_child(current_scene) # _ready() is called here!!!!!!!!
#
#	# Make it compatible with SceneTree.change_scene() API ?
#	get_tree().set_current_scene(current_scene)