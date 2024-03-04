<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>game</title>
    <style>
        body {user-select: none;pointer-events: none;}
        #tongsmove {position: absolute;transition: margin-top 3s;}
        #grabButton {object-fit: cover;user-select: none;border: none;margin-top: 460px;margin-left: 138px;z-index: 1;width: 35px;pointer-events: auto;}
        #joystick {pointer-events: auto;margin-top: 442px;margin-left: 60px;position: absolute;width: 50px;height: 100px;}
        img {position: absolute;}
        #maindollimg {width: 500px;}
        #stick {width: 20px;z-index: 1;}
        #coin {visibility: hidden;}
        #gamestartcanvas {pointer-events: auto;opacity: 0.2;width: 420px;height: 180px;background: linear-gradient(to bottom, gray 20%, black 20%, black 80%, gray 80%);position: absolute;}
        #dollgetground,#gamestartground {display: flex;justify-content: center;align-items: center;height: 410px;width: 502px;position: absolute;}
        #getdoll {visibility: hidden;}
        @keyframes colorChange {0%,50% {opacity: 1;}51%,100% {opacity: 0;}}
    </style>
</head>

<body style="overflow: hidden;">
    <div style="display: flex; justify-content: center; align-items: center; margin-right: 500px;">
        <div>
            <div id="tongsmove">
                <img id="tongs" src="../Drawing1/인형뽑기1_2.png">
                <img id="doll" src="../Drawing1/인형뽑기1_2.png">
            </div>
            <img src="../Drawing1/인형뽑기1_1.png" width="500">
            <img id="maindollimg" src="../Drawing1/인형뽑기1_0.png">
            <img id="coin" src="../doll/동전.gif" width="500">
            <img id="grabButton" src="../Drawing1/인형뽑기1_5.png" draggable="false">
            <img src="../doll/백원2.gif" style="width: 40px; margin-top: 450px; margin-left: 280px;">
            <div id="joystick">
                <img id="stick" src="../Drawing1/인형뽑기1_4.png" draggable="false">
            </div>
            <div id="dollgetground">
                <img id="getdoll" src="../doll/인형1.png" alt="">
            </div>
            <div id="gamestartground">
                <canvas id="gamestartcanvas"></canvas>
                <span style="font-size: 45px; font-family: cursive;">game start</span>
                <span style="animation: colorChange 1s infinite;">click</span>
            </div>
        </div>
    </div>


    <script>
        const gamestartground = document.getElementById('gamestartground');
        const maindollimg = document.getElementById('gamestartcanvas');
        const tongsmove = document.getElementById('tongsmove');
        const doll = document.getElementById('doll');
        const grabButton = document.getElementById('grabButton');
        const getdoll = document.getElementById('getdoll');
        const playerSpeed = 3;
        const maxDollLeft = 50; // 최대 이동 거리 왼쪽
        const maxDollRight = 410; // 최대 이동 거리 오른쪽
        const keys = {};
        let isMovingLeft = false;
        let isMovingRight = false;
        let gamerun = false;
        let rightway = true;
        let leftway = true;
        let spacestop = true;
        tongsmove.style.marginTop = '60px';
        tongsmove.style.marginLeft = '205px';
        document.addEventListener('keydown', function (event) {keys[event.key] = true;});
        document.addEventListener('keyup', function (event) {
            keys[event.key] = false;spacestop = true; isMovingLeft = false;isMovingRight = false;});
        gameLoop();


        //----------------게임 시작------------------
        maindollimg.addEventListener('click', () => {
            gamestart();
        });
        function gameLoop() {
            keycode();
            if (isMovingLeft && gamerun) {moveDoll(-playerSpeed, -50);
            } else if (isMovingRight && gamerun) {moveDoll(playerSpeed, -50);}
            if(gamestartground.style.visibility != 'hidden'&&spacestop&&keys[' ']){
                spacestop =false;
                gamestart();
            }
            requestAnimationFrame(gameLoop);
        }
        function gamestart(){
            gamestartground.style.visibility = 'hidden';
            getdoll.style.visibility = 'hidden';
            gamerun = true;
        }
        
        //----------------게임 시작------------------


        //----------------방향키------------------

        function keycode(){
        // 방향키 누름 이벤트 처리
            if (keys['ArrowLeft']&&leftway){isMovingLeft = true;isMovingRight = false;rightway = false;}leftway =true;
            if (keys['ArrowRight']&&rightway) {isMovingLeft = false;isMovingRight = true;leftway =false;}rightway =true;
            if (keys[' ']&&spacestop&&gamerun){
                spacestop =false;
                tongsdown();
            }
        }
        // "tongsmove"을 주어진 x와 y 만큼 이동
        function moveDoll(dx, dy) {
            const currentLeft = parseFloat(tongsmove.style.marginLeft);
            // 최대 이동 거리를 넘지 않도록 제한
            if (currentLeft + dx < maxDollLeft) {
                tongsmove.style.marginLeft = maxDollLeft + 'px';
            } else if (currentLeft + dx > maxDollRight) {
                tongsmove.style.marginLeft = maxDollRight + 'px';
            } else {
                tongsmove.style.marginLeft = currentLeft + dx + 'px';
            }
        }
        //----------------방향키------------------


        //----------------조이스틱------------------
        const joystick = document.getElementById('joystick');
        const stick = document.getElementById('stick');
        const stickSize = 10;
        let isDragging = false;
        let stickCentered = true;
        let stickX = (joystick.clientWidth - stickSize) / 2;
        stick.style.marginLeft = stickX + 'px';
        joystick.addEventListener('mousedown', (e) => {
            isDragging = true;
            document.addEventListener('mousemove', moveStick);
            document.addEventListener('mouseup', releaseStick);
        });
        function moveStick(e) {
            if (!isDragging) {return;}
            const newX = e.clientX - joystick.getBoundingClientRect().left - stickSize / 2;// 스틱을 드래그 중인 동안 스틱 위치 업데이트
            if (newX < 0) {stickX = 0;// 조이스틱 최대 거리
            } else if (newX > joystick.clientWidth - stickSize) {stickX = joystick.clientWidth - stickSize;
            } else {stickX = newX;
            }
            stick.style.marginLeft = stickX + 'px';// 스틱 위치 업데이트
            const joystickCenterX = joystick.clientWidth / 2; // 좌우 방향을 판단하여 처리
            if (stickX < joystickCenterX) {isMovingLeft = true;isMovingRight = false;
            } else if (stickX > joystickCenterX) {isMovingLeft = false;isMovingRight = true;
            } else {isMovingLeft = false;isMovingRight = false;stickCentered = true;}
        }
        function releaseStick() {
            isDragging = false;
            stickX = (joystick.clientWidth - stickSize) / 2;// 스틱 드래그 종료 시 스틱 위치 초기화
            stick.style.marginLeft = stickX + 'px';
            if (stickCentered) {isMovingLeft = false;isMovingRight = false;}
        }
        //----------------조이스틱------------------


        //----------------집게 버튼------------------
        grabButton.addEventListener('mousedown', () => {
            grabButton.src = "../Drawing1/인형뽑기1_6.png";
            addEventListener('mouseup', () => {grabButton.src = "../Drawing1/인형뽑기1_5.png";});
            grabButton.addEventListener('mouseup', () => {
                tongsdown();
            });
        });        
        function tongsdown(){
            if (gamerun) {
                    gamerun = false;
                    tongsmove.style.marginTop = '300px';
                    setTimeout(() => {
                        tongsmove.style.marginTop = '60px';
                        const tongs = document.getElementById('tongs');
                        let dollnum = Math.ceil(Math.random() * 109);
                        switch (true) {
                            case dollnum < 1:dollnum = 9;break;
                            case dollnum < 4:dollnum = 8;break;
                            case dollnum < 10:dollnum = 7;break;
                            case dollnum < 19:dollnum = 6;break;
                            case dollnum < 31:dollnum = 5;break;
                            case dollnum < 46:dollnum = 4;break;
                            case dollnum < 64:dollnum = 3;break;
                            case dollnum < 85:dollnum = 2;break;
                            case dollnum < 110:dollnum = 1;break;
                        }
                        tongs.src = "../Drawing1/인형뽑기1_3.png";
                        doll.src = `../doll/인형${dollnum}.png`;
                        doll.style.marginTop = "80px";
                        doll.style.width = "95px";
                        tongsmove.addEventListener('transitionend', function (event) {
                            if (event.propertyName === 'margin-top' && parseInt(
                                    tongsmove.style.marginTop) < 300) {
                                getdoll.src = `../doll/인형${dollnum}.png`;
                                getdoll.style.visibility = 'visible';
                                doll.style.marginTop = "0px";
                                doll.style.width = "0px";
                                doll.src = "../Drawing1/인형뽑기1_2.png";
                                tongs.src = "../Drawing1/인형뽑기1_2.png";
                                drawingfin();
                            }
                        });
                    }, 3500); // 일정 시간 후에 집게를 다시 올림
                }
        } 
        //----------------집게 버튼------------------


        //----------------게임 종료------------------
        function sleep(ms) {return new Promise(resolve => setTimeout(resolve, ms));}
        async function drawingfin() {
            await sleep(200);getdoll.style.transform = `rotate(20deg)`;
            await sleep(200);getdoll.style.transform = `rotate(-20deg)`;
            await sleep(200);getdoll.style.transform = `rotate(20deg)`;
            await sleep(200);getdoll.style.transform = `rotate(-20deg)`;
            await sleep(200);getdoll.style.transform = `rotate(0deg)`;
            await sleep(200);gamestartground.style.visibility = 'visible';
        }
        //----------------게임 종료------------------




    </script>
</body>

</html>