<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>cinema</title>
</head>
<style>
    body{user-select: none; /* 텍스트 드래그 불가능하게 설정 */
        background-color: gray;
    }    
    img {
        position: absolute;
    }
    #media{
        position: absolute;
    }
    #Cinemagrond {
        transform: translateX(96%);
    }

    #CinemawallLeft {
        width: 600px;
        margin-top: -100px;
    }
    #CinemawallCnter1{
        width: 600px;
        margin-left: 900px;
        margin-top: -120px;
    }
    #CinemawallCnter2{
        width: 600px;
        margin-left: 400px;
        margin-top: -120px;
    }
    #CinemawallCnter3{
        width: 600px;
        margin-left: -100px;
        margin-top: -120px;
    }
    #CinemawallRight {
        width: 600px;
        margin-left: 800px;
        margin-top: -100px;
    }
    #MoveReservation1{
        margin-left: 30px;
        margin-top: 335px;
    }
    #MoveReservation2{
        margin-left: 100px;
        margin-top: 335px;
    }
    #MoveReservation3{
        margin-left: 170px;
        margin-top: 335px;
    }
    #MoveReservation4{
        margin-left: 240px;
        margin-top: 335px;
    }
    #MoveReservation5{
        margin-left: 310px;
        margin-top: 335px;
    }
    #DollmachineImg1 {
        margin-left: 830px;
        margin-top: 330px;
    }

    #DollmachineImg2 {
        margin-left: 940px;
        margin-top: 330px;
    }

    #DollmachineImg3 {
        margin-left: 1050px;
        margin-top: 330px;
    }

    #DollmachineImg4 {
        margin-left: 1160px;
        margin-top: 330px;
    }

    #DollmachineImg5 {
        margin-left: 1270px;
        margin-top: 330px;
    }

    #CnemaBackside{
        position: absolute;
    }
    #CinemaFrontside{
        transition: opacity 0.5s;
        opacity: 1;
        position: absolute;
    }
    #CinemagrondLightingUp{
        opacity: 0.2;
        width: 2000px;
        height: 373px;
        position: absolute;
        background-color: black;
    }
    #CinemagrondLightingDwon{
        transition: opacity 0.5s;
        opacity: 0;
        width: 2000px;
        height: 373px;
        position: absolute;
        margin-top: 373px;
        background-color: black;
    }
    #ShadowLeft{
        position: absolute;
        opacity: 0.2;
        width: 600px;
        height: 80px;
        background-color: black;
        margin-top: 373px;
    }
    #ShadowRight{
        position: absolute;
        opacity: 0.2;
        width: 600px;
        height: 80px;
        background-color: black;
        margin-top: 373px;
        margin-left: 800px;
    }
    #cinemadoor1{
        width: 100px;
        margin-top: 120px;
        margin-left: 150px;
    }
    #cinemadoor2{
        width: 100px;
        margin-top: 120px;
        margin-left: 400px;
    }
    #cinemadoor3{
        width: 100px;
        margin-top: 120px;
        margin-left: 650px;
    }
    #cinemadoor4{
        width: 100px;
        margin-top: 120px;
        margin-left: 900px;
    }
    #cinemadoor5{
        width: 100px;
        margin-top: 120px;
        margin-left: 1150px;
    }
    #doornumone{
        width: 25px;
        margin-top: 120px;
        margin-left: 120px;
    }
    #doornumtwo{
        width: 25px;
        margin-top: 120px;
        margin-left: 370px;
    }
    #doornumtree{
        width: 25px;
        margin-top: 120px;
        margin-left: 620px;
    }
    #doornumfour{
        width: 25px;
        margin-top: 120px;
        margin-left: 870px;
    }
    #doornumfive{
        width: 25px;
        margin-top: 120px;
        margin-left: 1120px;
    }
    #LodingGround{
            opacity: 1;
            transition: opacity 1s;
            position: absolute;
            width: 1300px; height: 650px;
            background-color: black;
            z-index: 100;
        }
        #rightIframe{
            width: 0%;
            right: 0;
            position: absolute;
            z-index: 100;
            transition: width 1s;
            background-color: wheat;
        }
</style>

