local BasePlugin = require "kong.plugins.base_plugin"


local type = type
local error = error
local insert = table.insert
local tostring = tostring
local setmetatable = setmetatable
local getmetatable = getmetatable

local UserProfileValidationHandler = BasePlugin:extend()
UserProfileValidationHandler.PRIORITY = 99

local function validate_profile(conf)
	local errors

    local profile_id = kong.request.get_header("x-user-profile-id")
	if profile_id == nil then
		return false, { status = 428, message = "Header x-user-profile-id is missing"}
    end
    if type(profile_id) ~= "number" then
        return false, { status = 412, message = "Header x-user-profile-id must be a number"}
    end
    if profile_id > conf.minimum_allowed_profile_id then
        return false, { status = 403, message = string.format("Profile ID %s is not allowed", profile_id)}
    end

    return true
end

function UserProfileValidationHandler:new()
    UserProfileValidationHandler.super.new(self, "user-profile-validation")
end

function UserProfileValidationHandler:access(conf)
    UserProfileValidationHandler.super.access(self)

    if kong.request.get_method() == "OPTIONS" then
        return
    end

    local ok, err = validate_profile(conf)
    if not ok then
      return kong.response.exit(err.status, err.errors or { message = err.message })
    end
end

return UserProfileValidationHandler