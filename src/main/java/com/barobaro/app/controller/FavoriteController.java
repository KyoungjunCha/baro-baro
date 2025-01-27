package com.barobaro.app.controller;

import java.util.List;

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

import com.barobaro.app.service.FavoriteService;
import com.barobaro.app.vo.FavoriteVO;

@Controller
@RequestMapping("/favorite")
public class FavoriteController {
	@Autowired
	@Qualifier("favoriteServiceImpl")
	private FavoriteService service;
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String favoriteListByUser(Model model, @RequestParam("userSeq") int userSeq) {
		List<FavoriteVO> list = service.favoriteListByUser(userSeq);
		System.out.println(list);
		model.addAttribute("favoriteList", list);
		return "/pages/favorite/list";
	}
	
	@RequestMapping(value = "/toggle", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> toggleFavorite(@RequestBody FavoriteVO fvo) {
	    try {
	        int userSeq = fvo.getUserSeq();
	        int postSeq = fvo.getPostSeq();
	        
	        boolean isFavorite = service.isFavorite(userSeq, postSeq);
	        if (isFavorite) {
	            // 즐겨찾기 해지
	            service.favoriteDelete(userSeq, postSeq);
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