<body>
    <div style="display: flex; justify-content: center; align-items: center; overflow: hidden;">
        <div style="position: relative;width: 1300px; height: 650px; overflow: hidden;">
            <div id="media">
                <img src="../cinema/영화관배경1.png" draggable="false">
                <img id="Cinemagrond" src="../cinema/영화관배경1.png" draggable="false">
                <div id="CinemagrondLightingUp"></div>
                <div id="CinemagrondLightingDwon"></div>
                    <div id="CnemaBackside">
                    <img id="CinemawallCnter1" src="../cinema/영화관배경3.png" draggable="false">
                    <img id="CinemawallCnter2" src="../cinema/영화관배경3.png" draggable="false">
                    <img id="CinemawallCnter3" src="../cinema/영화관배경3.png" draggable="false">
                    <div id="ShadowLeft"></div>
                    <div id="ShadowRight"></div>
                    <img id="cinemadoor1" src="../cinema/상영관입구.png" draggable="false">
                    <img id="cinemadoor2" src="../cinema/상영관입구.png" draggable="false">
                    <img id="cinemadoor3" src="../cinema/상영관입구.png" draggable="false">
                    <img id="cinemadoor4" src="../cinema/상영관입구.png" draggable="false">
                    <img id="cinemadoor5" src="../cinema/상영관입구.png" draggable="false">
                    <img id="doornumone" src="../cinema/상영관1.png" draggable="false">
                    <img id="doornumtwo" src="../cinema/상영관2.png" draggable="false">
                    <img id="doornumtree" src="../cinema/상영관3.png" draggable="false">
                    <img id="doornumfour" src="../cinema/상영관4.png" draggable="false">
                    <img id="doornumfive" src="../cinema/상영관5.png" draggable="false">
                </div>
                <div id="CinemaFrontside">
                    <img id="CinemawallLeft" src="../cinema/영화관배경2.png" draggable="false">
                    <img id="CinemawallRight" src="../cinema/영화관배경2.png" draggable="false">
                    <img id="MoveReservation1" src="../cinema/예매.png" width="45" draggable="false">
                    <img id="MoveReservation2" src="../cinema/예매.png" width="45" draggable="false">
                    <img id="MoveReservation3" src="../cinema/예매.png" width="45" draggable="false">
                    <img id="MoveReservation4" src="../cinema/예매.png" width="45" draggable="false">
                    <img id="MoveReservation5" src="../cinema/예매.png" width="45" draggable="false">
                    <img id="DollmachineImg1" onclick="sendButtonClickMessage1()" src="../cinema/인형뽑기1.png" width="100" draggable="false" draggable="false">
                    <img id="DollmachineImg2" onclick="sendButtonClickMessage2()" src="../cinema/인형뽑기2.png" width="100" draggable="false" draggable="false">
                    <img id="DollmachineImg3" onclick="sendButtonClickMessage3()" src="../cinema/인형뽑기3.png" width="100" draggable="false" draggable="false">
                    <img id="DollmachineImg4" onclick="sendButtonClickMessage4()" src="../cinema/인형뽑기4.png" width="100" draggable="false" draggable="false">
                    <img id="DollmachineImg5" onclick="sendButtonClickMessage5()" src="../cinema/인형뽑기5.png" width="100" draggable="false" draggable="false">
                </div>
            </div>
            <img id="Player" src="character/characterdown1.png" width="45">
            <div id="LodingGround"></div>
            <iframe id="rightIframe" src="Drawing3.html" name="upper" height="650"></iframe>
        </div>
    </div>
</body>

