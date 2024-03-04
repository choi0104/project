<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="dao" class="ShowSite.Sfree_DAO" />
<!-- 검색관련 데이터를 저장하는 SearchDTO객체를 생성하고 전달값을 세팅함 -->
<jsp:useBean id="sDto" class="ShowSite.S_SearchDTO" />
<jsp:setProperty name="sDto" property="*" />

<c:set var="b_idx" value="${param.b_idx}"/>
<c:set var="board" value="${dao.getBoard(b_idx)}"/>

<c:set var="boardList" value="${dao.getBoards(sDto)}" />

<!-- 1. 총게시물수 : totalRows  -->
<c:set var="totalRows" value="${boardList.size()}" />

<!-- 2. 한 페이지에 보여줄 게시물수 : rows_page -->
<c:set var="rows_page" value="12" />

<!-- 3. 한 페이지블록에 보여줄 페이지수 : pages_pageBlock -->
<c:set var="pages_pageBlock" value="5" />

<!-- 4. 현재 페이지번호 : pageNum -->
<c:choose>
	<c:when test="${empty param.pageNum}"><c:set var="pageNum" value="1" /></c:when>
	<c:otherwise><c:set var="pageNum" value="${param.pageNum}" /></c:otherwise>
</c:choose>

<!-- 5. 게시물의 시작번호 : startNum -->
<c:set var="startNum" value="${(pageNum-1)*rows_page +1}" />

<!-- 6. 게시물의 끝번호 : endNum -->
<c:set var="endNum" value="${(pageNum)*rows_page}" />

<!-- 7. 현재 페이지블록번호 : pageBlock -->
<c:choose>
	<c:when test="${empty param.pageBlock}"><c:set var="pageBlock" value="1" /></c:when>
	<c:otherwise><c:set var="pageBlock" value="${param.pageBlock}" /></c:otherwise>
</c:choose>

<!-- 8. 마지막/총 페이지번호 : total_pageNum -->
<fmt:parseNumber var="tPageNum" value="${Math.ceil(totalRows/rows_page)}" integerOnly="true" />
<c:set var="total_pageNum" value="${tPageNum}" />

