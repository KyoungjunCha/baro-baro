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

    /* 파란 버튼 */
    .blue-button {
        background-color: blue;
    }

    /* 빨간 버튼 */
    .red-button {
        background-color: red;
    }

    /* 민트 버튼 */
    .mint-button {
        background-color: #2ac1bc;
    }

    /* 브라운 버튼 */
    .brown-button {
        background-color: #8B4513;
    }

    /* 노란 버튼 */
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

    /* rentalTable */
    #rentalTable thead {
        background-color: #2ac1bc;
        color: white;
    }

    /* reservationTable */
    #reservationTable thead {
        background-color: #FDECC8;
        color: black;
    }
</style>



</head>

<body>
<p>유저 시퀀스 : ${sessionScope['SESS_USER_SEQ']}</p>
<h2> 😊내가 등록한 물품 관리하기😊 </h2>

    <table id="rentalTable">
        <thead>
            <tr>
                <th>거래요청자 닉네임</th>
                <th>게시물</th>
                <th>제품명</th>
                <th>대여 시작시간</th>
                <th>대여 장소</th>
                <th>반납 시간</th>
                <th>반납 장소</th>
                <th>가격</th>
                <th>안내</th>
                <th>현재 상태</th>
            </tr>
        </thead>
        
        <tbody>
            <!-- 데이터가 여기에 추가됩니다 -->
        </tbody>
    </table>



<h2> 😘나의 예약 현황😘 </h2>
	
	<table id="reservationTable">
        <thead>
            <tr>
                <th>물품소유자 닉네임</th>
                <th>게시물</th>
                <th>제품명</th>
                <th>대여 시작시간</th>
                <th>대여 장소</th>
                <th>반납 시간</th>
                <th>반납 장소</th>
                <th>가격</th>
                <th>안내</th>
                <th>현재 상태</th>
            </tr>
        </thead>
        
        <tbody>
            <!-- 데이터가 여기에 추가됩니다 -->
        </tbody>
    </table>
    
    

<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script>

// 페이지가 로드되면 데이터 요청
document.addEventListener("DOMContentLoaded", () => {
	
	// 세션 꺼내기
 	//var userSeq = ${sessionScope.user_info.userSeq};
<%-- 	let userSeq = "<%= session.getAttribute("userSeq") %>"; --%>
	//console.log("QWER : " + userSeq)
//     if (!userSeq || userSeq === "null") {
//         console.error("세션 정보가 없습니다.");
//         return;
//     }
	let userSeq = ${sessionScope['SESS_USER_SEQ']}

    // rentalTable 가져오기 ======================================================================
    fetch("/reservation/getAllTimeSlots", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        credentials: "include" , 								// JSESSIONID 같은 쿠키 기반 세션을 자동 포함
        body: JSON.stringify({ userSeq: userSeq }) 			// 서버에서 세션의 userSeq 받는다면 필요. 테스트용으로 막아둠
    })
    .then(response => {
        if (!response.ok) {
            throw new Error("서버 응답 오류");
        }
        return response.json();
    })
    .then(data => {
        console.log("서버 응답 데이터1:", data); 
        populateRentalTable(data); // 서버에서 받은 데이터를 테이블에 적용
    })
    .catch(error => console.error("데이터 불러오기 실패:", error));

    

	// reservationTable 가져오기 ======================================================================
    fetch("/reservation/getAllReservation", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        credentials: "include" , 								// JSESSIONID 같은 쿠키 기반 세션을 자동 포함
        body: JSON.stringify({ userSeq: userSeq }) 			// 서버에서 세션의 userSeq 받는다면 필요. 테스트용으로 막아둠
    })
    .then(response => {
        if (!response.ok) {
            throw new Error("서버 응답 오류");
        }
        return response.json();
    })
    .then(data => {
        console.log("서버 응답 데이터2:", data); 
        populateReservationTable(data); // 서버에서 받은 데이터를 테이블에 적용
    })
    .catch(error => console.error("데이터 불러오기 실패:", error));


});



