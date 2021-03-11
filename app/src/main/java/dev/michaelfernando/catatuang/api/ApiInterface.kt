package dev.michaelfernando.catatuang.api

import dev.michaelfernando.catatuang.model.userlogin.CreateLoginResponse
import retrofit2.Call
import retrofit2.http.POST

interface ApiInterface
{
    @POST("login_api/user.json")
    fun createUser() : Call<ArrayList<CreateLoginResponse>>
}