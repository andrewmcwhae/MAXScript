/*  
  Camera Ring Tool
  Andrew McWhae, 2014

  A tool to create VRay Physical Cameras around a ring of specified radius, at a specified height
  
  Features:
  The cameras are named Camera_0, Camera_1, Camera_2 and so on
  Camera_0 is the front view, Camera_1 is to the left of it and so on
  The cameras have the same wirecolor
  Spinners are interactive
*/

fn createCams radius count height =
(
	-- create empty array to add cameras to
	local cam_array = #()
	
	-- create initial camera
	cam = vrayphysicalcamera name:("Camera_0") transform:(matrix3 [0,1,0] [0,0,1] [1,0,0] [0,-radius,height]) \
	target:(Targetobject transform:(matrix3 [1,0,0] [0,1,0] [0,0,1] [0,0,0])) whiteBalance_preset:1 \
	iso:800 vignetting:off
	append cam_array cam
	
	-- variables for creating ring
	cam_colour = cam.wirecolor -- necessary so that the instances to have the same wire colour
	increment = 360/count as float -- angle for each increment
	
	-- instance initial camera around circle
	for i in 1 to count-1 do
	(
		cam_x = -sin(increment*i)
		cam_y = -cos(increment*i)
		current_cam = instance cam name:("Camera_" + i as string) transform:(matrix3 [0,1,0] [0,0,1] [1,0,0] [cam_x*radius,cam_y*radius,height]) \
		wirecolor:cam_colour
		append cam_array current_cam
	)
	
	return cam_array
)

rollout vrayCamRing "VRay Camera Ring" 
(
	--create empty array
	local gui_array = #()
	
	-- define the UI parameters
	spinner radius "Radius of ring: " type:#float range:[1,500,50]
	spinner count "Number: " type:#integer range:[1,360,8]
	spinner height "Height: " type:#float range:[-500,500,0]
	button create "Create ring of cameras"
	button del "Delete ring of cameras"
	
	-- define button actions
	on create pressed do
		gui_array = createCams radius.value count.value height.value
	
	on del pressed do
		if gui_array != undefined then delete gui_array
	
	-- create interactivity
	on count changed val do
	(
		delete gui_array
		create.pressed()
	)
	
	on radius changed val do
	(
		for i in 1 to gui_array.count do
		(
			old_angle = atan2 gui_array[i].pos.x gui_array[i].pos.y
			
			gui_array[i].pos.x = sin(old_angle) * radius.value
			gui_array[i].pos.y = cos(old_angle) * radius.value
		)
	)
	
	on height changed val do
	(
		for i in 1 to gui_array.count do
			gui_array[i].pos.z = height.value
	)
)

createDialog vrayCamRing width:230