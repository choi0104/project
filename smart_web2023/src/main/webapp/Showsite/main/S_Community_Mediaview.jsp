<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="dao" class="ShowSite.Sfree_DAO" />  
<c:set var="b_idx" value="${param.b_idx}"/>
<c:set var="board" value="${dao.getBoard(b_idx)}"/>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>글 상세보기</title>
    <link rel="stylesheet" href="../css/S_Header.css">
    <link rel="stylesheet" href="../css/S_Footer.css">
    <script>
        function deletePost(){
            const ans = confirm("정말로 삭제하겠습니까?")
            //예:true, 아니오:false
            
            if(ans){
                location.href="S_Community_Mediadelete.jsp?b_idx=${board.b_idx}";
            }
        }
    </script>    
</head>
<body>
    <c:import var="S_Header" url="S_Header.jsp"/>
    <c:import var="S_Footer" url="S_Footer.jsp"/>
    ${S_Header}
	<div style="min-width: 1400px;">
	    <div style="max-width: 900px;display: flex;flex-direction: column;margin: 50px auto;background-color: white;box-shadow: 0 0 0px rgba(0, 0, 0, 0.1);border-radius: 8px;overflow: hidden;">
	        <img src="../siteimg/뉴스페이지.jpg" width="100%"height="350px">
	        <div style="width: 85%; margin: 0px auto; margin-top: 50px; display: flex; justify-content: space-between; align-items:flex-end;">
	            <h2 style="text-align: left;font-size: 30px;">${board.title}</h2>
	            <div style="text-align: right;padding-bottom: 20px;width:15%;">${board.post_date}</div>
	        </div><hr style="width: 90%; margin: auto;">
	        <div style="width: 85%; min-height: 400px; margin: 0px auto; margin-top: 30px; margin-bottom: 30px;">
	            ${board.content}
	        </div><hr style="width: 90%; margin: auto;">
	        <div style="width: 95%;  text-align: right;margin-bottom: 50px;">
	            <c:if test="${(not empty member) and (member.s_idx eq 7)}">
	                <input type="button" value="관리자페이지"onclick="location.href='S_Manager.jsp?b_idx=${board.b_idx}'">
	            </c:if>
	            <c:if test="${(not empty member) and ((board.writer eq member.member_name) or (member.s_idx eq 7))}">
	                <input type="button" value="수정하기" onclick="location.href='S_Community_Freeupdate.jsp?b_idx=${board.b_idx}'">
	                <input type="button" value="삭제하기"onclick="deletePost()">
	            </c:if>
	            <input type="button" value="목록보기" onclick="location.href='S_Community.jsp'">
	        </div>
	    </div>
	</div>        
${S_Footer}
</body>
<script>
</script>
</html>