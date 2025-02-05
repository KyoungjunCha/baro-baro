<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title> 마이페이지 - 예약 관리 </title>
    
<style>
    /* 공통 버튼 스타일 */
    button {
        color: white;
        cursor: pointer;
        border: none;
        padding: 8px 12px;
        font-size: 14px;
        border-radius: 5px;
        margin: 0 8px;
    }

    /* 수락 버튼 (파란색) */
    .accept-button {
        background-color: blue;
    }

    /* 거절 버튼 (빨간색) */
    .reject-button {
        background-color: red;
    }

    /* 대여 확정 상태 버튼 (민트색) */
    .mint-button {
        background-color: #2ac1bc;
    }

    /* 거절한 거래, 취소된 거래 버튼 (브라운색) */
    .brown-button {
        background-color: #8B4513;
    }

    /* 완료된 거래 버튼 (연노란색) */
    .yellow-button {
        background-color: #FFD700;
    }

    /* 버튼 비활성화 스타일 */
    button:disabled {
        cursor: not-allowed;
        opacity: 0.7;
    }

    /* 테이블 스타일 */
    table {
        width: 100%;
        border-collapse: collapse;
    }

    th, td {
        border: 1px solid #ddd;
        padding: 10px;
        text-align: center;
    }

    th {
        background-color: #f2f2f2;
    }
</style>


</head>

<body>

<h2> 😍내가 등록한 물품 요청관리하기😍 </h2>

    <table id="rentalTable">
        <thead>
            <tr>
                <th>거래요청자 닉네임</th>
                <th>게시물</th>
                <th>제품명</th>
                <th>대여 시작시간</th>
                <th>대여 장소</th>
                <th>대여 반납시간</th>
                <th>반납 장소</th>
                <th>대여 가격</th>
                <th>설명이에여</th>
                <th>현재 상태</th>
            </tr>
        </thead>
        
        <tbody>
            <!-- 데이터가 여기에 추가됩니다 -->
        </tbody>
    </table>



<h2> 🥰나의 예약 현황🥰 </h2>

<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script>
//백엔드에서 가져온 데이터 (예시)
// const rentalData = [
//     {
//         nickname: "user1",
//         rent_at: "2025-02-10T15:00:00",
//         return_at: "2025-02-12T15:00:00",
//         price: 30000
//     },
//     {
//         nickname: "user2",
//         rent_at: "2025-02-08T10:00:00",
//         return_at: "2025-02-09T10:00:00",
//         price: 15000
//     },
//     {
//         nickname: "user3",
//         rent_at: "2025-02-15T09:00:00",
//         return_at: "2025-02-16T09:00:00",
//         price: 20000
//     }
// ];


// 페이지가 로드되면 데이터 요청
document.addEventListener("DOMContentLoaded", () => {
	
	// 로그인한 사용자인지 확인하기
    let sessionUserSeq = "<%= session.getAttribute("userSeq") %>";
    if (!sessionUserSeq || sessionUserSeq === "null") {
        console.error("세션 정보가 없습니다. 로그인 후 이용해주세요");
        return; // 세션 정보 없으면 요청하지 않음
    }
    
    fetch("/reservation/getAllTimeSlots", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        credentials: "include" , 							// JSESSIONID 같은 쿠키 기반 세션을 자동 포함
        body: JSON.stringify({ userSeq: sessionUserSeq }) 	// 서버에서 userSeq 받는다면 필요. 테스트용으로 막아둠
    })
    .then(response => {
        if (!response.ok) {
            throw new Error("서버 응답 오류");
        }
        return response.json();
    })
    .then(data => {
        console.log("서버 응답 데이터:", data); 
        populateTable(data); // 서버에서 받은 데이터를 테이블에 적용
    })
    .catch(error => console.error("데이터 불러오기 실패:", error));
});



