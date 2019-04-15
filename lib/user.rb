class User

  attr_accessor :user_name, :user_id

  def initialize(input)
    @user_name = input["name"]
    @user_id = input["id"]
  end

  def user_to_json
    json_user = {}
    json_user["id"] = @user_id
    json_user["name"] = @user_name

    return json_user
  end

end
