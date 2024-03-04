<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Moving Bar</title>
    <style>
        body {user-select: none;}
        img {position: absolute;}
        #dollmain {z-index: 3;width: 500px;}
        #dollmainsub {width: 500px; height: 700px; margin-top: -56px; z-index: -1;}
        #movableBar {margin-left: 175px;height: 10px;background-color: gray;cursor: pointer;position: absolute;z-index: 3;}
        #barbackgrond {margin-left: 40px;position: absolute;width: 420px;height: 348px;background-color: skyblue;opacity: 0.5;}
        #OverFix{
            width: 500px;
            height: 500px;
            position: absolute;
            margin-top: 20px;
            overflow: hidden;
        }
        #canvas {position: absolute;z-index: 3;}
        #goodimgsave {position: absolute;}
        .fade-out {animation: fadeOut 2s ease-in-out, moveUp 2s ease-in-out;opacity: 0;}
        .gameclearmove {animation: imgmove 3s ease-in-out;transform: translateY(180px);}
        #gamestartcanvas {pointer-events: auto;opacity: 0.2;width: 420px;height: 180px;background: linear-gradient(to bottom, gray 20%, black 20%, black 80%, gray 80%);position: absolute;}
        #gamestartground {display: flex;justify-content: center;align-items: center;height: 410px;width: 502px;position: absolute; z-index: 10;}

        @keyframes fadeOut {0% {opacity: 1;}100% {opacity: 0;}}
        @keyframes moveUp {0% {transform: translateY(0);}100% {transform: translateY(-80px);}}
        @keyframes imgmove {0% {transform: translateY(0);}100% {transform: translateY(180px);}}
        @keyframes rotateAnimation {from {transform: rotate(0deg);}to {transform: rotate(360deg);}}
        @keyframes colorChange {0%,50% {opacity: 1;}51%,100% {opacity: 0;}}
    </style>
</head>
<body style="overflow: hidden;">
    <div style="display: flex; justify-content: center; align-items: center; margin-right: 500px;">
        <div>
            <canvas id="canvas" width="500" height="500"></canvas>
            <img id="doll_9" src="../doll/인형9.png" width="90"><img id="doll_8" src="../doll/인형8.png" width="90"><img id="doll_7" src="../doll/인형7.png" width="90">
            <img id="doll_6" src="../doll/인형6.png" width="90"><img id="doll_5" src="../doll/인형5.png" width="90"><img id="doll_4" src="../doll/인형4.png" width="90">
            <img id="doll_3" src="../doll/인형3.png" width="90"><img id="doll_2" src="../doll/인형2.png" width="90"><img id="doll_1" src="../doll/인형1.png" width="90">
            <div id="goodimgsave"></div>
            <div id="OverFix">
                <div id="barbackgrond"></div>
                <img id="dollmainsub" src="../Drawing3/인형뽑기3_4.png" alt="">
            </div>
            <img id="dollmain" src="../Drawing3/인형뽑기3_1.png" alt="">
            <div id="movableBar"></div>
            <div id="gamestartground">
                <canvas id="gamestartcanvas"></canvas>
                <span style="font-size: 45px; font-family: cursive;">game start</span>
                <span style="animation: colorChange 1s infinite;">click</span>
            </div>
            <img id="getdollimg">
        </div>
    </div>
