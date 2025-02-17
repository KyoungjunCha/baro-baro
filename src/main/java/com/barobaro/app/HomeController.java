package com.barobaro.app;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.barobaro.app.common.CommonCode.Role;
import com.barobaro.app.common.CommonCode.UserInfo;
import com.barobaro.app.common.CommonCode.UserStatus;

@Controller
public class HomeController {
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(HttpSession session) {
//		session.setAttribute("SESS_PROVIDER", "KAKAO");
//		session.setAttribute("SESS_EMAIL", "KAKAO");
//		session.setAttribute("user_info",
//				new UserInfo(1005, "test@test.com", "차경준", "", UserStatus.ACTIVE, Role.ADMIN));
		return "pages/main";
	}
}
