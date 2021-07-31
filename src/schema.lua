local typedefs = require "kong.db.schema.typedefs"

return {
  name = "user-profile-validation",
  fields = {
    { config = {
        type = "record",
        fields = {
          { consumer = typedefs.no_consumer },  -- this plugin cannot be configured on a consumer (typical for auth plugins)
          { 
            allowed_profiles_ids = { 
              type = "array", 
              match_none = { {pattern = "^$",err = "Allowed profile ids cannot be empty",}, },
              elements = { type = "number", required = true },
            },
          },
        },
      },
    },
  },
}