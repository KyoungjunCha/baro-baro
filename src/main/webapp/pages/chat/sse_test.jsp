<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>SSE Example</title>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const eventSource = new EventSource("http://localhost:8089/chat/sse/" + 1002);

            // Handle the "connect" event sent by the server
            eventSource.addEventListener("connect", function (event) {
            	const jsonData =  JSON.parse(event.data);
            	for(e of jsonData){
            		console.log(e);
            		console.log(e.chatRoomSeq);
            	}
            	
                const data = event.data;
                const messageContainer = document.getElementById("messages");
                const messageElement = document.createElement("p");
                messageElement.textContent = `Connection Message: ${data}`;
                messageContainer.appendChild(messageElement);
            });

            // Handle generic messages (if any)
            eventSource.onmessage = function (event) {
                const data = event.data;
                const messageContainer = document.getElementById("messages");
                const messageElement = document.createElement("p");
                messageElement.textContent = `Message: ${data}`;
                messageContainer.appendChild(messageElement);
            };

            // Handle errors
            eventSource.onerror = function () {
                console.error("An error occurred with the SSE connection.");
                eventSource.close();
            };
        });
    </script>
</head>
<body>
    <h1>Server-Sent Events (SSE) Example</h1>
    <div id="messages">
        <p>Waiting for messages...</p>
    </div>
</body>
</html>