//테이블에 데이터 추가 함수
function populateTable(rentalData) {
	const tableBody = document.getElementById('rentalTable').querySelector('tbody');
    tableBody.innerHTML = ""; // 기존 데이터 초기화
    
	// 테이블에 데이터 추가
	rentalData.forEach((rental, index) => {
    	const row = document.createElement('tr');

	    // 대여 요청자 닉네임
	    const nicknameCell = document.createElement('td');
	    nicknameCell.textContent = rental.requestor_nickname;
	    nicknameCell.dataset.requestorNickname = rental.requestor_nickname; // 닉네임 숨기기
	    row.appendChild(nicknameCell);
		
	    // 게시물
	    const titleCell = document.createElement('td');
	    titleCell.textContent = rental.title;
	    row.appendChild(titleCell);
	    
	    // 제품명
	    const productNameCell = document.createElement('td');
	    productNameCell.textContent = rental.product_name;
	    row.appendChild(productNameCell);
	    
	    // 대여 시작시간
	    const rentAtCell = document.createElement('td');
	    rentAtCell.textContent = new Date(rental.rent_at).toLocaleString();
	    row.appendChild(rentAtCell);
		
	    // 대여 장소
	    const rentLocationCell = document.createElement('td');
	    rentLocationCell.textContent = rental.rent_location;
	    row.appendChild(rentLocationCell);
	    
	    // 대여 반납시간
	    const returnAtCell = document.createElement('td');
	    returnAtCell.textContent = new Date(rental.return_at).toLocaleString();
	    row.appendChild(returnAtCell);
		
	    // 반납 장소
	    const returnLocationCell = document.createElement('td');
	    returnLocationCell.textContent = rental.return_location;
	    row.appendChild(returnLocationCell);
	    
	    // 대여가격
	    const priceCell = document.createElement('td');
	    priceCell.textContent = rental.price.toLocaleString() + ' 원';
	    row.appendChild(priceCell);
	
	 	// 설명이에여
	    const noteCell = document.createElement('td');
	    let statusText = "";

	    switch (rental.status) {
	        case 1:
	            statusText = "새로운 대여요청이 들어왔어요! 😍 상대방이 수락을 기다리고있어요";
	            break;
	        case 2:
	            statusText = "내가 대여요청을 수락하였어요! 👌 대여확정 상태에요! 📢";
	            break;
	        case 3:
	            statusText = "내가 대여요청을 거절하였어요! 😬";
	            break;
	        case 4:
	            statusText = "해당 대여자가 대여 취소를 희망해요! 😂 상대방이 수락을 기다리고있어요";
	            break;
	        case 5:
	            statusText = "내가 대여취소요청을 수락하였어요! 👌 대여취소 상태에요! 📢";
	            break;
	        case 6:
	            statusText = "해당 대여자와의 거래가 완료되었어요! 좋은 거래였습니다 ❤️";
	            break;
	        case 7:
	            statusText = "대여확정 상태에요!📢 대여자는 대여 취소를 요청하였지만, 내가 거절하였어요. 😑";
	            break;
	        default:
	            statusText = "알 수 없는 상태입니다. 페이지 관리자에게 문의해주세요"; // 예외적인 경우 대비
	    }
	    noteCell.textContent = statusText;
	    row.appendChild(noteCell);

	    
	 	// 현재상태 버튼칸
	    const buttonCell = document.createElement('td');
	    
	    switch (rental.status) {
	        case 1:
	            // 수락 버튼
	            const acceptButton1 = document.createElement('button');
	            acceptButton1.textContent = "수락";
	            acceptButton1.classList.add("accept-button");
	            
	         	// 버튼에 예약번호 숨기기
	            acceptButton1.dataset.reservationSeq = rental.reservation_seq;
	            
				acceptButton1.addEventListener('click', async (event) => {
					// 버튼 자체에서 숨겨진 데이터 가져오기
		            const reservationSeq    = event.target.dataset.reservationSeq;
		            const requestorNickname = event.target.closest('tr').querySelector('td').dataset.requestorNickname;

		            // 확인창 표시
		            const confirmResult = confirm('['+requestorNickname+']사용자의 대여 요청을 수락하시겠습니까?');
		            if (!confirmResult) return;

		            try {
		                const response = await fetch('/reservation/accept-reservation', {
		                    method: 'POST',
		                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
		                    body: new URLSearchParams({ reservationSeq: reservationSeq }),
		                });

		                const result = await response.text();
		                alert(result);

		                if (response.ok) {
		                    window.location.reload(); // 페이지 새로고침
		                }
		            } catch (error) {
		                console.error('에러 발생:', error);
		                alert('오류가 발생했습니다.');
		            }
		        });
		        buttonCell.appendChild(acceptButton1);
	        

	            // 거절 버튼
	            const rejectButton1 = document.createElement('button');
	            rejectButton1.textContent = "거절";
	            rejectButton1.classList.add("reject-button");
	            
	         	// 버튼에 예약번호 숨기기
	            rejectButton1.dataset.reservationSeq    = rental.reservation_seq;
	            
	            rejectButton1.addEventListener('click', async (event) => {
					// 버튼 자체에서 숨겨진 데이터 가져오기
		            const reservationSeq    = event.target.dataset.reservationSeq;
		            const requestorNickname = event.target.closest('tr').querySelector('td').dataset.requestorNickname;
		            
		            // 확인창 표시
		            const confirmResult = confirm('['+requestorNickname+']사용자의 대여 요청을 거절하시겠습니까?');
		            if (!confirmResult) return;

		            try {
		                const response = await fetch('/reservation/refuse-reservation', {
		                    method: 'POST',
		                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
		                    body: new URLSearchParams({ reservationSeq: reservationSeq }),
		                });

		                const result = await response.text();
		                alert(result);

		                if (response.ok) {
		                    window.location.reload(); // 페이지 새로고침
		                }
		            } catch (error) {
		                console.error('에러 발생:', error);
		                alert('오류가 발생했습니다.');
		            }
		        });
	            buttonCell.appendChild(rejectButton1);
	            break;

	        case 4:
	            // 수락 버튼
	            const acceptButton4 = document.createElement('button');
	            acceptButton4.textContent = "수락";
	            acceptButton4.classList.add("accept-button");
	            
	         	// 버튼에 예약번호 숨기기
	            acceptButton4.dataset.reservationSeq    = rental.reservation_seq;
	            
	            acceptButton4.addEventListener('click', async (event) => {
					// 버튼 자체에서 숨겨진 데이터 가져오기
		            const reservationSeq    = event.target.dataset.reservationSeq;
		            const requestorNickname = event.target.closest('tr').querySelector('td').dataset.requestorNickname;
		            
		            // 확인창 표시
		            const confirmResult = confirm('['+requestorNickname+']사용자의 대여 취소요청을 수락하시겠습니까?');
		            if (!confirmResult) return;

		            try {
		                const response = await fetch('/reservation/cancle-accept', {
		                    method: 'POST',
		                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
		                    body: new URLSearchParams({ reservationSeq: reservationSeq }),
		                });

		                const result = await response.text();
		                alert(result);

		                if (response.ok) {
		                    window.location.reload(); // 페이지 새로고침
		                }
		            } catch (error) {
		                console.error('에러 발생:', error);
		                alert('오류가 발생했습니다.');
		            }
		        });
	            buttonCell.appendChild(acceptButton4);

	            // 거절 버튼
	            const rejectButton4 = document.createElement('button');
	            rejectButton4.textContent = "거절";
	            rejectButton4.classList.add("reject-button");
	            
	         	// 버튼에 예약번호 숨기기
	            rejectButton4.dataset.reservationSeq    = rental.reservation_seq;
	            
	            rejectButton4.addEventListener('click', async (event) => {
					// 버튼 자체에서 숨겨진 데이터 가져오기
		            const reservationSeq    = event.target.dataset.reservationSeq;
		            const requestorNickname = event.target.closest('tr').querySelector('td').dataset.requestorNickname;
		            
		            // 확인창 표시
		            const confirmResult = confirm('['+requestorNickname+']사용자의 대여 취소요청을 거절하시겠습니까?');
		            if (!confirmResult) return;

		            try {
		                const response = await fetch('/reservation/cancle-reject', {
		                    method: 'POST',
		                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
		                    body: new URLSearchParams({ reservationSeq: reservationSeq }),
		                });

		                const result = await response.text();
		                alert(result);

		                if (response.ok) {
		                    window.location.reload(); // 페이지 새로고침
		                }
		            } catch (error) {
		                console.error('에러 발생:', error);
		                alert('오류가 발생했습니다.');
		            }
		        });
	            buttonCell.appendChild(rejectButton4);
	            break;

	        case 2:
	            const confirmButton = document.createElement('button');
	            confirmButton.textContent = "대여 확정 상태";
	            confirmButton.classList.add("mint-button");
	            confirmButton.disabled = true;
	            buttonCell.appendChild(confirmButton);
	            break;

	        case 3:
	            const rejectedButton = document.createElement('button');
	            rejectedButton.textContent = "거절한 거래";
	            rejectedButton.classList.add("brown-button");
	            rejectedButton.disabled = true;
	            buttonCell.appendChild(rejectedButton);
	            break;

	        case 5:
	            const canceledButton = document.createElement('button');
	            canceledButton.textContent = "취소된 거래";
	            canceledButton.classList.add("brown-button");
	            canceledButton.disabled = true;
	            buttonCell.appendChild(canceledButton);
	            break;

	        case 6:
	            const completedButton = document.createElement('button');
	            completedButton.textContent = "완료된 거래";
	            completedButton.classList.add("yellow-button");
	            completedButton.disabled = true;
	            buttonCell.appendChild(completedButton);
	            break;

	        case 7:
	            const confirmedButton = document.createElement('button');
	            confirmedButton.textContent = "대여 확정 상태";
	            confirmedButton.classList.add("mint-button");
	            confirmedButton.disabled = true;
	            buttonCell.appendChild(confirmedButton);
	            break;

	        default:
	            buttonCell.textContent = "알 수 없는 상태";
	    }
	    row.appendChild(buttonCell);

	
	    // 행 추가
	    tableBody.appendChild(row);
	});
}
</script>

</body>
</html>