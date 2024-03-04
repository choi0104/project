<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주사위</title>
    <style>
        body{
            user-select: none;
            pointer-events: none;
        }
        img{
            position: absolute;
        }
        #rollButton{
            width: 34px;
            height: 23px;
            pointer-events: auto;
            z-index: 2;
            position: absolute;
            opacity: 0;
            margin-top: 506px;
            margin-left: 153px;
        }
        #startButton{
            width: 34px;
            height: 23px;
            pointer-events: auto;
            z-index: 2;
            position: absolute;
            opacity: 0;
            margin-top: 506px;
            margin-left: 83px;
        }
        .dice {
            width: 50px;
            height: 50px;
            background-color: white;
            border: 1px solid black;
            font-size: 24px;
        }
        #canvas{
            position: absolute;
            width: 370px;
            height: 50px;
            margin-left: 110px;
            margin-top: 388px;

        }
        #grass{
            margin-left: 100px;
            margin-top: 352px;
            border: 1px solid black; 
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
            border-bottom-right-radius: 10px;
            border-bottom-left-radius: 10px;
        }
        #movingbot{
            z-index: 1;
        }
        #diceCount{
            margin-top: 450px;
            margin-left: 40px;
            position: absolute;
            font-size: 20px;
        }
        #goodimg{
            opacity: 0;
            width: 35px;
            margin-left: -5px;
        }
        #bonus{
            opacity: 0;
            position: absolute;
            margin-top: 390px;
        }
        #bonus2{
            opacity: 0;
            position: absolute;
            margin-top: 390px;
        }
        .fade-out {animation: fadeOut 2s ease-in-out, moveUp 2s ease-in-out;opacity: 0;}
        @keyframes fadeOut {0% {opacity: 1;}100% {opacity: 0;}}
        @keyframes moveUp {0% {transform: translateY(0);}100% {transform: translateY(-80px);}}
        #gamestartcanvas {pointer-events: auto;opacity: 0.2;width: 420px;height: 180px;background: linear-gradient(to bottom, gray 20%, black 20%, black 80%, gray 80%);position: absolute;z-index: 10;}
        #dollgetground,#gamestartground {display: flex;justify-content: center;align-items: center;height: 410px;width: 502px;position: absolute;}
        #getdoll {visibility: hidden;}
        @keyframes colorChange {0%,50% {opacity: 1;}51%,100% {opacity: 0;}}

    </style>
</head>
<body>
    <div style="display: flex; justify-content: center; align-items: center; margin-right: 500px;">
        <div id="image-container">
<img src="../Drawing5/인형뽑기5_1.png" width="500">
<img id="doll_1" src="../doll/인형1.png" width="90"><img id="doll_2" src="../doll/인형2.png" width="90"><img id="doll_3" src="../doll/인형3.png" width="90">
<img id="doll_4" src="../doll/인형4.png" width="90"><img id="doll_5" src="../doll/인형5.png" width="90"><img id="doll_6" src="../doll/인형6.png" width="90">
<img id="doll_7" src="../doll/인형7.png" width="90"><img id="doll_8" src="../doll/인형8.png" width="90"><img id="doll_9" src="../doll/인형9.png" width="90">
<img id="dice" src="../Drawing5/주사위1.png" width="500">
<img id="grass" src="../Drawing5/인형뽑기5_5.png" width="350" height="44">
<img id="redbutton" src="../Drawing5/인형뽑기5_2.png"  width="500">
<img id="bluebutton" src="../Drawing5/인형뽑기5_3.png"  width="500">
<img id="movingbot" src="../Drawing5/인형뽑기5_4.gif"  width="25">
<button onclick="rollDice()" id="rollButton"></button>
<button onclick="gamestart()" id="startButton"></button>
<div id="diceCount">횟수: 10</div>
<img id="bonus" src="../Drawing5/보너스.png" alt="">
<img id="bonus2" src="../Drawing5/보너스.png" alt="">
<div id="dollgetground">
    <img id="getdoll" src="../doll/인형1.png" alt="">