<!-- 9. 마지막 페이지블록번호 : last_pageBlock -->
<fmt:parseNumber var="lPageBlock" value="${Math.ceil(total_pageNum/pages_pageBlock)}" integerOnly="true" />
<c:set var="last_pageBlock" value="${lPageBlock}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link rel="stylesheet" href="../css/S_Community.css">
</head>
<body>
<c:import var="S_Header" url="S_Header.jsp"/>
<c:import var="S_Footer" url="S_Footer.jsp"/>
	${S_Header}

    <div id="CommunityLine">
        <div id="CommunityPage">
            <img src="../siteimg/커뮤니티페이지.jpg" width="100%"height="350px">
            <div style="width: 85%; margin: 0px auto; margin-top: 50px; display: flex; justify-content: space-between; align-items:flex-end;">
                <h2 style="text-align: left;">커뮤니티</h2>
			    <form>
				    <div style="display: flex; height: 25px; padding-bottom: 20px;">
						<select name="searchField">
				            <option value="title">제목</option>
				            <option value="content">내용</option>
				        </select>
						<input type="text" name="searchWord" placeholder="검색...">
						<input type="submit" value="검색">
				    </div>
				</form>
            </div>
            <div class="community-buttons" style="display: flex; justify-content: center; width: 85%; margin: 0 auto;">
                <button onclick="showCommunity(1)" style="width: 50%;">커뮤니티 1</button>
                <button onclick="showCommunity(2)" style="width: 50%;">커뮤니티 2</button>
            </div>
        
            <div id="community1" style="display: block;">
        
                <table>
                            <c:choose>
                <c:when test="${empty boardList}">
                    <tr><td colspan="6">등록된 게시물이 없습니다</td></tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="i" begin="${startNum}" end="${endNum}" >
						<c:if test="${not empty boardList[i-1]}"><!-- boardList에 저장된 데이터가 있는 경우 출력-->  
                
                        <tr>
                            <td><a href="S_Community_Freeview.jsp?b_idx=${boardList[i-1].b_idx}"> ${boardList[i-1].title} </a></td>
                            <td><a href="S_Community_Freeview.jsp?b_idx=${boardList[i-1].b_idx}">${boardList[i-1].content}</a></td>
                            <td>${boardList[i-1].writer}</td>
                            <td>${boardList[i-1].post_date}</td>
                        </tr>
                        	                    </c:if>
						<c:if test="${not empty boardList[i-1] && i % 3 == 0}"><!-- boardList에 저장된 데이터가 있는 경우 출력-->  
							<tr></tr>
	                    </c:if>
    	            </c:forEach>
        	    </c:otherwise>
        	</c:choose>
                        
                </table>
        
                <!-- 페이지 네비게이션 -->
	        <div class="pagination">
	            <c:if test="${not empty boardList}" >
                   <%@ include file="S_CommunityPaging.jsp" %>
	            </c:if>
            </div>
            </div>
            <div id="community2" style="display: none;">
                <table>
		            <c:choose>
		                <c:when test="${empty boardList}">
		                    <tr><td colspan="6">등록된 게시물이 없습니다</td></tr>
		                </c:when>
		                <c:otherwise>
		                    <c:forEach var="i" begin="${startNum}" end="${endNum}" >
								<c:if test="${not empty boardList[i-1]}"><!-- boardList에 저장된 데이터가 있는 경우 출력-->  
		                
		                        <tr>
		                            <td><a href="S_Community_Mediaview.jsp?b_idx=${boardList[i-1].b_idx}"> ${boardList[i-1].title} </a></td>
		                            <td><a href="S_Community_Mediaview.jsp?b_idx=${boardList[i-1].b_idx}">${boardList[i-1].content}</a></td>
		                            <td>${boardList[i-1].writer}</td>
		                            <td>${boardList[i-1].post_date}</td>
		                        </tr>
		                        	                    </c:if>
								<c:if test="${not empty boardList[i-1] && i % 3 == 0}"><!-- boardList에 저장된 데이터가 있는 경우 출력-->  
									<tr></tr>
			                    </c:if>
		    	            </c:forEach>
		        	    </c:otherwise>
		        	</c:choose>
                </table>
        
                <!-- 페이지 네비게이션 -->
                <div class="pagination">
                    <a href="#" class="active">1</a>
                    <a href="#">2</a>
                    <a href="#">3</a>
                    <!-- 추가적으로 필요한 페이지에 대한 링크를 추가할 수 있습니다. -->
                </div>
        
            </div>
            	        <div style="width: 95%;  text-align: right;margin-bottom: 50px;">
	            <c:if test="${(not empty member) and (member.s_idx eq 7)}">
	                <input type="button" value="관리자페이지"onclick="location.href='S_Manager.jsp?b_idx=${board.b_idx}'">
	            </c:if>
	            <c:if test="${(not empty member) and ((board.writer eq member.member_name) or (member.s_idx eq 7))}">
			        <a href="S_Community_Freewrite.jsp">
			        <input type="button" value="글등록">
			    	</a>
	            </c:if>
	        </div>
            
        </div>
    </div>
${S_Footer}
</body>
<script>
    function showCommunity(communityNumber) {
        // 각 커뮤니티 버튼을 클릭할 때 해당 커뮤니티의 테이블을 보여주고, 다른 커뮤니티의 테이블은 감춥니다.
        if (communityNumber === 1) {
            document.getElementById('community1').style.display = 'block';
            document.getElementById('community2').style.display = 'none';
        } else if (communityNumber === 2) {
            document.getElementById('community1').style.display = 'none';
            document.getElementById('community2').style.display = 'block';
        }
    }
</script>
</html>