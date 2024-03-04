<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>../Drawing4</title>
    <style>

@keyframes rotateFirst {to {transform: translate3d(var(--translate-x, 0), var(--translate-y, 0), 0) rotate(45deg);}}
    @keyframes rotateSecond {to {transform: translate3d(var(--translate-x, 0), var(--translate-y, 0), 0) rotate(-90deg);}}
    @keyframes colorChange {0%,50% {opacity: 1;}51%,100% {opacity: 0;}}
                body {
            user-select: none;
        }
        img{
            pointer-events: none; /* 이미지 위의 이벤트 비활성화 */
            position: absolute;
        }
        #hammer {
            position: absolute;
            width: 40px;
            height: 100px;
            cursor: pointer;
            transform: translate3d();
        }
        #buttonbox{
            width: 100px;
            height: 50px;
            /* background-color: blueviolet; */
            position: absolute;
            transform: translate3d(200px,400px, 0);
        }
        #rotatingImage{
            margin-left: 237px;
            margin-top:  150px;
        }
        #rotationCount{
            position: absolute;
            margin-left: 200px;
            margin-top: 260px;
        }
        #getdoll{
            margin-top: 170px;
            margin-left: 200px;
            visibility: hidden;
        }
        #gamestartcanvas {pointer-events: auto;opacity: 0.2;width: 420px;height: 180px;background: linear-gradient(to bottom, gray 20%, black 20%, black 80%, gray 80%);position: absolute;}
        #gamestartground {display: flex;justify-content: center;align-items: center;height: 410px;width: 502px;position: absolute; z-index: 2;}

    </style>
</head>

<body>
    <div style="display: flex; justify-content: center; align-items: center; margin-right: 500px;">
        <div>
            <img id="dollmain" src="../Drawing4/인형뽑기4_1.png" width="500">
            <img src="../Drawing4/인형뽑기4_5.png"  width="500">
            <img id="doll_1" src="../doll/인형1.png" width="90"><img id="doll_2" src="../doll/인형2.png" width="90"><img id="doll_3" src="../doll/인형3.png" width="90">
            <img id="doll_4" src="../doll/인형4.png" width="90"><img id="doll_5" src="../doll/인형5.png" width="90"><img id="doll_6" src="../doll/인형6.png" width="90">
            <img id="doll_7" src="../doll/인형7.png" width="90"><img id="doll_8" src="../doll/인형8.png" width="90"><img id="doll_9" src="../doll/인형9.png" width="90">
            <div id="buttonbox"></div>
            <img id="buttoncleckimg" src="../Drawing4/버튼클릭.gif" width="200">
            <div id="hammer"><img src="../Drawing4/인형뽑기4_2.png" ></div>
            <img id="rotatingImage" src="../Drawing4/인형뽑기4_3.png" width="35" height="130">
            <div id="rotationCount">회전 횟수: 0</div>
            <div id="gamestartground">
                <canvas id="gamestartcanvas"></canvas>
                <span style="font-size: 45px; font-family: cursive;">game start</span>
                <span style="animation: colorChange 1s infinite;">click</span>
            </div>
            <img id="getdoll" src="../doll/인형1.png" alt="">
        </div>
    </div>
