<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>	
<head>
    <title>바로바로 | baroborrow</title>
    <!-- STOMP 제거, SockJS만 사용 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
    <style type="text/css">
	    .chat-container {
		    display: flex;
		    margin: 0 auto;
			padding: 24px;
		}
		.chat-list {
			width: 500px;
		}
		.chat-room {
			width: 100%;
		}
    </style>
	<style>
        .chatArea {
        	border:1px solid #666; 
        	width:100%; 
        	height:70vh; 
        	overflow:auto;
        	padding:0;
        }
        
        #chatAreaUlEL{
        	padding:0;
        }
        .chatArea ul {
        	width: 100%;
            list-style: none;
        }
        
        .chatArea ul li {
        	width: 100%;
        }
        
        .chatArea ul li.right {
        	text-align: right;
        }
        
        .chatArea ul li.left {
        	text-align: left;
        }
        
        .chatArea ul li > div.receiver {
        	display: inline-block;
            word-break: break-all;
            margin: 5px 20px;
            max-width: 75%;
            border: 1px solid #888;
            padding: 10px;
            border-radius: 15px;
            background-color: #12C1C0;
            color: white;
            text-align: left;
        }
        
        .chatArea ul li > div.sender {
        	display: inline-block;
            word-break: break-all;
            margin: 5px 20px;
            max-width: 75%;
            border: 1px solid #888;
            padding: 10px;
            border-radius: 15px;
            background-color: #EAEBEE;
            color: black;
            text-align: left;
        }
        
        .message-time {
        	margin: 5px 20px;
            font-size: 12px;
            color: #999;
        }
    </style>
