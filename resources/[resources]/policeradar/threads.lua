-- The main purpose of this thread is to update the information about the local player, including their
-- ped id, the vehicle id (if they're in one), whether they're in a driver seat, and if the vehicle's class
-- is valid or not
local threadsCreated = false
local vehThreads = false
local eligAble = false

function createVehThreads()
	if vehThreads then return end
	vehThreads = true

	-- Create the thread that will run the dynamic thread wait check, this check only runs every two seconds
	Citizen.CreateThread( function()
		while vehThreads do 
			-- Run the functio
			RADAR:RunDynamicThreadWaitCheck()
	
			-- Make the thread wait two seconds
			Citizen.Wait(2000)
		end 
	end)
	
	-- Create the main thread that will run the threads function, the function itself is run every frame as the
	-- dynamic wait time is ran inside the function
	Citizen.CreateThread( function()
		while vehThreads do 
			-- Run the function
			RADAR:RunThreads()
	
			-- Make the thread wait 0 ms
			Citizen.Wait(5)
		end 
	end)
	
	-- Main thread
	Citizen.CreateThread(function()
		-- Remove the NUI focus just in case
		SetNuiFocus(false, false)
	
		-- Run the function to cache the number of rays, this way a hard coded number is never needed
		RADAR:CacheNumRays()
		
		-- Update the end coordinates for the ray traces based on the config, again, reduced hard coding
		RADAR:UpdateRayEndCoords()
		
		-- Update the operator menu positions
		RADAR:UpdateOptionIndexes()
	
		-- If the fast limit feature is allowed, create the config in the radar variables
		if ( RADAR:IsFastLimitAllowed() ) then 
			RADAR:CreateFastLimitConfig()
		end 
	
		-- Run the main radar function 
		while vehThreads do
			RADAR:Main()
	
			Citizen.Wait(100)
		end
	end)
	
	-- Runs the display validation check for the radar
	Citizen.CreateThread( function() 
		Citizen.Wait(100)
	
		while vehThreads do 
			-- Run the check 
			READER:Main()
			RADAR:RunDisplayValidationCheck()
			READER:RunDisplayValidationCheck()
			
			-- Wait half a second 
			Citizen.Wait(500)
		end 
	end)
	
	-- Runs the vehicle pool updater
	Citizen.CreateThread( function() 
		while vehThreads do
			-- Update the vehicle pool 
			RADAR:UpdateVehiclePool()
	
			-- Wait 3 seconds
			Citizen.Wait(3000)
		end 
	end)
end

local Vehicles = {
    [-888242983] = true,
    [-834607087] = true,
    [666166960] = true,
    [-2145027648] = true
}
function createThreads()
    if threadsCreated then return end

    while not PlayerData.job do
        Wait(250)
    end

    eligAble = eligAbleJobs[PlayerData.job.name]
    if not eligAble then return end

    Citizen.CreateThread( function()
        while eligAble do 
            eligAble = eligAbleJobs[PlayerData.job.name]
            if not eligAble then
                PLY.veh = 0
                PLY.vehClassValid = false
                RADAR:RunDisplayValidationCheck()
                READER:RunDisplayValidationCheck()
                if vehThreads then
                    vehThreads = false
                end
                return
            end

            PLY.ped = PlayerPedId()
            PLY.veh = GetVehiclePedIsIn(PLY.ped, false )
            PLY.inDriverSeat = GetPedInVehicleSeat(PLY.veh, -1) == PLY.ped or GetPedInVehicleSeat(PLY.veh, 0) == PLY.ped
            PLY.vehClassValid = (GetVehicleClass( PLY.veh ) == 18) or (Vehicles[GetEntityModel( PLY.veh )])

            if PLY.veh > 0 and PLY.inDriverSeat and PLY.vehClassValid then
                createVehThreads()
            elseif vehThreads then
                vehThreads = false
                RADAR:RunDisplayValidationCheck()
                READER:RunDisplayValidationCheck()
            end

            Citizen.Wait(500)
        end 
    end)
end