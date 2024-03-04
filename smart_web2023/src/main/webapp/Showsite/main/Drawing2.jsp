<!DOCTYPE html>
<html>
<head>
  <style>
    @keyframes rotateAnimation {from {transform: rotate(0deg);}to {transform: rotate(360deg);}}
    body{user-select: none; /* 텍스트 드래그 불가능하게 설정 */}
    .container{text-align: center; position: relative;}
    #maindrawingimg {width: 500px;}
    img{position: absolute;}
    

    #doll_1,#doll_2,#doll_3,#doll_4,#doll_5,#doll_6,#doll_7,#doll_8,#doll_9{
      width: 90px;
    }
    #target_1,#target_4,#target_7{
      width: 10px;
      height: 10px;
    }
    #target_2,#target_5,#target_8{
      width: 15px;
      height: 15px;

    }
    #target_3,#target_6,#target_9{
      width: 20px;
      height: 20px;

    }
    #movingtarget{
      position: absolute;
      width: 1px;
      height: 1px;
    }
    #movingimg{
      margin-left: -21px;
      margin-top: -2px;
    }
    #gamestartcanvas {pointer-events: auto;opacity: 0.2;width: 420px;height: 180px;background: linear-gradient(to bottom, gray 20%, black 20%, black 80%, gray 80%);position: absolute;}
        #gamestartground {display: flex;justify-content: center;align-items: center;height: 410px;width: 502px;position: absolute;z-index: 2;}
        @keyframes colorChange {0%,50% {opacity: 1;}51%,100% {opacity: 0;}}
        .goodimgopacityup {animation: fadeOut 2s ease-in-out, moveUp 2s ease-in-out;opacity: 0;}
        @keyframes fadeOut {0% {opacity: 1;}100% {opacity: 0;}}
        @keyframes moveUp {0% {transform: translateY(0);}100% {transform: translateY(-80px);}}
        .loseimgopacitydown {animation: losefadeOut 2s ease-in-out, moveDown 2s ease-in-out;opacity: 1;}
        @keyframes losefadeOut {0% {opacity: 0;}100% {opacity: 1;}}
        @keyframes moveDown {100% {transform: translateY(0);}0% {transform: translateY(-40px);}}
        #goodimg{
          width: 50px;
          visibility: hidden;
        }
        #loseimg{
          visibility: hidden;
          z-index: 0;
          width: 150px;
          margin-left: 190px;
          margin-top: 185px;
        }

  </style>
</head>
<body>
  <div style="display: flex; justify-content: center; align-items: center; margin-right: 500px;">
    <div class="container">
      <img id="maindrawingimg" src="../Drawing2/인형뽑기2_1.png" draggable="false">
      <img id="doll_1" src="../doll/인형1.png" draggable="false"><img id="doll_2" src="../doll/인형2.png" draggable="false"><img id="doll_3" src="../doll/인형3.png" draggable="false">
      <img id="doll_4" src="../doll/인형4.png" draggable="false"><img id="doll_5" src="../doll/인형5.png" draggable="false"><img id="doll_6" src="../doll/인형6.png" draggable="false">
      <img id="doll_7" src="../doll/인형7.png" draggable="false"><img id="doll_8" src="../doll/인형8.png" draggable="false"><img id="doll_9" src="../doll/인형9.png" draggable="false">
      <img id="target_1" src="../Drawing2/과녁.png" draggable="false"><img id="target_2" src="../Drawing2/과녁.png" draggable="false"><img id="target_3" src="../Drawing2/과녁.png" draggable="false">
      <img id="target_4" src="../Drawing2/과녁.png" draggable="false"><img id="target_5" src="../Drawing2/과녁.png" draggable="false"><img id="target_6" src="../Drawing2/과녁.png" draggable="false">
      <img id="target_7" src="../Drawing2/과녁.png" draggable="false"><img id="target_8" src="../Drawing2/과녁.png" draggable="false"><img id="target_9" src="../Drawing2/과녁.png" draggable="false">
      <img id="goodimg" src="../doll/good.png">
      <img id="loseimg" src="../doll/lose.png">
      <div id="movingtarget">
        <img id="movingimg" src="../Drawing2/인형뽑기2_4.png">
      </div>
      <div id="gamestartground">
        <canvas id="gamestartcanvas"></canvas>
        <span style="font-size: 45px; font-family: cursive;">game start</span>
        <span style="animation: colorChange 1s infinite;">click</span>
      </div>

    </div>
  </div>