</body>
<script>
const movingdollimg = Array.from({length: 9}, (_, i) => document.getElementById(`doll_${i + 1}`)); // 인형 배열
const positions = [
      { top: 45, left: 70 },{ top: 145, left: 70 },{ top: 258, left: 70 },
      { top: 45, left: 210 },{ top: 145, left: 210 },{ top: 258, left: 210 },
      { top: 45, left: 350 },{ top: 145, left: 350 },{ top: 258, left: 350 },
    ];
    movingdollimg.forEach((doll, i) => {doll.style.top = positions[i].top+10 + "px";doll.style.marginLeft = positions[i].left + "px";}); // 인형 위치
    const maindollimg = document.getElementById('gamestartcanvas');
    const gamestartground = document.getElementById('gamestartground');
    const hammer = document.querySelector("#hammer");
    const buttoncleckimg = document.getElementById("buttoncleckimg");
    const getdoll = document.getElementById('getdoll');

    const startMousePosition = {x: 0,y: 0}; 
    const offset = {x: 80,y: 430};
    let currentRotation = 0;
    let imagetrue = true;
    let keys = {};
    let gamerun = false;
    let spacestop = true;
    let hammerattack =true;
    const rotatingImage = document.getElementById("rotatingImage");
    rotatingImage.src = "../Drawing4/인형뽑기4_3.png"; 
    buttoncleckimg.style.marginTop = "233px"
    buttoncleckimg.style.marginLeft = "0px"
    let rotationCount = 0;
    let totalRotation = 0;
    const rotationCountText = document.getElementById('rotationCount');
    let rotationInterval;
    let rotationIntervalcount;
    let rotationIntervalfin;
    let rotationIntervalcountplus = 0;
    let dollnum = 1;
    let fin =true;


    rotatingImage.style.transform = `rotate(${totalRotation}deg) translateY(-42%)`;
    hammer.style.transform = "translate3d("+offset.x+"px, "+offset.y+"px, 0)";
    function sleep(ms) {return new Promise(resolve => setTimeout(resolve, ms));}

    document.addEventListener('keydown', function (event) {keys[event.key] = true;});
        document.addEventListener('keyup', function (event) {spacestop =true;keys[event.key] = false;});
            gameLoop();
        //----------------게임 시작------------------
        maindollimg.addEventListener('click', () => {
            
            gamestart();
            gamerun = true;
        });
        function gameLoop() {
            if(gamestartground.style.visibility != 'hidden'&&spacestop&&keys[' ']){
                spacestop =false;
                gamerun =true;
                gamestart();
            }
            if(gamerun){
                start();
            }

            requestAnimationFrame(gameLoop);
        }
        function gamestart(){

            rotationCount = 0;
            totalRotation = 0;
            rotationInterval= 52;
            rotationIntervalcountplus = 0;
            fin =true;
            rotationCountText.textContent = `회전 횟수: ${rotationCount}`;
            movingdollimg[dollnum-1].style.visibility='visible';
            dollnum = 0;
            gamestartground.style.visibility = 'hidden';
            getdoll.style.visibility = 'hidden';
            hammerattack=true;
            
        }
        
        //----------------게임 시작------------------



    function start(){
    const move = function (e) {
        if(hammerattack){
        offset.x = e.clientX - startMousePosition.x;
        offset.y = e.clientY - startMousePosition.y;
        if(offset.x>507){offset.x =507;}
        if(offset.x<0){offset.x =0;}
        if(offset.y>600){offset.y =600;}
        if(offset.y<0){offset.y =0;}
        hammer.style.transform = "translate3d("+offset.x+"px, "+offset.y+"px, 0)";
        }
    }
    hammer.addEventListener("mousedown", function(e){
        if(hammerattack){
        buttoncleckimg.style.marginTop = "280px"
        buttoncleckimg.style.marginLeft = "145px"
        startMousePosition.x = e.clientX - offset.x;
        startMousePosition.y = e.clientY - offset.y;
        document.addEventListener("mousemove", move);
        }
    });
    addEventListener("mouseup", function(){
        if(hammerattack){
        buttoncleckimg.style.marginTop = "233px"
        buttoncleckimg.style.marginLeft = "0px"
        if(offset.x>200&&offset.x<300&&offset.y>400&&offset.y<600&&hammerattack){
            hammer.style.setProperty('--translate-x', offset.x+'px');
            hammer.style.setProperty('--translate-y', offset.y +'px');
            hammer.style.animation = "rotateFirst 0.8s forwards, rotateSecond 0.5s forwards 1s";
            buttoncleckimg.style.visibility = 'hidden';
            hammerattack=false;
            setTimeout(function () {
            createImage();
            toggleRotation();
            rotationIntervalcount = Math.ceil(Math.random()*7)+1;
            rotationIntervalfin= Math.ceil(Math.random()*10)*2;
            }, 1200);
        }else{
        offset.x = 80;
        offset.y = 430;
        hammer.style.transform = "translate3d("+offset.x+"px, "+offset.y+"px, 0)";
        }
    }
    document.removeEventListener("mousemove", move);
    });
    function createImage() {
        rotatingImage.src = "../Drawing4/인형뽑기4_4.png"; 
    }
    }


    function toggleRotation() {
        rotateImage();
        if(fin){
      requestAnimationFrame(toggleRotation);
        }
    }
    
    function rotateImage() {

      totalRotation += rotationInterval;
      rotatingImage.style.transform = `rotate(${totalRotation}deg) translateY(-42%)`;
      if(totalRotation >=360){
        totalRotation=totalRotation-360;
        rotationCount++;
        if(rotationInterval>=3){
          rotationInterval-=1;
          if(rotationIntervalcountplus>1&&rotationInterval<3){
            rotationInterval-=2;
          }
        }
      }
        if(rotationIntervalcount>0){
          rotationIntervalcount--;
          rotationInterval-=1;
          rotationIntervalcountplus++;
        }

      if(rotationInterval<3 &&rotationInterval>0.4&&totalRotation>78+rotationIntervalfin&&rotationIntervalcountplus==1){
        rotationInterval-=0.01;
        }else if(rotationInterval<2 &&rotationInterval>0&&rotationIntervalcountplus==1){
          rotationInterval-=0.001;
        }
        if(rotationCount==50){

            rotationInterval = 0;
        }
        rotationCountText.textContent = `회전 횟수: ${rotationCount}`;
        if(rotationInterval<=0&&fin){
            fin =false;
        dollnum = rotationCount-41;
        drawingfin()
        }
    }


        //----------------게임 종료------------------
        async function drawingfin() {
            movingdollimg[dollnum-1].style.visibility='hidden';
            getdoll.src = `../doll/인형${dollnum}.png`;
            getdoll.style.visibility = 'visible';
            await sleep(200);getdoll.style.transform = `rotate(20deg)`;
            await sleep(200);getdoll.style.transform = `rotate(-20deg)`;
            await sleep(200);getdoll.style.transform = `rotate(20deg)`;
            await sleep(200);getdoll.style.transform = `rotate(-20deg)`;
            await sleep(200);getdoll.style.transform = `rotate(0deg)`;
            await sleep(200);gamestartground.style.visibility = 'visible';
            offset.x = 80;
            offset.y = 430;
            hammer.style.animation = 'none';
            hammer.style.transform = "translate3d("+offset.x+"px, "+offset.y+"px, 0)";
            rotatingImage.src = "../Drawing4/인형뽑기4_3.png"; 
            buttoncleckimg.style.visibility = 'visible';
        }
        //----------------게임 종료------------------



</script>
</html>