</div>
<div id="gamestartground">
    <canvas id="gamestartcanvas"></canvas>
    <span style="font-size: 45px; font-family: cursive;">game start</span>
    <span style="animation: colorChange 1s infinite;">click</span>
    <img id="goodimg" src="../doll/good.png">
</div>

</div>
</div>
<script>

    const gitimg = []; 
    let movingbotX = 105;
    let randomNumber = 0;
    let goodcount = 0;
    let dicerun = 2;
    let getdollcount = 0;
    let spacestop = true;
    let botrun = true;

    let keys = {};
    const movingbot = document.getElementById("movingbot");
    const diceCount = document.getElementById("diceCount");
        const gamestartground = document.getElementById('gamestartground');
        const maindollimg = document.getElementById('gamestartcanvas');
        const getdoll = document.getElementById('getdoll');
        const diceElement = document.getElementById('dice');
        const rollButton = document.getElementById('rollButton');
        const bluebutton = document.getElementById('bluebutton');
        const redbutton = document.getElementById('redbutton');
        const StartButton = document.getElementById('Startbutton');
        const bonus = document.getElementById('bonus');
        const bonus2 = document.getElementById('bonus2');
    movingbot.style.marginTop = "364px";
    movingbot.style.marginLeft = movingbotX + "px";
const container = document.getElementById("image-container");
const goodimg = document.getElementById('goodimg');
        const movingdollimg = Array.from({length: 9}, (_, i) => document.getElementById(`doll_${i + 1}`)); // 인형 배열
        const positions = [
      { top: 45, left: 70 },{ top: 145, left: 70 },{ top: 258, left: 70 },
      { top: 45, left: 210 },{ top: 145, left: 210 },{ top: 258, left: 210 },
      { top: 45, left: 350 },{ top: 145, left: 350 },{ top: 258, left: 350 },
    ];
    const gitimgpositions = [{ top: 370, left: 15 },
        { top: 370, left: 50 },{ top: 370, left: 85 },{ top: 370, left: 120 },
        { top: 370, left: 155 },{ top: 370, left: 190 },{ top: 370, left: 225 },
        { top: 370, left: 260 },{ top: 370, left: 295 },{ top: 370, left: 330}];
    movingdollimg.forEach((doll, i) => {
        doll.style.top = positions[i].top +10+ "px";doll.style.marginLeft = positions[i].left + "px";}); // 인형 위치
