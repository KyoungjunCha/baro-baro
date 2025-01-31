package com.barobaro.app.controller;

import java.time.LocalDateTime;
import java.util.List;

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

import com.barobaro.app.mapper.ChatMapper;
import com.barobaro.app.vo.ChatMessageVO;
import com.barobaro.app.vo.ChatRoomVO;

@Controller
@RequestMapping("/chat")
public class ChatController {

    @Autowired
    private ChatMapper chatMapper;

//    /chat/page
    @GetMapping("/page")
    public ModelAndView chatPage() {
        List<ChatRoomVO> rooms = chatMapper.selectRoomList();
        ModelAndView mav = new ModelAndView();
        mav.setViewName("pages/chat/chat_modal");
        mav.addObject("rooms", rooms);
        return mav;
    }

    @PostMapping("/createRoom")
    public ModelAndView createRoom(@RequestParam String title) {
        ChatRoomVO vo = new ChatRoomVO();
        ModelAndView mav = new ModelAndView();
        vo.setTitle(title);
        chatMapper.createRoom(vo);
        mav.setViewName("redirect:/chat/page");
        return mav;
    }

    @ResponseBody
    @GetMapping("/messages/{roomId}")
    public ResponseEntity<?> getMessages(@PathVariable Long roomId) {
        return new ResponseEntity(chatMapper.selectMessagesByRoom(roomId), HttpStatus.OK);
    }
}