/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hieunt.util;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import hieunt.tbluser.GoogleDTO;
import java.io.IOException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;


/**
 *
 * @author HIEUNGUYEN
 */
public class GoogleUtil {
    public static String getToken(final String code) throws ClientProtocolException, IOException {
        String response = Request.Post(AccessGoogle.GOOGLE_LINK_GET_TOKEN)
                .bodyForm(Form.form().add("client_id", AccessGoogle.GOOGLE_CLIENT_ID)
                .add("client_secret", AccessGoogle.GOOGLE_CLIENT_SECRET)
                .add("redirect_uri", AccessGoogle.GOOGLE_REDIRECT_URI)
                .add("code", code)
                .add("grant_type", AccessGoogle.GOOGLE_GRANT_TYPE).build())
                .execute().returnContent().asString();
        
        JsonObject jObj = new Gson().fromJson(response, JsonObject.class);
        String accessToken = jObj.get("access_token").toString().replaceAll("\"", "");
        return accessToken;
    }
    
    public static GoogleDTO getUserInfo(final String accessToken) throws IOException {
        String link = AccessGoogle.GOOGLE_LINK_GET_USER_INFO + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();
        GoogleDTO gDTO = new Gson().fromJson(response, GoogleDTO.class);
        System.out.println(gDTO);
        return gDTO;
    }
}
