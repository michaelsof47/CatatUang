package dev.michaelfernando.catatuang.model.userlogin;

import com.google.gson.annotations.SerializedName;

public class CreateLoginResponse{

	@SerializedName("password")
	private String password;

	@SerializedName("email")
	private String email;

	public String getPassword(){
		return password;
	}

	public String getEmail(){
		return email;
	}
}