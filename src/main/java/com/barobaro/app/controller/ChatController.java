package com.barobaro.app.controller;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
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

import com.barobaro.app.mapper.ChatMapper;
import com.barobaro.app.vo.ChatMessageVO;
import com.barobaro.app.vo.ChatRoomVO;

@Controller
@RequestMapping("/chat")
public class ChatController {

    @Autowired
    private ChatMapper chatMapper;

    // 채팅 목록 페이지 (동일 JSP에서 방 리스트와 채팅 영역을 모두 처리)
//    /chat/page
    @GetMapping("/page")
    public ModelAndView chatPage() {
        List<ChatRoomVO> rooms = chatMapper.selectRoomList();
        ModelAndView mav = new ModelAndView();
        mav.setViewName("redirect:/pages/chat/chat_modal.jsp");
        mav.addObject("rooms", rooms);
        System.out.println(rooms);
        return mav;
    }

    // 채팅방 생성
    @PostMapping("/createRoom")
    public ModelAndView createRoom(@RequestParam String title) {
        ChatRoomVO vo = new ChatRoomVO();
        ModelAndView mav = new ModelAndView();
        vo.setTitle(title);
        chatMapper.createRoom(vo);
        mav.setViewName("redirect:/pages/chat/chat_modal.jsp");
        return mav;
    }

    // 특정 채팅방의 과거 메시지 불러오기 (AJAX 이용 가능)
    @ResponseBody
    @GetMapping("/messages/{roomId}")
    public List<ChatMessageVO> getMessages(@PathVariable Long roomId) {
        return chatMapper.selectMessagesByRoom(roomId);
    }
}