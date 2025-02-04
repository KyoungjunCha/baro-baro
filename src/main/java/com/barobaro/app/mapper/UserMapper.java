package com.barobaro.app.mapper;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import com.barobaro.app.vo.PostVO;
import com.barobaro.app.vo.UsersOauthVO;
import com.barobaro.app.vo.UsersTblVO;


@Repository
@Mapper
public interface UserMapper {
	public ArrayList<UsersTblVO>  allUser();
	public void insertUsersTbl(UsersTblVO usersTblVO);
	public int updateUsersTbl(UsersTblVO usersTblVO);
	public int userDelete(int userSeq);	
	
	public int updateAdminUsersTbl(UsersTblVO usersTblVO);
	
//	//일반 로그인
//	public UsersTblVO formLogin(UsersTblVO usersTblVO);
//	//일반 회원가입
//	public void formJoin(UsersTblVO usersTblVO);
	
	//-------------- OAuth 추가 -------------------
	public UsersTblVO findUserByEmail(String email);
	public UsersTblVO findUserByNickname(String nickname);
	public void insertUsersOauthTbl(UsersOauthVO usersOauthVO);
    public void updateUserOauthTbl(UsersOauthVO usersOauthVO);
	
	
    public ArrayList<PostVO> allPosts(int userSeq);
    
}
