local typedefs = require "kong.db.schema.typedefs"

return {
  name = "user-profile-validation",
  fields = {
    { config = {
        type = "record",
        fields = {
          { consumer = typedefs.no_consumer },  -- this plugin cannot be configured on a consumer (typical for auth plugins)
          { minimum_allowed_profile_id = { 
            type = "number", 
            required = true,
            match_none = { {pattern = "^$",err = "Minimum allowed profile id cannot be empty",}, } }, 
          },
        },
      },
    },
  },
}