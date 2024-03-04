<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>글쓰기</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/S_Write.css">
</head>
  <script>
    function processInput(inputElement) {
      // 사용자 입력에서 HTML 태그를 제거하고, 순수한 텍스트로 설정
      var textContent = inputElement.value;
      var div = document.createElement('div');
      div.innerHTML = textContent;
      var plainText = div.innerText;

      // 텍스트로 설정된 값을 다시 입력 필드에 할당
      inputElement.value = plainText;
    }
  </script>
<body>
<c:import var="S_Header" url="S_Header.jsp"/>
<c:import var="S_Footer" url="S_Footer.jsp"/>
	${S_Header}
    <div id="WriteLine">
        <div id="WritePage">
            <div class="container mt-5" >
                <h2 class="text-center mb-4">자유 게시판 게시글 작성</h2>
                <!-- 게시글 작성 폼 -->
                <form name="frm_write" method="post" action="S_Community_Freewrite_process.jsp" enctype="multipart/form-data">
				<input type="hidden" name="s_idx" value="${member.s_idx}">
				<input type="hidden" name="writer" value="${member.member_name}">
                    <div class="form-group">
                        <label for="title">제목</label>
                        <input type="text" class="form-control" id="title" name="title" required onblur="processInput(this)">
                    </div>
                    <div class="form-group">
                        <label for="content">내용</label>
                        <textarea class="form-control" id="content" name="content" rows="5" required onblur="processInput(this)"></textarea>
                    </div>
                    <!-- 파일 업로드를 위한 입력 필드 -->
                    <div class="form-group" style="display:flex;">
	                    <div>
    	                    <label for="file">게시판 첨부 파일</label>
        	                <input type="file" class="form-control-file" id="file" name="uploadFile">
                        </div>
						<input style="margin-left: 230px" type="button" value="목록보기" onclick="location.href='S_Community.jsp'">
                    </div>
                    <button type="submit" class="btn btn-primary btn-block">작성 완료</button>
                </form>
            </div>
        </div>
    </div>
	${S_Footer}
</body>
</html>