<script>
const movingdollimg = Array.from({length: 9}, (_, i) => document.getElementById(`doll_${i + 1}`)); // 인형 배열
const positions = [
{top: 260,left: 45},{top: 235,left: 390},{top: 210,left: 80},
{top: 170,left: 350},{top: 150,left: 115},{top: 120,left: 320},
{top: 85,left: 155},{top: 60,left: 285},{top: 25,left: 220}
]; // 인형 위치
movingdollimg.forEach((doll, i) => {doll.style.top = positions[i].top + "px";doll.style.marginLeft = positions[i].left-10 + "px";}); // 인형 위치
const gamestartground = document.getElementById('gamestartground');
const maindollimg = document.getElementById('gamestartcanvas');
const movableBar = document.getElementById("movableBar"); // 무빙바
const barbackgrond = document.getElementById("barbackgrond"); // 무빙바 캔버스 배경
const goodimgsave = document.getElementById("goodimgsave"); 
const getdollimg = document.getElementById("getdollimg"); 
let firstoffset = 12; // 무빙바 초기 우측 이동 횟수
let canvasX = 330; // 무빙바 캔버스 위치
let canvasY = 358; // 무빙바 캔버스 높이
let offsetX = 0; // 무빙바 위치
let baroverleft = 0; // 무빙바 왼쪽 위치 초과
let baroverright = 0; // 무빙바 오른쪽 위치 초과
let leftcanvoustransformrotation = 0; // 무빙바 캔버스 왼쪽 위치 저장
let rightcanvoustransformrotation = 0; // 무빙바 캔버스 오른쪽 위치 저장
let goodcount = 0; // 굳 이펙트 카운터
let baroffsetmplus = 0; // 무빙바 오버 이동거리 추가
let animationSpeed = 60; // 애니메이션 속도 (밀리초)
let dolllengthcount = 0; // 인형 하강 순서
let firstoffsetfin = false; // 무방바 초기 이동 정지
let gamestart = false; // 게임 시작
let gamefin = false; // 게임 끝
let animatemove = true; // 게임 준비2
let dolldown =false;
let goodimg = []; // 굳 이펙트 생성
let keys = {};
let count = true; // 무빙바 좌우이동 카운터
let barleftcanvoustransformrotationsave = true; // 무빙바 초기 캔버스 위치 저장
let spacestop =true;
let canvas = document.getElementById("canvas"); 
let gamerun = false;
let dollfincount =0;
let gameclearimg = document.createElement('img');gameclearimg.src = "../doll/gameclear.png";
    gameclearimg.style.width = "200px";gameclearimg.style.zIndex = 3;gameclearimg.style.top = "0px";
    gameclearimg.style.left = "148px";goodimgsave.appendChild(gameclearimg);
movableBar.style.width = "150px";
movableBar.style.transform = `translateX(${offsetX}px)`;
movableBar.style.top = "366px";
barbackgrond.style.top = "-350px";
gameLoop();
document.addEventListener("keyup", (event)=> {keys[event.key] = false; spacestop = true;}


)
    document.addEventListener("keydown", (event) => {keys[event.key] = true;});

//----------------게임 시작------------------

maindollimg.addEventListener('click', () => {
    movingdollimg.forEach((doll, i) => {
        doll.style.top = positions[i].top + "px";doll.style.marginLeft = positions[i].left-10 + "px";doll.style.zIndex = 0;}); // 인형 위치
    movableBar.style.zIndex = 1;
    getdollimg.style.visibility = 'hidden';
    gamestartground.style.visibility = 'hidden';
    barbackgrondmove();
});

function gameLoop() {

    movingcanvus();
    // 게임시작
    if (keys[' '] && gamestartground.style.visibility != 'hidden'&&spacestop) {
        movingdollimg.forEach((doll, i) => {
            doll.style.top = positions[i].top + "px";doll.style.marginLeft = positions[i].left-10 + "px";doll.style.zIndex = 0;}); // 인형 위치
        movableBar.style.zIndex = 1;
        spacestop =false;
        getdollimg.style.visibility = 'hidden';
        gamestartground.style.visibility = 'hidden';
        barbackgrondmove();// 게임준비
    } else if (keys[' '] && gamestart && animatemove) {
        step();animatemove = false;
    }// 게임시작

    requestAnimationFrame(gameLoop);
}

function barbackgrondmove() { // 게임 준비
    if (parseInt(barbackgrond.style.top) < 0) 
    {barbackgrond.style.top = (parseInt(barbackgrond.style.top) + 10) + "px";
    requestAnimationFrame(barbackgrondmove); // 캔버스 배경 이동
    } else {gamestart = true;
    }
}
        //----------------게임 시작------------------




// ---------------무빙바 켄버스---------------

