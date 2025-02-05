package com.barobaro.app.controller;

import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.barobaro.app.common.CommonCode.Role;
import com.barobaro.app.common.CommonCode.UserInfo;
import com.barobaro.app.common.CommonCode.UserStatus;
import com.barobaro.app.mapper.ChatMapper;
import com.barobaro.app.service.ChatService;
import com.barobaro.app.vo.ChatMessageVO;
import com.barobaro.app.vo.ChatRoomVO;

@Controller
@RequestMapping("/chat")
public class ChatController {
    
    @Autowired
    private ChatService chatService;

//    /chat/page
    @GetMapping("/page")
    public ModelAndView chatPage(@RequestParam(value = "chatRoomSeq", required = false)long chatRoomSeq
    		, HttpSession session) {
    	UserInfo userInfo = (UserInfo) session.getAttribute("user_info");
        List<ChatRoomVO> rooms = chatService.getRoomsByUserSeq(userInfo.getUserSeq());
        ModelAndView mav = new ModelAndView();
        mav.setViewName("pages/chat/chat_page");
        mav.addObject("rooms", rooms);
        mav.addObject("select_room_seq", chatRoomSeq);
        return mav;
    }
    
    @GetMapping("/test/page")
    public ModelAndView chatPageTest() {
        List<ChatRoomVO> rooms = chatService.getRoomsByUserSeq(1001);
        ModelAndView mav = new ModelAndView();
        mav.setViewName("pages/chat/1001_chat_test");
        mav.addObject("rooms", rooms);
        return mav;
    }

    @GetMapping("/createRoom/{targetUser}")
    public ModelAndView createRoom(HttpSession session, @PathVariable("targetUser") long targetUserSeq) {
    	UserInfo userInfo = (UserInfo) session.getAttribute("user_info");
    	long chatRoomSeq = chatService.createOrGetChatRoomSeq(userInfo.getUserSeq(), targetUserSeq);
        ModelAndView mav = new ModelAndView();
        mav.setViewName("redirect:/chat/page?chatRoomSeq=" + chatRoomSeq);
        return mav;
    }

    @ResponseBody
    @GetMapping("/messages/{roomSeq}")
    public ResponseEntity<?> getMessages(@PathVariable Long roomSeq) {
        return new ResponseEntity(chatService.selectMessagesByRoomSeq(roomSeq), HttpStatus.OK);
    }
}