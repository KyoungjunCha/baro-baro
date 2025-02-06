package com.barobaro.app.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.barobaro.app.common.CommonCode.Role;
import com.barobaro.app.common.CommonCode.UserInfo;
import com.barobaro.app.common.CommonCode.UserStatus;
import com.barobaro.app.service.FavoriteService;
import com.barobaro.app.vo.FavoriteVO;
import com.barobaro.app.vo.PostVO;

@Controller
@RequestMapping("/favorite")
public class FavoriteController {
	@Autowired
	@Qualifier("favoriteServiceImpl")
	private FavoriteService service;

	@RequestMapping(value = "/flist", method = RequestMethod.GET)
	public String favoriteList(Model model, HttpSession session) {
		session.setAttribute("user_info",
				new UserInfo(1002, "test@test.com", "test nickname", "", UserStatus.ACTIVE, Role.ADMIN));
		UserInfo userInfo = (UserInfo) session.getAttribute("user_info");
		long userSeq = userInfo.getUserSeq();

		List<PostVO> list = service.favoriteListInfo(userSeq);
		System.out.println("favoriteList: " + list);
		model.addAttribute("favoriteList", list) ;
		
		return "pages/favorite/list";
	}

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<List<Integer>> favoriteListByUser(HttpSession session) {
		session.setAttribute("user_info",
				new UserInfo(1002, "test@test.com", "test nickname", "", UserStatus.ACTIVE, Role.ADMIN));
		UserInfo userInfo = (UserInfo) session.getAttribute("user_info");

		if (userInfo == null) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(new ArrayList<>());
		}

		long userSeq = userInfo.getUserSeq();

		List<FavoriteVO> list = service.favoriteListByUser((int) userSeq);
		List<Integer> favoritePostSeqs = new ArrayList<>();

		for (FavoriteVO fvo : list) {
			favoritePostSeqs.add(fvo.getPostSeq());
		}

		System.out.println("즐겨찾기 목록: " + favoritePostSeqs);

		return ResponseEntity.ok(favoritePostSeqs);
	}

	@RequestMapping(value = "/toggle", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> toggleFavorite(@RequestBody FavoriteVO fvo, HttpSession session) {
		try {
			session.setAttribute("user_info",
					new UserInfo(1002, "test@test.com", "test nickname", "", UserStatus.ACTIVE, Role.ADMIN));
			UserInfo userInfo = (UserInfo) session.getAttribute("user_info");
			long userSeq = userInfo.getUserSeq();
			int postSeq = fvo.getPostSeq();

			System.out.println("userSeq: " + userSeq + ", postSeq: " + postSeq);

			boolean isFavorite = service.isFavorite((int) userSeq, postSeq);
			System.out.println("isFavorite: " + isFavorite);
			if (isFavorite) {
				// 즐겨찾기 해지
				service.favoriteDelete((int) userSeq, postSeq);
				return ResponseEntity.ok("deleted");
			} else {
				// 즐겨찾기 추가
				service.favoriteInsert(fvo);
				return ResponseEntity.ok("added");
			}
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Error processing the request");
		}
	}

}
