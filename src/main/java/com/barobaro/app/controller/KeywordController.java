package com.barobaro.app.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.barobaro.app.common.CommonCode.Role;
import com.barobaro.app.common.CommonCode.UserInfo;
import com.barobaro.app.common.CommonCode.UserStatus;
import com.barobaro.app.service.KeywordService;
import com.barobaro.app.vo.KeywordVO;

@Controller
@RequestMapping("/keyword")
public class KeywordController {
	@Autowired
	private KeywordService service;

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String addKeyword(@ModelAttribute KeywordVO kvo, HttpSession session) {
		session.setAttribute("user_info", new UserInfo(1002, "test@test.com", "test nickname","", UserStatus.ACTIVE, Role.ADMIN));
		UserInfo userInfo = (UserInfo) session.getAttribute("user_info");
		long userSeq = userInfo.getUserSeq();
		
		kvo.setUserSeq((int)userSeq);
		
		service.addKeyword(kvo);

		return "redirect:/keyword/list";
	}

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String getKeywordByUserSeq(HttpSession session, Model model) {
		session.setAttribute("user_info", new UserInfo(1002, "test@test.com", "test nickname","", UserStatus.ACTIVE, Role.ADMIN));
		UserInfo userInfo = (UserInfo) session.getAttribute("user_info");
		long userSeq = userInfo.getUserSeq();
		
		List<KeywordVO> list = service.getKeywordsByUserSeq((int)userSeq);
		model.addAttribute("KEYWORD_LIST", list);

//		return "pages/notification/keyword";
		return "pages/notification/keyword2";
	}

	@RequestMapping(value = "/{keywordSeq}", method = RequestMethod.GET)
	public String getKeywordBySeq(@PathVariable int keywordSeq, Model model) {
		KeywordVO kvo = service.getKeywordBySeq(keywordSeq);
		model.addAttribute("KEYWORD_LIST", kvo);

//		return "pages/notification/keyword";
		return "pages/notification/keyword2";
	}

	@RequestMapping(value = "/{keywordSeq}", method = RequestMethod.POST)
	public String updateKeyword(@PathVariable int keywordSeq, @RequestParam String contents, Model model) {
		service.updateKeyword(contents, keywordSeq);

		return "redirect:/keyword/" + keywordSeq;
	}

	@RequestMapping(value = "/delete/{keywordSeq}", method = RequestMethod.POST)
	@ResponseBody
	public String deleteKeyword(@PathVariable int keywordSeq, @RequestParam int userSeq) {
		service.deleteKeyword(keywordSeq);
		return "success";
	}
}
