<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>관리자 페이지</title>
</head>
<body>
    <h1>유저 관리 페이지</h1>
    <table>
        <thead>
            <tr>
                <th>이메일</th>
                <th>닉네임</th>
                <th>상태</th>
                <th>권한</th>
                <th>수정</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="user" items="${users}">
                <tr>
                    <td>${user.email}</td>
                    <td>${user.nickname}</td>
                    <td>
                        <form action="/admin/updateUser" method="POST">
                            <input type="hidden" name="userSeq" value="${user.userSeq}">
                            <select name="status">
                                <option value="ACTIVE" ${user.status == 'ACTIVE' ? 'selected' : ''}>활성</option>
                                <option value="INACTIVE" ${user.status == 'INACTIVE' ? 'selected' : ''}>휴면</option>
                                <option value="DELETE" ${user.status == 'DELETE' ? 'selected' : ''}>삭제</option>
                            </select>
                    </td>
                    <td>
                        <select name="role">
                            <option value="GENERAL" ${user.role == 'GENERAL' ? 'selected' : ''}>일반</option>
                            <option value="ADMIN" ${user.role == 'ADMIN' ? 'selected' : ''}>관리자</option>
                        </select>
                    </td>
                    <td>
                        <input type="submit" value="수정">
                    </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <form action="/form_logout_process" method="POST">
        <input type="submit" value="로그아웃">
    </form>

</body>
</html>