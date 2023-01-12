
--[[
	Rbx-Types

	This is a default doc hand made to handle exceptions, like optional parameters that Roblox doesn't provide
]]

---@diagnostic disable
---@generic CLASS_REFERENCE : string
---@param className `CLASS_REFERENCE`
---@param parent? Instance
---@return CLASS_REFERENCE
---[datatypes/Instance.new](https://create.roblox.com/docs/reference/engine/datatypes/Instance#new)
Instance.new=function(className,parent)end
---@param self Instance
---@param childName string
---@param timeOut? number
---@return any
---[classes/Instance:WaitForChild](https://create.roblox.com/docs/reference/engine/classes/Instance#WaitForChild)
Instance.WaitForChild=function(self,childName,timeOut)end

-- Service Related
---@generic SERVICE_REFERENCE : string
---@param self ServiceProvider
---@param className `SERVICE_REFERENCE`
---@return SERVICE_REFERENCE
---[classes/ServiceProvider:FindService](https://create.roblox.com/docs/reference/engine/classes/ServiceProvider#FindService)
ServiceProvider.FindService=function(self,className)end
---@generic SERVICE_REFERENCE : string
---@param self ServiceProvider
---@param className `SERVICE_REFERENCE`
---@return SERVICE_REFERENCE
---[classes/ServiceProvider:GetService](https://create.roblox.com/docs/reference/engine/classes/ServiceProvider#GetService)
ServiceProvider.GetService=function(self,className)end
---@generic SERVICE_REFERENCE : string
---@param self ServiceProvider
---@param className `SERVICE_REFERENCE`
---@return SERVICE_REFERENCE
---[classes/ServiceProvider:getService](https://create.roblox.com/docs/reference/engine/classes/ServiceProvider#getService)
ServiceProvider.getService=function(self,className)end
---@generic SERVICE_REFERENCE : string
---@param self ServiceProvider
---@param className `SERVICE_REFERENCE`
---@return SERVICE_REFERENCE
---[classes/ServiceProvider:service](https://create.roblox.com/docs/reference/engine/classes/ServiceProvider#service)
ServiceProvider.service=function(self,className)end

--BindableEvents
---@param self BindableEvent
---@return nil
---[classes/BindableEvent:Fire](https://create.roblox.com/docs/reference/engine/classes/BindableEvent#Fire)
BindableEvent.Fire=function(self,...)end