package com.barobaro.app.vo;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Component;

import com.barobaro.app.common.CommonCode.Role;
import com.barobaro.app.common.CommonCode.UserStatus;

import lombok.Data;

@Component   
@Data        
public class UsersTblVO {
	private int userSeq;      // user_seq
    private String email;     // email
    private String provider;
    private String nickname;  // nickname
    private String phone;     // phone
    private String address;   // address
    private String regdate;   // regdate
    private UserStatus status;    // status
    private Role role;      // role
    private String profile_image;
    
    private UsersOauthVO usersOauthVO; // 1:1 or 1:0 관계 매핑
    private List<PostVO> postVO; //1:N 관계
    private List<NotificationVO> notificationVO;
    private List<UserReviewAnswerVO> userReviewAnswerVO;
    private List<CommentVO> commentVO;
    

}
