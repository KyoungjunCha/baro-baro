<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>채팅 테스트</title>
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/stompjs@2/dist/stomp.min.js"></script>
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
                <a href="#" onclick="selectRoom('${r.roomId}')">
                    방번호: ${r.roomId}, 제목: ${r.title}
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
        var stompClient = null;
        var currentRoomId = null;
        console.log(${rooms});

        // WebSocket 연결
        function connectSocket() {
            var socket = new SockJS("${pageContext.request.contextPath}/ws/chat");
            stompClient = Stomp.over(socket);
            stompClient.connect({}, function () {
                console.log('Connected');
            });
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

        // 메시지 전송 (roomId, sender, content를 합쳐 전송)
        function sendMessage() {
            if (!currentRoomId) {
                alert("채팅방을 먼저 선택하세요");
                return;
            }
            var sender = document.getElementById('sender').value;
            var content = document.getElementById('content').value;
            // 메시지 예: roomId=1&sender=홍길동&content=안녕
            var payload = "roomId=" + currentRoomId + "&sender=" + sender + "&content=" + content;

            stompClient.send("", {}, payload); 
            // handler 쪽에서 path 구분 없이 handleTextMessage 처리
            // SockJS의 경우 /ws/chat이 엔드포인트이므로 send("",...) 가능(주소 지정 생략)
            // 실제론 /app/... 식 주소를 특정할 수도 있음

            document.getElementById('content').value = "";
        }
    </script>
</body>
</html>
