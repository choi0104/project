<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사이트 리스트</title>
    <style>
        body {

            user-select: none;
            /* 텍스트 드래그 불가능하게 설정 */
        }
        #line {
            height: 30px;
            display: flex;
        }
        #rightIframe {
            right: 0;
            width: 0%;
            height: 690px;
            position: absolute;
            z-index: 1;
            transition: width 1s;
            /* 부드러운 전환을 위한 CSS 속성 추가 */

        }

        #rightIframe2 {
            right: 0;
            width: 0%;
            height: 670px;
            position: absolute;
            z-index: 0;
            transition: width 1s;
            /* 부드러운 전환을 위한 CSS 속성 추가 */
        }
        #rightIframe3 {
            right: 0;
            width: 100%;
            height: 670px;
            overflow: hidden;
            position: absolute;
            z-index: 0;
        }

        #line button {
            right: 0;
        }
    </style>
</head>

<body>
    <div >
    <div id="sdf">
    <div id="line">
        <button><a href="https://www.zdnet.co.kr" target="upper">2DNet코리아</a></button>
        <button><a href="https://www.etnews.com" target="upper">전자신문</a></button>
        <button><a href="https://www.danawa.com" target="upper">다나와</a></button>
        <button><a href="https://www.coupang.com" target="upper">쿠팡</a></button>
        <button><a href="Drawing1.html" target="upper">인형뽑기1</a></button>
        <button><a href="Drawing2.html" target="upper">인형뽑기2</a></button>
        <button><a href="Drawing3.html" target="upper">인형뽑기3</a></button>
        <button><a href="Drawing4.html" target="upper">인형뽑기4</a></button>
        <button><a href="Drawing5.html" target="upper">인형뽑기5</a></button>
        <button onclick="toggleVisibility3()">뒤로가기</button>
        <button onclick="toggleVisibility4()">사이트</button>
        <button onclick="toggleVisibility()">창화면</button>
        <button onclick="toggleVisibility2()">전체화면</button>
        <button onclick="toggleVisibility5()">화면닫기</button>
        <button onclick="toggleVisibility6()">지도</button>

    </div>
    <div id="asdf">
        <iframe id="rightIframe3" src="/human/Showsite/main/S_MainCity.jsp" name="right" width="1200"></iframe>
        <iframe id="rightIframe" src="Drawing1.html" name="upper" width="700" height="580"></iframe>
        <iframe id="rightIframe2" src="koreamap.html" name="right" width="1200" height="580"></iframe>
    </div>
    </div>
</div>
</body>
<script>
    const resizeButton = document.getElementById('resizeButton');
    const myIframe = document.getElementById('rightIframe');
    const myIframe2 = document.getElementById('rightIframe2');
    const myIframe3 = document.getElementById('rightIframe3');
    var rightIframe = document.getElementById("rightIframe");
    myIframe.style.width = '0%';
    myIframe2.style.width = '0%';
    window.addEventListener('message', function (event) {
            // event.data에는 전달된 데이터가 들어있습니다.
            var message = event.data;

            // 원하는 작업 수행
            if (message.action === 'openLink') {
                // 부모 프레임에서 해당 링크를 열기
                window.open(message.link, 'upper');
                myIframe.style.width = '100%';
                myIframe.focus();
            }
        });
    function toggleVisibility() {
        // 현재 상태 확인 후 반대로 변경
        myIframe2.style.width = '0%';

        if (myIframe.style.width === '50%') {
            myIframe.style.width = '0%';
        } else {
            myIframe.style.width = '50%';
        }
    }

    function toggleVisibility2() {
        // 현재 상태 확인 후 반대로 변경
        myIframe2.style.width = '0%';

        if (myIframe.style.width === '100%') {
            myIframe.style.width = '0%';
        } else {
            myIframe.style.width = '100%';
        }
    }

    function toggleVisibility3() {
        myIframe.style.width = '0%';
        myIframe2.style.width = '0%';
        myIframe3.contentWindow.postMessage({ action: 'goBack' }, '*');
        myIframe3.focus();
    }

    function toggleVisibility5() {
        myIframe.style.width = '0%';
        myIframe2.style.width = '0%';

    }

    function toggleVisibility6() {
        myIframe.style.width = '0%';
        if (myIframe2.style.width === '100%') {
            myIframe2.style.width = '0%';
        } else {
            myIframe2.style.width = '100%';
        }
    }
</script>

</html>

