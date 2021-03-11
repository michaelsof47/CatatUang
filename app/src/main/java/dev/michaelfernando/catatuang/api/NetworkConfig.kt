package dev.michaelfernando.catatuang.api

import dev.michaelfernando.catatuang.model.userlogin.CreateLoginResponse
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

class NetworkConfig
{
    fun getInterceptor() : OkHttpClient
    {
        val logging = HttpLoggingInterceptor()
        logging.level = HttpLoggingInterceptor.Level.BODY

        val okHttpClient = OkHttpClient.Builder()
            .addInterceptor(logging)
            .build()

        return okHttpClient
    }

    fun getRetrofit() : Retrofit
    {
        val retrofit = Retrofit.Builder()
            .baseUrl("https://catatuang-868a1-default-rtdb.firebaseio.com/")
            .client(getInterceptor())
            .addConverterFactory(GsonConverterFactory.create())
            .build()

        return retrofit
    }

    fun getServices() = getRetrofit().create(CreateLoginResponse::class.java)
}