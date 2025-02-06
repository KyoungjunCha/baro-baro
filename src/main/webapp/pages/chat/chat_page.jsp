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
			width: 200px;
		}
		.chat-room {
			width: 100%;
		}
    </style>
	<style>
        .chatArea {
        	border:1px solid #666; 
        	width:100%; 
        	height:65vh; 
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
    <style>
	    .profile-img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
        }
        
		li {
			list-style: none;  
			margin: 0;         
			padding: 0;
		}
		#content {
			width:100%;
			border:0;
			padding:0;
			resize: none;
		}
		.chat-input-container {
			border:1px solid #666; 
			width:100%;
		}
		.chat-input-footer {
			border:0;
			width:100%;
			display: flex;
  			justify-content: flex-end;
		}
		
		/* 스크롤바 설정*/
		.chatArea::-webkit-scrollbar{
		  width: 20px;
		}
		
		/* 스크롤바 막대 설정*/
		.chatArea::-webkit-scrollbar-thumb{
		  background-color: #12c1c0;
		  border-radius: 10px; 
		  border: 2px solid rgba(0,0,0,0.8);
		}
		
		/* 스크롤바 뒷 배경 설정*/
		.chatArea::-webkit-scrollbar-track{
		  background-color: rgba(0,0,0,0);
		}
		
		.chat-input-footer button {
			background: #12c1c0;
			border: none;
			color: white;
			padding: 10px 15px;
			border-radius: 20px;
			cursor: pointer;
			font-size: 16px;
		}
		
		.chat-room-a-EL {
			text-decoration: none;
		}
		#chat-list-rooms-ul {
			padding: 0;
		}
    </style>
    <style>
   		/* 알림창 배경 */
        #customAlert {
            display: none; /* 기본적으로 숨겨짐 */
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5); /* 반투명 배경 */
            justify-content: center;
            align-items: center;
            z-index: 9999; /* 다른 콘텐츠 위에 표시 */
        }

        /* 알림창 내용 */
        .alert-content {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            width: 300px;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .alert .alert-content button {
        	background: #12c1c0;
			border: none;
			color: white;
			padding: 10px 15px;
			border-radius: 20px;
			cursor: pointer;
			font-size: 16px;
        }
    </style>
    <script>
        // 알림창을 보여주는 함수
        function showAlert(message) {
            document.getElementById('alertMessage').innerText = message;  // 메시지 설정
            document.getElementById('customAlert').style.display = 'flex'; // 알림창 표시
        }

        // 알림창을 닫는 함수
        function closeAlert() {
            document.getElementById('customAlert').style.display = 'none'; // 알림창 숨기기
        }
    </script>
</head>
<body>
	<!-- 알림창 -->
    <div id="customAlert" class="alert">
        <div class="alert-content">
            <p id="alertMessage">알림 메시지가 여기에 표시됩니다.</p>
            <button onclick="closeAlert()">닫기</button>
        </div>
    </div>
   	<%-- <jsp:include page="/pages/common/header_test_sh.jsp" />   --%>  
    <div class="chat-container">
	    <!-- 채팅방 목록 -->
	    <div class="chat-list">
	    	<ul id="chat-list-rooms-ul">
		        <%-- <c:forEach var="r" items="${rooms}">
			        <c:if test="${r.chatRoomSeq == param.chatRoomSeq}">
			        	<script type="text/javascript">
			        		setTimeout(function() {
			        			selectRoom(${param.chatRoomSeq});
			                }, 1000);
    					</script>
			        </c:if>
		            <li>
		                <a class="chat-room-a-EL" href="#" onclick="selectRoom('${r.chatRoomSeq}')">
		                     <img src="${r.profileImage}" class="profile-img" alt="x">
		                     ${r.userNickName}
		                </a>
		            </li>
		        </c:forEach> --%>
		    </ul>
	    </div>
	    <!-- 채팅창 -->
	    <div class="chat-room">
	    	<h3>채팅방 <span id="currentRoom"></span></h3>
		    <div id="chatArea" class="chatArea">
		    	<ul id="chatAreaUlEL"></ul>
		    </div>
		    <div class="chat-input-container">
			    <textarea id="content" placeholder="메시지를 입력하세요"></textarea>
			    <div class="chat-input-footer">
			    	<button onclick="sendMessage()">전송</button>
			    </div>
		    </div>
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
            	showAlert("채팅방을 먼저 선택하세요");
                return;
            }
            var content = document.getElementById('content').value;
            if(content == "") {
            	showAlert("채팅을 입력 후 전송해야합니다.");
            	return;
            }
            const now = new Date();
            const hour = now.getHours() >= 13 ? "오후" + (now.getHours() - 12) : "오전" + now.getHours();
            var sender = ${sessionScope.user_info.userSeq};
            var payload = "roomId=" + currentRoomId + "&sender=" + sender + "&content=" + content + " *date: " + hour + ":" + now.getMinutes();
            sock.send(payload);
            document.getElementById('content').value = "";
        }
        
     	// 채팅방 선택
	    function selectRoom(roomId) {
		    currentRoomId = roomId;
		    document.getElementById('currentRoom').innerText = roomId;
		
		    // 과거 메시지 불러오기
		    /* fetch(`${pageContext.request.contextPath}/chat/messages/` + roomId)
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
		        }); */
		
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
    <script>
    var jsonChatData;
    var messageBodyELMap = new Map();
    var JSChatVOMap = new Map();

    document.addEventListener("DOMContentLoaded", function () {
    	const sseURL = `${pageContext.request.contextPath}/chat/sse/${sessionScope.user_info.userSeq}`;
        const eventSource = new EventSource(sseURL);
        
        // Handle the "connect" event sent by the server
        eventSource.addEventListener("connect", function (event) {
            jsonChatData = JSON.parse(event.data);
            initChatListRoomsUlEL();
        });
        
        // Handle the "newChat" event sent by the server
        eventSource.addEventListener("newChat", function (event) {
            var newChatJsonValue = JSON.parse(event.data);
            const chatRoomSeq = newChatJsonValue.chatRoomSeq;
            const matches = newChatJsonValue.content.split(" *date: ");
            const [message, time] = [matches[0], matches[1]];
            console.log("값: " + newChatJsonValue + chatRoomSeq);
            
			 messageBodyELMap.get(chatRoomSeq).textContent = message;            
            
            JSChatVOMap.get(chatRoomSeq).chatMessages.push(newChatJsonValue);
        });

        // Handle errors
        eventSource.onerror = function () {
            console.error("An error occurred with the SSE connection.");
            eventSource.close();
        };
    });

    function initChatListRoomsUlEL() {
        const chatListRoomsUlEL = document.getElementById('chat-list-rooms-ul');
        for (const JSChatVO of jsonChatData) {
            JSChatVOMap.set(JSChatVO.chatRoomSeq, JSChatVO);
            
            const chatListRoomsUlLiEL = document.createElement("li");
            chatListRoomsUlLiEL.id = `chat-room-${JSChatVO.chatRoomSeq}`; // Set unique ID for each chat room
            
            const chatRoomAEL = document.createElement("a");
            chatRoomAEL.classList.add("chat-room-a-EL");
            chatRoomAEL.addEventListener("click", () => selectRoom(JSChatVO.chatRoomSeq));
            
            const profileImgEL = document.createElement("img");
            profileImgEL.classList.add("profile-img");
            profileImgEL.setAttribute("alt", "x");
            
            const productImgEL = document.createElement("img");
            productImgEL.classList.add("profile-img");
            productImgEL.setAttribute("alt", "x");
            productImgEL.setAttribute("src", JSChatVO.postStoragePath.replace('c:\\uploads', '/uploads'));
            
            if (JSChatVO.postOwnerSeq == ${sessionScope.user_info.userSeq}) {
                profileImgEL.setAttribute("src", JSChatVO.requestUserProfileImage);
                chatRoomAEL.appendChild(profileImgEL);
                chatRoomAEL.appendChild(productImgEL);
                const textNode = document.createTextNode(JSChatVO.postOwnerNickname);
                chatRoomAEL.appendChild(textNode);
            } else {
                profileImgEL.setAttribute("src", JSChatVO.postOwnerProfileImage);
                chatRoomAEL.appendChild(profileImgEL);
                chatRoomAEL.appendChild(productImgEL);
                const textNode = document.createTextNode(JSChatVO.postOwnerNickname);
                chatRoomAEL.appendChild(textNode);
            }
            
            const messageBodyEL = document.createElement("div");
            messageBodyEL.classList.add("message-body");
            
            /* const initChatMessageSTR = JSChatVO.chatMessages[JSChatVO.chatMessages.length - 1].content.split(" *date: ")[0];
            const messageBodyELTextNode = document.createTextNode(initChatMessageSTR); */

			let initChatMessageSTR = "";
            
            // 채팅 메시지가 있을 경우, 마지막 메시지를 처리
            if (JSChatVO.chatMessages.content !== null) {
                const lastMessage = JSChatVO.chatMessages[JSChatVO.chatMessages.length - 1].content;
                console.log(lastMessage + ")*()*()");
                // 메시지 내용에서 "*date:" 기준으로 잘라서 첫 번째 부분만 사용
                initChatMessageSTR = lastMessage.split(" *date: ")[0];
            } else {
                // 채팅 메시지가 없으면 기본 값 설정
                initChatMessageSTR = "새로운 채팅을 시작해보세요."; // 기본 메시지
            }
            const messageBodyELTextNode = document.createTextNode(initChatMessageSTR);
            messageBodyEL.appendChild(messageBodyELTextNode);
            console.log("chat init: " + JSChatVO.chatRoomSeq + messageBodyELTextNode);
            messageBodyELMap.set(JSChatVO.chatRoomSeq, messageBodyEL); // Initialize map for chat room

            chatListRoomsUlLiEL.appendChild(chatRoomAEL);
            chatListRoomsUlLiEL.appendChild(messageBodyEL);
            chatListRoomsUlEL.appendChild(chatListRoomsUlLiEL);
        }
    }

    </script>
</body>
</html>