<script>

let clear = false;
let lose = false;

    let spacestop =true;
    let isMoving = false;
    let isMovingRight = false;
    let isMovingUp = false;
    let dollisMoving = false;
    let dolldown = false;
    let timestop = false;
    let dollspin = false;
    let order = 0;
    let index = 0;
    let movecount = 0;
    let movingtop;
    let mpvingleft;
    let gamerun =false;
    let getdollloc = false;
    const keys = {};
    const movingtarget = document.getElementById("movingtarget");
    const gamestartground = document.getElementById('gamestartground');
    const goodimg = document.getElementById('goodimg');
    const loseimg = document.getElementById('loseimg');
    const maindollimg = document.getElementById('gamestartcanvas');


    const movingdollimg = Array.from({ length: 9 }, (_, i) => document.getElementById(`doll_${i + 1}`));
    const targetimg = Array.from({ length: 9 }, (_, i) => document.getElementById(`target_${i + 1}`));
    const positions = [
      { top: 45, left: 70 },{ top: 145, left: 70 },{ top: 258, left: 70 },
      { top: 45, left: 210 },{ top: 145, left: 210 },{ top: 258, left: 210 },
      { top: 45, left: 350 },{ top: 145, left: 350 },{ top: 258, left: 350 },
    ];
    movingdollimg.forEach((doll, i) => {
      doll.style.marginTop = positions[i].top + "px";
      doll.style.marginLeft = positions[i].left + "px";
    });

    for (let i = 0; i < 3; i++) {
      targetimg[i*3].style.top = positions[i*3].top + 58 + "px";
      targetimg[i*3].style.left = positions[i*3].left + 39 + "px";
      targetimg[i*3+1].style.top = positions[i*3+1].top + 49 + "px";
      targetimg[i*3+1].style.left = positions[i*3+1].left + 38 + "px";
      targetimg[i*3+2].style.top = positions[i*3+2].top + 48 + "px";
      targetimg[i*3+2].style.left = positions[i*3+2].left + 36 + "px";
    }

    
    movingtarget.style.marginLeft=67+"px";
    movingtarget.style.marginTop=385+"px";
    document.addEventListener("keyup", (event)=> {keys[event.key] = false; spacestop = true;})
    document.addEventListener("keydown", (event) => {keys[event.key] = true;});

    runGame();
    function sleep(ms) {
      return new Promise(resolve => setTimeout(resolve, ms));
    }
    maindollimg.addEventListener('click', () => {
      
      gamestart();
    });
    function gameLoop() {
      
      requestAnimationFrame(gameLoop);
    }
    function gamestart(){
      movingdollimg[index].style.zIndex = 0;
      gamestartground.style.visibility = 'hidden';
      gamerun = true;
    }
    async function runGame(){

      if (gamerun) {
      movingtop = parseInt(movingtarget.style.marginTop);
      mpvingleft = parseInt(movingtarget.style.marginLeft);
      movinglocation();
      if(timestop){await sleep(2000);timestop=false;}
      if(dollisMoving){await sleep(25);}
      moveImage();
      }
      if(gamestartground.style.visibility != 'hidden'&&spacestop&&keys[' ']){
        if(getdollloc){
        movingdollimg[index].style.marginTop =positions[index].top + "px";
        movingdollimg[index].style.marginLeft =positions[index].left + "px";
        }
        spacestop =false;
        gamestart();
      }
      setTimeout(runGame, 1);
    }

    function movinglocation(){
      if (keys[' ']&&spacestop) {
        spacestop = false;
        if (!isMoving) {isMoving = true;isMovingRight = true;// 인형뽑기 막대 좌우 이동
        }else if(order == 1){isMovingRight = false;isMovingUp = true;// 이미지 이동 멈춤
        }else if(order == 2){isMovingUp = false;
          const movingloc = movingtarget.getBoundingClientRect();
          for(let i = 0; i < 9; i++){
            const rect = targetimg[i].getBoundingClientRect();
            if(rect.top<movingloc.bottom-2&&
            rect.bottom > movingloc.top+2&&
            rect.left < movingloc.right-2 &&
            rect.right > movingloc.left+2){
              goodimg.style.visibility = 'visible';
              goodimg.style.marginTop = positions[i].top + 15+ "px";
              goodimg.style.marginLeft = positions[i].left +20+ "px";
              goodimg.classList.add('goodimgopacityup');
              index = i;
              timestop = true;
              dollisMoving = true;
              break;
            }else{
              dollisMoving = false;
            }
          }
          if(!dollisMoving){
            lose = true;
            drawingfin();
          }
        }
        order++;
      }
    }


    let leftPosition = true;
    let topPosition = true;
    // 이미지 이동 함수 
    function moveImage() {
    // 막대 인형 위치
      // 막대 이동
      if (isMoving) {
        // 막대 좌우이동
        if(isMovingRight && leftPosition) {const newPosition=mpvingleft+1; movingtarget.style.marginLeft  = newPosition + "px"; // 좌로 이동
        }else if(isMovingRight && !leftPosition) {const newPosition=mpvingleft-1; movingtarget.style.marginLeft  = newPosition + "px"; // 우로 이동
        }
        // 막대 상하이동
        if(isMovingUp && topPosition){const newPosition =  movingtop - 1; movingtarget.style.marginTop = newPosition + "px"; // 위로 이동
        } else if(isMovingUp && !topPosition){const newPosition = movingtop + 1;movingtarget.style.marginTop = newPosition + "px"; // 아래로 이동
        }
        // 막대 이동멈춤
        if( mpvingleft >= 439){leftPosition=false;
        }else if (mpvingleft <= 45){leftPosition=true;
        }else if(movingtop >= 355){topPosition=true;
        }else if(movingtop < 50){topPosition=false;
        }
        // 인형 이동
        if(dollisMoving){
          movingtarget.style.marginTop  = movingtop-1 + "px";
          movingdollimg[index].style.marginTop  = parseInt(movingdollimg[index].style.marginTop)-1 + "px";
          movecount++;
          //인형 명중
          if(movecount ==40){
            dollisMoving=false;
            movingdollimg[index].style.zIndex = -1;
            dolldown=true;
            dollspin=true;
          }
        }
        // 인형 낙하
        if(dolldown){
          const newPosition2 = parseInt(movingdollimg[index].style.marginTop)+1; movingdollimg[index].style.marginTop  = newPosition2 + "px";
          if(dollspin){
          let imgreverse = (Math.ceil(Math.random()*2));if(imgreverse == 2){rotationDirection  = 'reverse';}else{rotationDirection = 'normal';}//회전방향  
          const speed = (Math.ceil(Math.random()*4+1));movingdollimg[index].style.animation = `rotateAnimation ${speed}s linear infinite ${rotationDirection}`;movingdollimg[index].classList.add('rotating');//회전속도
          dollspin=false;
        }
        if(newPosition2>500 ){
          clear = true;
          drawingfin();
        }
        }
        //인형 회전
        

      }
    }
        //----------------게임 종료------------------
        async function drawingfin() { 
            if(lose){
              lose = false;
              loseimg.style.visibility = 'visible';
              loseimg.classList.add('loseimgopacitydown');
              await sleep(2000);
              loseimg.style.visibility = 'hidden';
              loseimg.classList.remove('loseimgopacitydown');
            }
            order = 0;
            dollisMoving =false;
            dolldown=false;
            isMoving=false;
            getdollloc = true;
            gamerun = false;
            movecount = 0;
            if(clear){
            await sleep(200);
            movingdollimg[index].style.zIndex = 1;
            movingdollimg[index].style.removeProperty('animation');
            movingdollimg[index].classList.remove('rotating');
            movingdollimg[index].style.marginTop = "180px";
            movingdollimg[index].style.marginLeft = "210px";
            await sleep(200);movingdollimg[index].style.transform = `rotate(20deg)`;
            await sleep(200);movingdollimg[index].style.transform = `rotate(-20deg)`;
            await sleep(200);movingdollimg[index].style.transform = `rotate(20deg)`;
            await sleep(200);movingdollimg[index].style.transform = `rotate(-20deg)`;
            await sleep(200);movingdollimg[index].style.transform = `rotate(0deg)`;
            await sleep(200);
            gamestartground.style.visibility = 'visible';
            clear=false;
            
            }
            goodimg.classList.remove('goodimgopacityup');
            goodimg.style.visibility = 'hidden';
            gamestartground.style.visibility = 'visible';
            movingtarget.style.marginLeft=67+"px";
            movingtarget.style.marginTop=385+"px";

        }
        //----------------게임 종료------------------

  </script>
</body>
</html>