// rentalTable 에 데이터 추가 함수 ======================================================================
function populateRentalTable(rentalData) {
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
	            acceptButton1.classList.add("blue-button");
	            
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
	            rejectButton1.classList.add("red-button");
	            
	         	// 버튼에 예약번호 숨기기
	            rejectButton1.dataset.reservationSeq = rental.reservation_seq;
	            
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
	            acceptButton4.classList.add("blue-button");
	            
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
	            rejectButton4.classList.add("red-button");
	            
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

// reservationTable 에 데이터 추가 함수 ======================================================================
function populateReservationTable(reservationData) {
	const tableBody = document.getElementById('reservationTable').querySelector('tbody');
    tableBody.innerHTML = ""; // 기존 데이터 초기화
    
	// 테이블에 데이터 추가
	reservationData.forEach((reservation, index) => {
    	const row = document.createElement('tr');

	    // 물품 주인 닉네임
	    const nicknameCell = document.createElement('td');
	    nicknameCell.textContent = reservation.owner_nickname;
	    nicknameCell.dataset.ownerNickname = reservation.owner_nickname; // 닉네임 숨기기
	    row.appendChild(nicknameCell);
		
	    // 게시물
	    const titleCell = document.createElement('td');
	    titleCell.textContent = reservation.title;
	    row.appendChild(titleCell);
	    
	    // 제품명
	    const productNameCell = document.createElement('td');
	    productNameCell.textContent = reservation.product_name;
	    row.appendChild(productNameCell);
	    
	    // 대여 시작시간
	    const rentAtCell = document.createElement('td');
	    rentAtCell.textContent = new Date(reservation.rent_at).toLocaleString();
	    row.appendChild(rentAtCell);
		
	    // 대여 장소
	    const rentLocationCell = document.createElement('td');
	    rentLocationCell.textContent = reservation.rent_location;
	    row.appendChild(rentLocationCell);
	    
	    // 대여 반납시간
	    const returnAtCell = document.createElement('td');
	    returnAtCell.textContent = new Date(reservation.return_at).toLocaleString();
	    row.appendChild(returnAtCell);
		
	    // 반납 장소
	    const returnLocationCell = document.createElement('td');
	    returnLocationCell.textContent = reservation.return_location;
	    row.appendChild(returnLocationCell);
	    
	    // 대여가격
	    const priceCell = document.createElement('td');
	    priceCell.textContent = reservation.price.toLocaleString() + ' 원';
	    row.appendChild(priceCell);
	
	 	// 설명이에여
	    const noteCell = document.createElement('td');
	    let statusText = "";

	    switch (reservation.status) {
	        case 1:
	            statusText = "대여 요청을 보냈어요! 😍 물품주인이 대여 요청을 수락 시, 예약이 확정됩니다! 📢";
	            break;
	        case 2:
	            statusText = "대여확정 상태에요! 📢 (rent_at 3일전)까지만 취소요청이 가능합니다! 😬";
	            break;
	        case 3:
	            statusText = "물품주인이 대여 요청을 거절하였어요 😂";
	            break;
	        case 4:
	            statusText = "물품주인이 대여 취소요청을 수락 시, 취소가 확정됩니다!";
	            break;
	        case 5:
	            statusText = "물품주인이 대여 취소요청을 수락하였어요 👌";
	            break;
	        case 6:
	            statusText = "대여 거래가 완료된 항목입니다 ❤️";
	            break;
	        case 7:
	            statusText = "대여확정 상태에요!📢 물품주인이 대여 취소요청을 거절하였어요 😑";
	            break;
	        default:
	            statusText = "알 수 없는 상태입니다. 페이지 관리자에게 문의해주세요"; // 예외적인 경우 대비
	    }
	    noteCell.textContent = statusText;
	    row.appendChild(noteCell);

	    
	 	// 현재상태 버튼칸
	    const buttonCell = document.createElement('td');
	    
	    switch (reservation.status) {
	        case 2:
	            // 예약 취소 요청 버튼
	            const cancelRequestButton = document.createElement('button');
	            cancelRequestButton.textContent = "예약 취소 요청";
	            cancelRequestButton.classList.add("red-button");
	            
	         	// 버튼에 예약번호 숨기기
	            cancelRequestButton.dataset.reservationSeq = reservation.reservation_seq;
	            
	            cancelRequestButton.addEventListener('click', async (event) => {
					// 버튼 자체에서 숨겨진 데이터 가져오기
		            const reservationSeq = event.target.dataset.reservationSeq;
		            const ownerNickname  = event.target.closest('tr').querySelector('td').dataset.ownerNickname;
		            
		            // 확인창 표시
		            const confirmResult = confirm('['+ownerNickname+']사용자에게 대여 취소를 요청 보낼까요?');
		            if (!confirmResult) return;

		            try {
		                const response = await fetch('/reservation/cancle-request', {
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
	            buttonCell.appendChild(cancelRequestButton);
	            break;

	        case 1:
	            const Button1 = document.createElement('button');
	            Button1.textContent = "예약 요청중";
	            Button1.classList.add("brown-button");
	            Button1.disabled = true;
	            buttonCell.appendChild(Button1);
	            break;

	        case 3:
	            const Button3 = document.createElement('button');
	            Button3.textContent = "예약 거절됨";
	            Button3.classList.add("brown-button");
	            Button3.disabled = true;
	            buttonCell.appendChild(Button3);
	            break;
	            
	        case 4:
	            const Button4 = document.createElement('button');
	            Button4.textContent = "예약 취소 요청중";
	            Button4.classList.add("brown-button");
	            Button4.disabled = true;
	            buttonCell.appendChild(Button4);
	            break;

	        case 5:
	            const Button5 = document.createElement('button');
	            Button5.textContent = "예약 취소 완료";
	            Button5.classList.add("brown-button");
	            Button5.disabled = true;
	            buttonCell.appendChild(Button5);
	            break;

	        case 6:
	            const Button6 = document.createElement('button');
	            Button6.textContent = "완료된 거래";
	            Button6.classList.add("yellow-button");
	            Button6.disabled = true;
	            buttonCell.appendChild(Button6);
	            break;

	        case 7:
	            const Button7 = document.createElement('button');
	            Button7.textContent = "대여 확정 상태";
	            Button7.classList.add("mint-button");
	            Button7.disabled = true;
	            buttonCell.appendChild(Button7);
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