function movingcanvus(){

    if (keys[' '] && gamestart && !gamefin&&spacestop) {
        spacestop = false;
        let context = canvas.getContext("2d");let transformString = movableBar.style.transform;let translateXValue = parseInt(transformString.slice(11, -3)); // 무빙바 로테이션
        if (barleftcanvoustransformrotationsave) {
            offsetX -= 10;movableBar.style.transform = `translateX(${offsetX}px)`;
            leftcanvoustransformrotation = parseInt(translateXValue);
            rightcanvoustransformrotation = parseInt(translateXValue) + 150;
            barleftcanvoustransformrotationsave = false;
        } // 무빙바 초기 위치 저장
        if (leftcanvoustransformrotation - parseInt(translateXValue) < 0) {
            baroverleft = (leftcanvoustransformrotation - parseInt(translateXValue)) * (-1);
            leftcanvoustransformrotation += baroverleft; // 무빙바 캔버스 왼쪽 위치 저장
            if (rightcanvoustransformrotation - leftcanvoustransformrotation > 0) {movableBar.style.width = parseInt(movableBar.style.width) - baroverleft + "px";} // 무빙바 너비 변경
            baroffsetmplus += baroverleft;
        } else if (leftcanvoustransformrotation - parseInt(translateXValue) > 0) {baroverright = ((parseInt(translateXValue) + parseInt(movableBar.style.width) -rightcanvoustransformrotation)) * (-1);rightcanvoustransformrotation -= baroverright; // 무빙바 캔버스 오른쪽 위치 저장
            if (rightcanvoustransformrotation - leftcanvoustransformrotation > 0) {movableBar.style.width = parseInt(movableBar.style.width) - baroverright + "px";baroffsetmplus += baroverright; // 무빙바 너비 변경
            offsetX += baroverright;movableBar.style.transform = `translateX(${offsetX}px)`; // 무빙바 오버 이동거리 추가
        }
    }
    if (rightcanvoustransformrotation - leftcanvoustransformrotation <= 0) {gamefin = true;gamecleardown();} // 게임 클리어
    if (!gamefin) {goodcount++;
        if ((goodcount) % 3 == 0 && goodcount!=0) {
            goodimg[goodcount / 3 - 1] = document.createElement('img');goodimg[goodcount / 3 - 1].src = "../doll/good.png";
            goodimg[goodcount / 3 - 1].style.width = '50px';goodimg[goodcount / 3 - 1].style.top = positions[goodcount / 3 - 1].top + 50 + "px";
            goodimg[goodcount / 3 - 1].style.left = positions[goodcount / 3 - 1].left + 8 + "px";goodimg[goodcount / 3 - 1].classList.add('fade-out');
            goodimg[goodcount / 3 - 1].style.zIndex = 2; goodimgsave.appendChild(goodimg[goodcount / 3 - 1]); // 굳 이펙트
            movingdollimg[goodcount / 3 - 1].style.zIndex = 1; // 인형 Z인덱스
            animationSpeed -= 10 - goodcount / 3; // 무빙바 이동속도
            }
            barbackgrond.style.top = (parseInt(barbackgrond.style.top) - 10) + "px";
            barbackgrond.style.height = (parseInt(barbackgrond.style.height) - 10) + "px"; // 배경 높이
            movableBar.style.top = parseInt(movableBar.style.top) - 10 + "px"; // 무빙바 높이
            canvasX = 175 + leftcanvoustransformrotation;context.fillStyle = "#808080";
            context.fillRect(canvasX, canvasY, parseInt(movableBar.style.width), 10);canvasY -= 10; // 캔버스 그리기

        }
        if (goodcount >= 27) {gamefin = true;gamecleardown();} // 게임 클리어
        
    }
    
}
// ---------------무빙바 켄버스---------------



// ---------------무빙바---------------
function sleep(ms) {return new Promise(resolve => setTimeout(resolve, ms));} // 타이머

