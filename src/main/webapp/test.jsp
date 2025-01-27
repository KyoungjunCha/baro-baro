<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="x" 		uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib prefix="sql" 	uri="http://java.sun.com/jsp/jstl/sql" %>
 
    
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>FullCalendar 타임 등록 테스트</title>
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css" rel="stylesheet" />
    <style>
      body {
        font-family: Arial, sans-serif;
      }
      #calendar {
        max-width: 800px;
        margin: 40px auto;
      }
    </style>
  </head>
  <body>
    <h1 style="text-align: center">캘린더</h1>
    <div id="calendar"></div>

    <!-- Modal (일정 등록 폼) -->
    <div
      id="modal"
      style="
        display: none;
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background: white;
        padding: 20px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        z-index: 100;
      "
    >
      <h3>새 일정 등록</h3>
      <form id="eventForm">
        <label>일정 제목:</label><br />
        <input type="text" id="eventTitle" required /><br /><br />
        <label>시작 날짜:</label><br />
        <input type="date" id="eventStart" required /><br /><br />
        <label>종료 날짜:</label><br />
        <input type="date" id="eventEnd" /><br /><br />
        <button type="submit">등록</button>
        <button type="button" onclick="closeModal()">취소</button>
      </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>
    <script>
      document.addEventListener('DOMContentLoaded', function () {
        const calendarEl = document.getElementById('calendar');
        const calendar = new FullCalendar.Calendar(calendarEl, {
          initialView: 'dayGridMonth',
          editable: true,
          selectable: true,
          events: [{ title: '기본 일정', start: '2025-01-25' }],
          dateClick: function (info) {
            openModal(info.dateStr);
          },
        });

        calendar.render();

        // Modal 관련 함수
        const modal = document.getElementById('modal');
        const eventForm = document.getElementById('eventForm');
        const eventTitleInput = document.getElementById('eventTitle');
        const eventStartInput = document.getElementById('eventStart');
        const eventEndInput = document.getElementById('eventEnd');

        function openModal(dateStr) {
          modal.style.display = 'block';
          eventStartInput.value = dateStr;
        }

        function closeModal() {
          modal.style.display = 'none';
          eventForm.reset();
        }

        // 일정 등록
        eventForm.addEventListener('submit', function (e) {
          e.preventDefault();
          const title = eventTitleInput.value;
          const start = eventStartInput.value;
          const end = eventEndInput.value || start;

          calendar.addEvent({
            title: title,
            start: start,
            end: end,
          });

          closeModal();
        });

        window.closeModal = closeModal;
      });
    </script>
  </body>
</html>
