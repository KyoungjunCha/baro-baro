package com.barobaro.app.vo;

import java.util.Date;
import org.springframework.stereotype.Component;
import lombok.Data;

@Component   
@Data     
public class UsersOauthVO {
	private int userDetailSeq;
	private int userSeq;       // user_seq
    private String accessToken;// access_token
    private String refreshToken; // refresh_token
    private String regdate;
//    private String uptdate;    // uptdate
    
}
