<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>예약 시간 목록 조회</title>
</head>
<body>
    <h1>예약 가능 시간 조회</h1>

    <label for="post_seq">게시물 번호:</label>
    <input type="number" id="post_seq" name="post_seq" required>

    <label for="selected_date">선택 날짜:</label>
    <input type="date" id="selected_date" name="selected_date" required>

    <button id="fetchTimeSlots">시간 목록 조회</button>

    <div id="timeSlotList"></div>

	    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
        $(document).ready(function() {
            $("#fetchTimeSlots").click(function() {
                var postSeq      = $("#post_seq").val();
                var selectedDate = $("#selected_date").val();

                if (!postSeq || !selectedDate) {
                    alert("게시물 번호와 날짜를 선택하세요.");
                    return;
                }

                $.ajax({
                    url: "/reservation/time-slot-list",
                    type: "GET",
                    data: {
                        post_seq: postSeq,
                        selected_date: selectedDate
                    },
                    dataType: "json",
                    success: function(response) {
                        $("#timeSlotList").empty();
                        if (response.length === 0) {
                            $("#timeSlotList").append("<p>해당 날짜의 예약 가능한 시간이 없습니다.</p>");
                        } else {
                            var table = "<table border='1'><tr><th>대여 시간</th><th>반납 시간</th><th>상태</th></tr>";
                            $.each(response, function(index, slot) {
                                table += "<tr>" +
                                         "<td>" + slot.rent_at.split(".")[0] + "</td>" +
                                         "<td>" + slot.return_at.split(".")[0] + "</td>" +
                                         "<td>" + (slot.status === 1 ? "예약 가능" : "예약 불가능") + "</td>" +
                                         "</tr>";
                            });
                            table += "</table>";
                            $("#timeSlotList").append(table);
                        }
                    },
                    error: function(xhr, status, error) {
                        console.log("에러 발생: ", error);
                        alert("시간 목록을 불러오는 중 오류가 발생했습니다.");
                    }
                });
            });
        });
    </script>
</body>
</html>