<script>
    //--------------캐릭터 기본 이동 변수--------------
    let PlayerX = 0;
    let PlayerY = 490;
    let PlayerSpeed = 5;
    let Playermove = 1;
    let keys = {};
    let characterway = 4;
    let canvas;
    let context;
    let upway, downway, leftway, rightway = true;
    const Player = document.getElementById("Player");
    const LodingGround =document.getElementById('LodingGround');
    const rightIframe =document.getElementById('rightIframe');
    document.addEventListener('keydown', function (event) {keys[event.key] = true;});
    document.addEventListener('keyup', function (event) {keys[event.key] = false;});
    window.addEventListener('blur', function () {keys = {};});
    //--------------캐릭터 기본 이동 변수--------------


    //-----------------------------------------
    let movingmap = true;
    let BackCount = false;
    let mapX =0;
    const mapimg = document.getElementById("media");
    const CinemaFrontside = document.getElementById("CinemaFrontside");
    const CinemagrondLightingDwon = document.getElementById("CinemagrondLightingDwon");
    mapimg.style.marginLeft = mapX + "px";
    CinemaFrontside.style.opacity= 1;
    CinemagrondLightingDwon.style.opacity=0;
    setTimeout(Loding, 1000)
    //-----------------------------------------
    

    //------------인형뽑기------------
    function sendButtonClickMessage1() {
        BackCount = true;
        movingmap = false;
        LodingGround.style.zIndex = 100;
        rightIframe.focus();
        rightIframe.src = "/human/Showsite/main/Drawing1.jsp";
        rightIframe.style.width = '100%';
    }
    function sendButtonClickMessage2() {
        BackCount = true;
        movingmap = false;
        LodingGround.style.zIndex = 100;
        rightIframe.focus();
        rightIframe.src = "/human/Showsite/main/Drawing2.jsp";
        rightIframe.style.width = '100%';
    }
    function sendButtonClickMessage3() {
        BackCount = true;
        movingmap = false;
        LodingGround.style.zIndex = 100;
        rightIframe.focus();
        rightIframe.src = "/human/Showsite/main/Drawing3.jsp";
        rightIframe.style.width = '100%';
    }
    function sendButtonClickMessage4() {
        BackCount = true;
        movingmap = false;
        LodingGround.style.zIndex = 100;
        rightIframe.focus();
        rightIframe.src = "/human/Showsite/main/Drawing4.jsp";
        rightIframe.style.width = '100%';
    }
    function sendButtonClickMessage5() {
        BackCount = true;
        movingmap = false;
        LodingGround.style.zIndex = 100;
        rightIframe.focus();
        rightIframe.src = "/human/Showsite/main/Drawing5.jspl";
        rightIframe.style.width = '100%';
    }
    window.addEventListener('message', function (event) {
        var message = event.data;
        if (message.action === 'goBack') {
            rightIframe.style.width = '0%';
            LodingGround.style.zIndex = -100;
            movingmap =true;
            if(BackCount){
                BackCount=false;
                window.focus();
                runGame();
            }
        }
    });
    //------------인형뽑기------------


    //--------------로딩--------------
    function Loding(){
        LodingGround.style.opacity = 0;
        LodingGround.addEventListener('transitionend', function() {
            LodingGround.style.zIndex = -100;
        });
        window.focus();
        runGame();
    }
    //--------------로딩--------------


    //--------------게임루프--------------
    function runGame() {
        Charactermove();
        canvasdraw();
        if(movingmap){
    requestAnimationFrame(runGame);
    }
    }
    //--------------게임루프--------------


    //--------------이동루프--------------
    function canvasdraw() {
        Player.style.marginLeft = PlayerX + "px";
        Player.style.marginTop = PlayerY + "px";
        mapimg.style.marginLeft = mapX + "px";
    }
    //--------------이동루프--------------


    // ---------방향키 입력 처리---------
    function Charactermove() {
        if (keys['ArrowUp']) {
            PlayerY -= PlayerSpeed;
            characterway = 1;
            if (!keys['ArrowDown']) {
                downway = false;
                upway = true;
                if (Playermove > 39) {
                    Playermove = 1;
                }
                if (Playermove >= 1 || Playermove <= 39) {
                    Player.src = "character/characterup" + Math.floor((Playermove / 10) + 1) + ".png";
                }
            // ----상향키 맵이동 한계 지점----
            if(PlayerY<210){PlayerY+=PlayerSpeed;}//플레이어 상향키 최대치
            if(PlayerX>-100 && PlayerX<=587 &&PlayerY<430&&PlayerY>330){PlayerY+=PlayerSpeed;//플레이어 백화점 왼쪽 벽 위치 경계 지점
            }
            if(PlayerX>670&&PlayerY<430&&PlayerY>330){PlayerY+=PlayerSpeed;//플레이어 영화관 오른쪽 벽 위치 경계 지점
            }
            // ----상향키 맵이동 한계 지점----
            } else if (upway) {
                Player.src = "character/characterup1.png";
            } // 상반키 입력시 캐릭터 시점 설정
        }
        if (keys['ArrowDown']) {
            PlayerY += PlayerSpeed;
            characterway = 2;
            if (!keys['ArrowUp']) {
                upway = false;
                downway = true;
                if (Playermove > 39) {
                    Playermove = 1;
                }
                if (Playermove >= 1 || Playermove <= 39) {
                    Player.src = "character/characterdown" + Math.floor((Playermove / 10) + 1) + ".png";
                }
            // ----하향키 맵이동 한계 지점----
            if(PlayerY>600){PlayerY-=PlayerSpeed}//플레이어 하향측키 최대치
            if(PlayerY>330&&PlayerY<430&&(PlayerX<=587||PlayerX>670)){PlayerY-=PlayerSpeed}
            // ----하향키 맵이동 한계 지점----
            } else if (downway) {
                Player.src = "character/characterdown1.png";
            } // 상반키 입력시 캐릭터 시점 설정
        }
        if (keys['ArrowLeft']) {
            PlayerX -= PlayerSpeed;
            characterway = 3;
            if (!keys['ArrowRight']) {
                leftway = true;
                rightway = false;
                if (Playermove > 39) {
                    Playermove = 1;
                }
                if (Playermove >= 1 || Playermove <= 39) {
                    Player.src = "character/characterleft" + Math.floor((Playermove / 10) + 1) + ".png";
                }
            // ----좌측키 맵이동 한계 지점----
            if(PlayerX<=650 &&mapX <0){PlayerX+=PlayerSpeed;mapX+=PlayerSpeed;}//플레이어 위치 중앙 지점
            if(PlayerX<-10){PlayerX+=PlayerSpeed}//맵 위치 왼쪽 끝 지점
            if(PlayerX<=587 &&PlayerY<430&&PlayerY>330){PlayerX+=PlayerSpeed;}//플레이어 영화관 왼쪽 벽 위치 경계 지점
            // ----좌측키 맵이동 한계 지점----
            } else if (leftway) {
                Player.src = "character/characterleft1.png";
            } // 상반키 입력시 캐릭터 시점 설정
        }
        if (keys['ArrowRight']) {
            PlayerX += PlayerSpeed;
            characterway = 4;
            if (!keys['ArrowLeft']) {
                rightway = true;
                leftway = false;
                if (Playermove > 39) {
                    Playermove = 1;
                }
                if (Playermove >= 1 || Playermove <= 39) {
                    Player.src = "character/characterright" + Math.floor((Playermove / 10) + 1) + ".png";
                }
            // ----우측키 맵이동 한계 지점----
            if(PlayerX>650 && mapX >-100){PlayerX-=PlayerSpeed;mapX-=PlayerSpeed;//플레이어 위치 중앙 지점
            }
            if(PlayerX>1250){PlayerX-=PlayerSpeed}//맵 위치 오른쪽 끝 지점
            if(PlayerX>670 &&PlayerY<430&&PlayerY>330){PlayerX-=PlayerSpeed;}//플레이어 백화점 오른쪽 벽 위치 경계 지점
            // ----우측키 맵이동 한계 지점----
            } else if (rightway) {
                Player.src = "character/characterright1.png";
            } // 상반키 입력시 캐릭터 시점 설정
        }
        if (keys['ArrowUp'] || keys['ArrowDown'] || keys['ArrowLeft'] || keys['ArrowRight']) {
            Playermove++;
        } else {
            Player.src = "character/characterway" + characterway + ".png";
        }

        if(PlayerY<340){
            CinemaFrontside.style.zIndex =1;
            CinemaFrontside.style.opacity = 0.1;
            CinemagrondLightingDwon.style.opacity = 0.2;
        }else{
            CinemaFrontside.style.zIndex =0;
            CinemaFrontside.style.opacity = 1;
            CinemagrondLightingDwon.style.opacity = 0;
        }
    }

    // ---------방향키 입력 처리---------






</script>

</html>