async function step() {
if(!gamefin){
        let transformString = movableBar.style.transform;
        let translateXValue = parseInt(transformString.slice(11, -3)); // 무빙바 로테이션
        // 이동거리
        if (firstoffset > 0 - baroffsetmplus / 10 && !firstoffsetfin) {offsetX += 10;firstoffset--; // 초기 이동
        } else if (count) {firstoffsetfin = true;offsetX -= 10; // 우로 이동
        } else if (!count) {offsetX += 10; // 좌로 이동
        }
        // 이동거리 최댓값
        if (translateXValue > 90 + baroffsetmplus) {count = true; // 우로 이동
        } else if (translateXValue < -90) {count = false; // 좌로 이동
        }
        movableBar.style.transform = `translateX(${offsetX}px)`;await sleep(animationSpeed);step();
}
}
function gamecleardown() {canvas.style.zIndex=0;movableBar.style.zIndex=0;
gameclearimg.classList.add('gameclearmove'); // 게임 클리어 생성
    getdoll();
}
// ---------------무빙바---------------

// ---------------게임 종료---------------
async function getdoll() {await sleep(3000);findollspin();dolldown =true;findolldown();
    async function findollspin() {
        let dolllength = Math.floor(goodcount / 3);
        for (let i = 0; i < dolllength; i++) {
            await sleep(350);dolllengthcount++;imgreverse = (Math.ceil(Math.random() * 2));
            // 인형 회전
            if (imgreverse == 2) {rotationDirection = 'reverse';} else {rotationDirection = 'normal';} //회전방향  
            const speed = (Math.ceil(Math.random() * 4 + 1));
            movingdollimg[i].style.animation =`rotateAnimation ${speed}s linear infinite ${rotationDirection}`;
            movingdollimg[i].classList.add('rotating'); //회전속도
        }rotateAnimation
    }
}

function findolldown() {
    // 인형 하강
    if(dolldown){
    for (let n = 0+dollfincount; n < dolllengthcount; n++) {movingdollimg[n].style.top = parseInt(movingdollimg[n].style.top)+1 + "px";
    if(parseInt(movingdollimg[n].style.top)>500){
        movingdollimg[n].style.removeProperty('animation');
            movingdollimg[n].classList.remove('rotating');
        dollfincount++;
        getdollimg.style.visibility = 'visible';
        getdollimg.src = `../doll/인형${n+1}.png`;
        if(dolllengthcount >n+1){
            finrotate();
        }else{
            dolldown =false;
            fin();
        }
    }

}
    setTimeout(findolldown , 1);
}
} 
async function finrotate(){

    getdollimg.style.width = "95px";
    getdollimg.style.marginTop = "180px";
    getdollimg.style.marginLeft = "200px";
    getdollimg.style.transform = `rotate(20deg)`;
    await sleep(200);getdollimg.style.transform = `rotate(-20deg)`;
}
async function fin(){
    getdollimg.style.width = "95px";
    getdollimg.style.marginTop = "180px";
    getdollimg.style.marginLeft = "200px";
    getdollimg.style.transform = `rotate(20deg)`;
    await sleep(200);getdollimg.style.transform = `rotate(-20deg)`;
    await sleep(200);getdollimg.style.transform = `rotate(20deg)`;
    await sleep(200);getdollimg.style.transform = `rotate(-20deg)`;
    await sleep(200);getdollimg.style.transform = `rotate(20deg)`;
    await sleep(200);getdollimg.style.transform = `rotate(0deg)`;
    await sleep(200);gamestartground.style.visibility = 'visible';
    movableBar.style.width = "150px";

    offsetX = 0; 
    movableBar.style.transform = `translateX(${offsetX}px)`;
movableBar.style.top = "366px";
barbackgrond.style.top = "-350px";
gamestart=false;
gamefin =false;
goodcount =0;dollfincount = 0;
dolllengthcount =0;
firstoffset = 12;
firstoffsetfin = false;
dolldown = true;
leftcanvoustransformrotation = 0;
rightcanvoustransformrotation = 0;
canvasX = 330;
canvasY = 358;
barleftcanvoustransformrotationsave = true;
animatemove =true;
baroffsetmplus = 0;
animationSpeed = 60;
gameclearimg.classList.remove('gameclearmove');
    clearCanvas();
}
function clearCanvas() {
    let canvas = document.getElementById('canvas');
    let context = canvas.getContext('2d');
    context.clearRect(0, 0, canvas.width, canvas.height);
}
// ---------------게임 종료---------------
</script>
</body>

</html>