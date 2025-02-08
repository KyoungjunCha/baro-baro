<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<c:forEach var="ReceivedUserReview" items="${reviewSummary.receivedUserReviews}" varStatus="status">
	    	${ReceivedUserReview.userReview}: ${ReceivedUserReview.receivedReviewCount}
	    	<br/>
		</c:forEach>
		
	
	</div>

</body>
</html>