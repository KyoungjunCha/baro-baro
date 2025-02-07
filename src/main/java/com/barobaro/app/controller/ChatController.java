package com.barobaro.app.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.barobaro.app.common.CommonCode.Role;
import com.barobaro.app.common.CommonCode.UserInfo;
import com.barobaro.app.common.CommonCode.UserStatus;
import com.barobaro.app.mapper.ChatMapper;
import com.barobaro.app.service.ChatService;
import com.barobaro.app.vo.ChatMessageVO;
import com.barobaro.app.vo.ChatRoomVO;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@RequestMapping("/chat")
public class ChatController {
    
    @Autowired
    private ChatService chatService;
    
    @ResponseBody
    @RequestMapping(value = "/sse/{userSeq}", method = RequestMethod.GET, produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    public ResponseEntity<SseEmitter> handleSse(@PathVariable("userSeq") long userSeq) {
        SseEmitter emitter = new SseEmitter(Long.MAX_VALUE);
        chatService.add(userSeq, emitter);
        try {  
            emitter.send(SseEmitter.event()  
                    .name("connect")  
                    .data(new ObjectMapper().writeValueAsString(chatService.getAllRoomsWithMessagesByUserSeq(userSeq))));  
        } catch (IOException e) {  
            throw new RuntimeException(e);  
        }  
        return ResponseEntity.ok(emitter);  
    }
    
//    /chat/page
    @GetMapping("/page")
    public ModelAndView chatPage(@RequestParam(value = "chatRoomSeq", required = false, defaultValue = "0")long chatRoomSeq
    		, HttpSession session) {
//    	UserInfo userInfo = (UserInfo) session.getAttribute("user_info");
//    	List<ChatRoomVO> rooms = chatService.getRoomsByUserSeq(userInfo.getUserSeq());
        ModelAndView mav = new ModelAndView();
        mav.setViewName("pages/chat/chat_page");
//        mav.addObject("rooms", rooms);
//        if(chatRoomSeq != 0)mav.addObject("select_room_seq", chatRoomSeq);
        return mav;
    }
    
    @GetMapping("/test/page")
    public ModelAndView chatPageTest(HttpSession session) {
    	session.setAttribute("user_info",
				new UserInfo(1005, "test@test.com", "test nickname", "", UserStatus.ACTIVE, Role.ADMIN));
        ModelAndView mav = new ModelAndView();
        mav.setViewName("pages/chat/chat_page");
        return mav;
    }

    @GetMapping("/createRoom/{targetPostSeq}")
    public ModelAndView createRoom(HttpSession session, @PathVariable("targetPostSeq") long targetPostSeq) {
    	UserInfo userInfo = (UserInfo) session.getAttribute("user_info");
    	long chatRoomSeq = chatService.createOrGetChatRoomSeq(userInfo.getUserSeq(), targetPostSeq);
        ModelAndView mav = new ModelAndView();
        mav.setViewName("redirect:/chat/page?chatRoomSeq=" + chatRoomSeq);
        return mav;
    }

	/*
	 * @ResponseBody
	 * 
	 * @GetMapping("/messages/{roomSeq}") public ResponseEntity<?>
	 * getMessages(@PathVariable Long roomSeq) { return new
	 * ResponseEntity(chatService.selectMessagesByRoomSeq(roomSeq), HttpStatus.OK);
	 * }
	 */
}