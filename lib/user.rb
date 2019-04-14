class User

  attr_accessor :user_name, :user_id

  def initialize(input)
    @user_name = input["name"]
    @user_id = input["id"]
  end

end
