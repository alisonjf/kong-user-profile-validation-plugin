
return {
  name = "user-profile-validation",
  fields = {
    { config = {
        type = "record",
        fields = {
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