</head>
<body>
   <%--  <jsp:include page="/pages/common/header_test_sh.jsp" /> --%>
    
    <div class="chat-container">
	    <!-- 채팅방 목록 -->
	    <div class="chat-list">
	    	<ul>
		        <c:forEach var="r" items="${rooms}">
		            <li>
		                <a href="#" onclick="selectRoom('${r.chatRoomSeq}')">
		                    유저닉네임: ${r.userNickName}, 유저 seq: ${r.userSeq}
		                </a>
		            </li>
		        </c:forEach>
		    </ul>
	    </div>
	    <!-- 채팅창 -->
	    <div class="chat-room">
	    	<h3>채팅방 <span id="currentRoom"></span></h3>
		    <div id="chatArea" class="chatArea">
		    	<ul id="chatAreaUlEL"></ul>
		    </div>
		    <input type="text" id="content" placeholder="메시지를 입력1"/>
		    <button onclick="sendMessage()">전송</button>
	    </div>    
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        var sock = null;
        var currentRoomId = null;
        // SockJS 연결
        function connectSocket() {
            sock = new SockJS("${pageContext.request.contextPath}/ws/chat");
            sock.onopen = function() {
                console.log("WebSocket opened");
            };
            sock.onclose = function() {
                console.log("WebSocket closed");
            };
            sock.onmessage = function(e) {
                const messageData = e.data;
                const matches = messageData.split(" *date: ");
                const [message, time] = [matches[0], matches[1]];
                const matches2 = message.split(": ");
                const [messageSender, messageContent] = [matches2[0], matches2[1]];
                
                var chatAreaUlEL = document.getElementById('chatAreaUlEL');
                const chatEL = document.createElement("li");
                if(messageSender == ${sessionScope.user_info.userSeq}){
                	chatEL.setAttribute("class","right");
                    const chatMessageDivEL = document.createElement("div");
                    chatMessageDivEL.classList.add('receiver');
                    chatMessageDivEL.textContent = messageContent;
                    
                    const chatMessageTimeEL = document.createElement("div");
                    chatMessageTimeEL.classList.add('message-time');
                    chatMessageTimeEL.textContent = time;
                    
                    chatEL.appendChild(chatMessageDivEL);
                    chatEL.appendChild(chatMessageTimeEL);
                    chatAreaUlEL.appendChild(chatEL);
                }else {
                	chatEL.setAttribute("class","left");
                    const chatMessageDivEL = document.createElement("div");
                    chatMessageDivEL.classList.add('sender');
                    chatMessageDivEL.textContent = messageContent;
                    
                    const chatMessageTimeEL = document.createElement("div");
                    chatMessageTimeEL.classList.add('message-time');
                    chatMessageTimeEL.textContent = time;
                    
                    chatEL.appendChild(chatMessageDivEL);
                    chatEL.appendChild(chatMessageTimeEL);
                    chatAreaUlEL.appendChild(chatEL);
                }
            };
        };
        connectSocket();

       

        // 메시지 전송
        function sendMessage() {
            if (!currentRoomId) {
                alert("채팅방을 먼저 선택하세요");
                return;
            }
            const now = new Date();
            const hour = now.getHours() >= 13 ? "오후" + (now.getHours() - 12) : "오전" + now.getHours();
            var sender = ${sessionScope.user_info.userSeq};
            var content = document.getElementById('content').value;
            var payload = "roomId=" + currentRoomId + "&sender=" + sender + "&content=" + content + " *date: " + hour + ":" + now.getMinutes();
            sock.send(payload);
            document.getElementById('content').value = "";
        }
        
     	// 채팅방 선택
	    function selectRoom(roomId) {
		    currentRoomId = roomId;
		    document.getElementById('currentRoom').innerText = roomId;
		
		    // 과거 메시지 불러오기
		    fetch(`${pageContext.request.contextPath}/chat/messages/` + roomId)
		        .then(response => response.json())
		        .then(data => {
		            var chatAreaUlEL = document.getElementById('chatAreaUlEL');
		            chatAreaUlEL.innerHTML = ""; // 기존 메시지 초기화
		
		            data.forEach(msg => {
		                const matches = msg.content.split(" *date: ");
		                const [message, time] = [matches[0], matches[1]];
		
		                const chatEL = document.createElement("li");
		                
		
		                // 방향에 따라 다른 클래스 추가
		                if (msg.sender == ${sessionScope.user_info.userSeq}) {
		                	chatEL.setAttribute("class","right");
		                    const chatMessageDivEL = document.createElement("div");
		                    chatMessageDivEL.classList.add('receiver');
		                    chatMessageDivEL.textContent = message;
		                    
		                    const chatMessageTimeEL = document.createElement("div");
		                    chatMessageTimeEL.classList.add('message-time');
		                    chatMessageTimeEL.textContent = time;
		                    
		                    chatEL.appendChild(chatMessageDivEL);
		                    chatEL.appendChild(chatMessageTimeEL);
		                    chatAreaUlEL.appendChild(chatEL);
		                   
		                } else {
		                	chatEL.setAttribute("class","left");
		                    const chatMessageDivEL = document.createElement("div");
		                    chatMessageDivEL.classList.add('sender');
		                    chatMessageDivEL.textContent = message;
		                    
		                    const chatMessageTimeEL = document.createElement("div");
		                    chatMessageTimeEL.classList.add('message-time');
		                    chatMessageTimeEL.textContent = time;
		                    
		                    chatEL.appendChild(chatMessageDivEL);
		                    chatEL.appendChild(chatMessageTimeEL);
		                    chatAreaUlEL.appendChild(chatEL);
		                    
		                }
		
		            });
		        });
		
		    document.getElementById('content').focus();
		}

        // enter 입력 시 채팅 입력
        document.addEventListener('keydown', function(event) {
            if (event.key === 'Enter') {
                sendMessage();
                document.getElementById('content').focus();
            }
        });

        // 스크롤 고정
        const targetDiv = document.getElementById('chatArea'); 
        const observer = new MutationObserver(() => {
            targetDiv.scrollTop = targetDiv.scrollHeight;
        });

        observer.observe(targetDiv, { 
            childList: true,  
            subtree: true     
        });
    </script>
</body>
</html>