for (let i = 1; i <= 10; i++) {
        const imageItem = document.createElement('div');
        const gitId = `git_${i}`;
        imageItem.id = gitId;
        imageItem.innerHTML += `<div class="goodimgplus${i}"><img id="git_${i}" src="../Drawing5/깃발.gif"width="25" height="30"></div>`;
        container.appendChild(imageItem);
        gitimg.push(document.getElementById(`git_${i}`)); 
    }
    document.addEventListener('keydown', function (event) {keys[event.key] = true;});
    document.addEventListener('keyup', function (event) {
        keys[event.key] = false;spacestop = true;  bluebutton.style.visibility= 'visible'; redbutton.style.visibility= 'visible'});
    rollButton.addEventListener('mousedown', () => bluebutton.style.visibility= 'hidden');
    startButton.addEventListener('mousedown', () => redbutton.style.visibility= 'hidden');
    document.addEventListener('mouseup', () => {bluebutton.style.visibility= 'visible';redbutton.style.visibility= 'visible'});

    gitimg.forEach((git, i) => {git.style.position = 'absolute'; git.style.top = gitimgpositions[i].top + "px";git.style.marginLeft = gitimgpositions[i].left +90 + "px";}); // 인형 위치

        function sleep(ms) {return new Promise(resolve => setTimeout(resolve, ms));} // 타이머
        //----------------게임 시작------------------
        maindollimg.addEventListener('click', () => {
            gamestart();
        });
        gameLoop();


        function gameLoop() {
            if(gamestartground.style.visibility != 'hidden'&&spacestop&&keys[' ']){
                redbutton.style.visibility= 'hidden'
                spacestop =false;
                gamestart();
            }

            playbuttonkey();
            requestAnimationFrame(gameLoop);
        }
        function gamestart(){
            getdollcount = 0;
            gamestartground.style.visibility = 'hidden';
            getdoll.style.visibility = 'hidden';
            start = true;
            dicerun = 2;
            diceCount.textContent = `횟수: ${dicerun}`;
            movingbotX=105;
            movingbot.style.marginLeft = movingbotX + "px";
            botrun = true;
        }

        //----------------게임 시작------------------


        function playbuttonkey(){
            if(keys[' ']&&spacestop){
                spacestop = false;
                bluebutton.style.visibility= 'hidden';
                rollDice();
            }
        }

    function rollDice() {
        if(start&&botrun){
            botrun = false;
        dicerun--;
        diceCount.textContent = `횟수: ${dicerun}`;
        let animationInterval = setInterval(function () {
        randomNumber = Math.floor(Math.random() * 6) + 1;
            diceElement.src = `../Drawing5/주사위${randomNumber}.png`;
        }, 60);
        setTimeout(function () {
            clearInterval(animationInterval);
            movingbotX += randomNumber*7;
            rungame();
        }, 700);
    }
    }
    function goodimgup(good){
        goodimg.classList.remove('fade-out');
        goodimg.classList.add('fade-out');
        gitimg[good].appendChild(goodimg);
        if(getdollcount <9){
            dicerun+=1;
            diceCount.textContent = `횟수: ${dicerun}`;
            bonus.classList.remove('fade-out');
            setTimeout(() => {
                bonus.classList.add('fade-out');
            }, 0);
            if(getdollcount==3||getdollcount==6){
                setTimeout(() => {
                    dicerun+=1;
                    diceCount.textContent = `횟수: ${dicerun}`;
            bonus2.classList.remove('fade-out');
            setTimeout(() => {
                bonus2.classList.add('fade-out');
            }, 300);
                })
            }
        }
    }
    async function rungame(){
            if(start){

        if(parseInt(movingbot.style.marginLeft)< movingbotX){
        movingbot.style.marginLeft = (parseInt(movingbot.style.marginLeft)+1) + "px";
        if((parseInt(movingbot.style.marginLeft)-105)%35 == 0){
            getdollcount++;

            goodimgup(((parseInt(movingbot.style.marginLeft)-105)/35));
        }
        await sleep(15);
        if(parseInt(movingbot.style.marginLeft)==420){
            movingbotX=420;
            dicerun=0;
            diceCount.textContent = `횟수: ${dicerun}`; 
        }
        if(parseInt(movingbot.style.marginLeft)== movingbotX){
            botrun = true;
            if(dicerun == 0){
                start=false;
                if(getdollcount<=1){
                drawingfin();
                }else{
                    fin();
                }
            }
        }

        requestAnimationFrame(rungame);
        }
        

    }
    }
    async function fin(){
        let getdollnum = 0;
        while(true){
            getdollnum++;
            getdoll.src = `../doll/인형${getdollnum}.png`;
            getdoll.style.visibility = 'visible';
            getdoll.style.transform = `rotate(20deg)`;await sleep(200);
            getdoll.style.transform = `rotate(-20deg)`;await sleep(200);
            if(getdollcount ==getdollnum+1){
                break;
            }
        }
        drawingfin();
    }


    async function drawingfin() {
        getdoll.src = `../doll/인형${getdollcount}.png`;
        getdoll.style.visibility = 'visible';
            getdoll.style.transform = `rotate(20deg)`;
            await sleep(200);getdoll.style.transform = `rotate(-20deg)`;
            await sleep(200);getdoll.style.transform = `rotate(20deg)`;
            await sleep(200);getdoll.style.transform = `rotate(-20deg)`;
            await sleep(200);getdoll.style.transform = `rotate(0deg)`;
            await sleep(200);gamestartground.style.visibility = 'visible';
        }
</script>
</body>
</html>