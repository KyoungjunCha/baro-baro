<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>	
<head>
    <title>채팅 테스트</title>
    <!-- STOMP 제거, SockJS만 사용 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
</head>
<body>
    <h2>채팅방 목록</h2>
    <form action="${pageContext.request.contextPath}/chat/createRoom" method="post">
        방 이름: <input type="text" name="title">
        <input type="submit" value="방 생성">
    </form>
    <ul>
        <c:forEach var="r" items="${rooms}">
            <li>
                <a href="#" onclick="selectRoom('${r.chatRoomSeq}')">
                    유저닉네임: ${r.userNickName}, 유저 seq: ${r.userSeq}
                </a>
            </li>
        </c:forEach>
    </ul>

    <hr/>

    <h3>채팅방 <span id="currentRoom"></span></h3>
    <div id="chatArea" style="border:1px solid #666; width:400px; height:200px; overflow:auto;"></div>

    <input type="text" id="sender" placeholder="보내는 사람"/><br/>
    <input type="text" id="content" placeholder="메시지를 입력"/>
    <button onclick="sendMessage()">전송</button>

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
                // 서버에서 보낸 메시지 출력
                var chatArea = document.getElementById('chatArea');
                chatArea.innerHTML += "<div>" + e.data + "</div>";
            };
        }
        connectSocket();

        // 채팅방 선택
        function selectRoom(roomId) {
            currentRoomId = roomId;
            document.getElementById('currentRoom').innerText = roomId;
            // 과거 메시지 불러오기
            fetch("${pageContext.request.contextPath}/chat/messages/" + roomId)
                .then(response => response.json())
                .then(data => {
                    var chatArea = document.getElementById('chatArea');
                    chatArea.innerHTML = "";
                    data.forEach(msg => {
                        chatArea.innerHTML += "<div>[" + msg.sender + "] " + msg.content + "</div>";
                    });
                });
        }

        // 메시지 전송 (roomId, sender, content)
        function sendMessage() {
            if (!currentRoomId) {
                alert("채팅방을 먼저 선택하세요");
                return;
            }
            var sender = document.getElementById('sender').value;
            var content = document.getElementById('content').value;
            var payload = "roomId=" + currentRoomId + "&sender=" + sender + "&content=" + content;
            sock.send(payload);
            document.getElementById('content').value = "";
        }
    </script>
</body>
</html>
