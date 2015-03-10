scriptId = 'com.osman.NFS13.v1'
scriptTitle='The Need For Speed Most Wanted (2013) Connector'
scriptDetailsUrl='https://github.com/osman-mian/NFS13_MYO_Plugin'


currentYaw=0;
currentPitch=0;

defaultYaw=0;
defaultPitch=0;

Pitchdeadzone=0.2;
Yawdeadzone=0.2;

ready=false
c=0;

function onForegroundWindowChange(app, title)
	if app=="NFS13.exe" then
		myo.setLockingPolicy("none")
		return true;
	else
		return false
	end
	
end


function conditionallySwapWave(pose)
    if myo.getArm() == "left" then
        if pose == "waveIn" then
            pose = "waveOut"
        elseif pose == "waveOut" then
            pose = "waveIn"
        end
    end
    return pose
end

function onPeriodic()
	currentYaw = myo.getYaw()
	currentPitch= myo.getPitch()
	
	setSteer()
end

function onPoseEdge(pose,edge)

	if ready==false then
			if pose == "fist" and edge=="on" then
				ready=true
				defaultYaw=myo.getYaw()
				defaultPitch=myo.getPitch()
				 
			end
	else
		if (edge == "on") then	
					pose = conditionallySwapWave(pose)
					--myo.notifyUserAction()
					if pose == "fingersSpread" then
						HandBrake()
					elseif pose == "fist" then
						Pedal()
					elseif pose == "waveIn" then
						defaultYaw=myo.getYaw()
						defaultPitch=myo.getPitch()
					elseif pose == "waveOut" then
						nitrousOxide()
					end
		else
				clearAll()
		end
	end

end

function clearAll()
	myo.keyboard("up_arrow","up")
	myo.keyboard("down_arrow","up")
	myo.keyboard("space","up")
	myo.keyboard("left_shift","up")
	myo.keyboard("escape","up")
end

function nitrousOxide()
	myo.keyboard("left_shift","down")
	 
end

function setSteer()
		local delta = currentYaw - defaultYaw;
		if (delta < -Yawdeadzone)  then 
			SteerLeft() 
		elseif (delta > Yawdeadzone)  then 
			SteerRight() 
		else 
			SteerNuetral()
		end
end

function SteerNuetral()
	myo.keyboard("left_arrow","up")
	myo.keyboard("right_arrow","up")
	
	-- 
end

function SteerLeft()
	myo.keyboard("left_arrow","down")
	myo.keyboard("right_arrow","up")
	
	-- 
end

function SteerRight()
	myo.keyboard("left_arrow","up")
	myo.keyboard("right_arrow","down")
	
	-- 
end

function Pedal()

		local delta = currentPitch - defaultPitch;

		if (delta < -Pitchdeadzone)  then 
			Reverse()
			-- 
		else
			Drive()
		end
	
end

function Drive()
	myo.keyboard("down_arrow","up")
	myo.keyboard("up_arrow","down")
end

function Reverse()

	myo.keyboard("down_arrow","down")
	myo.keyboard("up_arrow","up")

end

function HandBrake()
	myo.keyboard("space","down")
	 
end

function activeAppName()
    return "NFS13"
end