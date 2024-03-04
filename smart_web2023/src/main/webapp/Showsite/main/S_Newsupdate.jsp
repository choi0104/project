<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="dao" class="ShowSite.Snews_DAO" />
<c:set var="b_idx" value="${param.b_idx}" />
<c:set var="board" value="${dao.getBoard(b_idx)}" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>글쓰기</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/S_Write.css">
</head>
<body>
<c:import var="S_Header" url="S_Header.jsp"/>
<c:import var="S_Footer" url="S_Footer.jsp"/>
	${S_Header}
    <div id="WriteLine">
        <div id="WritePage">
            <div class="container mt-5" >
                <h2 class="text-center mb-4">뉴스 게시글 수정</h2>
                <form name="frm_write" method="post" action="S_Newsupdate_process.jsp" enctype="multipart/form-data">
                <input type="hidden" name="b_idx" value="${b_idx}" >
                <input type="hidden" name="s_idx" value="${member.s_idx}">
				<input type="hidden" name="writer" value="${member.member_name}">
                    <div class="form-group">
                        <label for="title">제목</label>
                        <input type="text" class="form-control" id="title" name="title" value="${board.title}" required>
                    </div>
                    <div class="form-group">
                        <label for="content">내용</label>
                        <textarea class="form-control" id="content" name="content" rows="5" required>${board.content}</textarea>
                    </div>
                    <!-- 파일 업로드를 위한 입력 필드 -->
                    <div class="form-group" style="display:flex;">
	                    <div>
    	                    <label for="file">게시판 첨부 파일</label>
        	                <input type="file" class="form-control-file" id="file" name="uploadFile">
                        </div>
						<input style="margin-left: 230px" type="button" value="목록보기" onclick="location.href='S_News.jsp'">
                    </div>
                    <button type="submit" class="btn btn-primary btn-block">수정 완료</button>
                </form>
            </div>
        </div>
    </div>


	${S_Footer}
</body>
</html>