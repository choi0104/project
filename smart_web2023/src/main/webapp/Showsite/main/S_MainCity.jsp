<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>이미지 이동 게임</title>
    <style>

        body{user-select: none; /* 텍스트 드래그 불가능하게 설정 */
            background-color: gray;
                        }    
        img{position: absolute; }
        #mainmap{
            margin-top: -80px;
            margin-left: -30px;
        }
        #mainmap2{
            margin-top: -80px;
            margin-left: 900px;
        }
        #media{
            position: absolute;
            margin-top: -200px;
        }
        #department{
            margin-left: -20px;
        }
        #cinema{
            margin-top: 0px;
            margin-left: 895px;
        }
        #ringk{
            margin-left: 653px;
            margin-top: 365px;
        }
        #ringk2{
            margin-left: 1339px;
            margin-top: 365px;
        }
        #ringkback{
            margin-left: 664px;
            margin-top: 373px;
        }
        #ringkback2{
            margin-left: 1350px;
            margin-top: 373px;
        }
        #ringkback3{
            margin-left: 276px;
            margin-top: 358px;
        }
        #ringkback4{
            margin-left: 1021px;
            margin-top: 220px;
        }
        #ringkback5{
            margin-left: 967px;
            margin-top: 423px;
        }
        #tree{
            margin-left: -30px;
            margin-top: 535px;
        }
        #tree2{
            margin-left: 50px;            
            margin-top: 535px;
        }
        #tree3{
            margin-left: 130px;            
            margin-top: 535px;
        }
        #tree4{
            margin-left: 405px;
            margin-top: 535px;
        }
        #tree5{
            margin-left: 485px;            
            margin-top: 535px;
        }
        #tree6{
            margin-left: 565px;            
            margin-top: 535px;
        }
        #tree7{
            margin-left: 645px;
            margin-top: 535px;
        }
        #tree8{
            margin-left: 725px;            
            margin-top: 535px;
        }
        #tree9{
            margin-left: 805px;            
            margin-top: 535px;
        }
        #tree10{
            margin-left: 1320px;            
            margin-top: 535px;  
        }
        #tree11{
            margin-left: 1400px;
            margin-top: 535px;
        }
        #tree12{
            margin-left: 1480px;            
            margin-top: 535px;
        }
        #door1_1{
            margin-left: 0px;
        }
        #LodingGround{
            opacity: 1;
            transition: opacity 0.5s;
            position: absolute;
            width: 1300px; height: 650px;
            background-color: black;
            z-index: 100;
        }
    </style>
</head>
<body >
    <div style="display: flex; justify-content: center; align-items: center; overflow: hidden;">
    <div style="position: relative;width: 1300px; height: 650px; overflow: hidden;">
    <div id="media">
        <img id="mainmap" src="../mainmap/배경1.png" width="1000" draggable="false">
        <img id="mainmap2" src="../mainmap/배경1.png" width="1000" draggable="false">
        <img id="department" src="../mainmap/백화점1.png" width="850" draggable="false">
        <img id="door1_1" src="../mainmap/door1_1.png" width="850" draggable="false">
        <img id="door1_2" src="../mainmap/door1_2.png" width="850" draggable="false">
        <img id="cinema" src="../mainmap/영화관1.png" width="550" draggable="false">
        <img id="door2_1" src="../mainmap/door2_1.png" width="550" draggable="false">
        <img id="door2_2" src="../mainmap/door2_2.png" width="550" draggable="false">
        <img id="ringkback3" src="../mainmap/링크배경.png" width="118" height="147" draggable="false">
        <img id="ringkback4" src="../mainmap/링크배경.png" width="203" height="94" draggable="false">
        <img id="ringkback5" src="../mainmap/링크배경.png" width="330" height="83" draggable="false">
        <img id="tree" src="../mainmap/나무1.png" width="160" draggable="false">
        <img id="tree2" src="../mainmap/나무1.png" width="160" draggable="false">
        <img id="tree3" src="../mainmap/나무1.png" width="160" draggable="false">
        <img id="tree4" src="../mainmap/나무1.png" width="160" draggable="false">
        <img id="tree5" src="../mainmap/나무1.png" width="160" draggable="false">
        <img id="tree6" src="../mainmap/나무1.png" width="160" draggable="false">
        <img id="tree7" src="../mainmap/나무1.png" width="160" draggable="false">
        <img id="tree8" src="../mainmap/나무1.png" width="160" draggable="false">
        <img id="tree9" src="../mainmap/나무1.png" width="160" draggable="false">
        <img id="tree10" src="../mainmap/나무1.png" width="160" draggable="false">
        <img id="tree11" src="../mainmap/나무1.png" width="160" draggable="false">
        <img id="tree12" src="../mainmap/나무1.png" width="160" draggable="false">
        <img id="ringk" src="../mainmap/링크게시판1.png" width="291" draggable="false">
        <img id="ringk2" src="../mainmap/링크게시판1.png" width="291" draggable="false">
        <a href="https://www.naver.com/" target="_blank">
        <img id="ringkback" src="../mainmap/링크배경.gif" width="272" height="258" draggable="false">
        <img id="ringkback2" src="../mainmap/링크배경.gif" width="272" height="258" draggable="false">
        </a>
    </div>
    <img id="Player" src="../character/characterdown1.png" width="45">
    <div id="LodingGround"></div>
</div>
</div>
</body>
<script>
let canvas;let context;let PlayerX = 200;let PlayerY = 490;let PlayerSpeed = 5;let keys = {};let i = 1;let characterway = 4;
const mapimg = document.getElementById("media");
const Player = document.getElementById("Player");
const LodingGround =document.getElementById('LodingGround');
let mapX =0;
mapimg.style.marginLeft = mapX + "px";
let upway,downway,leftway,rightway=true;
let carmove = [];
let carimg = [];
let carstartlocation = 0;
let carlinecount =0;
let carrunrightcount = 0;
let carnum = 0;
let cartopran =0;
let cinema_doorconut =0;
let department_doorconut =0;
let cinema_doorbutton = false;
let department_doorbutton = false;
let movingmap =true;


const door1_1 = document.getElementById("door1_1");
const door1_2 = document.getElementById("door1_2");
const door2_1 = document.getElementById("door2_1");
const door2_2 = document.getElementById("door2_2");
door1_1.style.marginLeft = "-20px";
door1_2.style.marginLeft = "-20px";
door2_1.style.marginLeft = "895px";
door2_2.style.marginLeft = "895px";
document.addEventListener('keydown', function (event) {keys[event.key] = true;});
    document.addEventListener('keyup', function (event) {keys[event.key] = false;});
    window.addEventListener('blur', function () {
    keys = {};
  });


for(let i = 0;i<6;i++){
    carimg[i] = document.createElement('img');
	carimg[i]
}
carimg[0].src = '../mainmap/car1.gif'
	carimg[1].src = '../mainmap/car2.gif'
		carimg[2].src = '../mainmap/car3.gif'
			carimg[3].src = '../mainmap/car4.gif'
				carimg[4].src = '../mainmap/car5.gif'
					carimg[5].src = '../mainmap/car6.gif'



for(let i = 0; i< 100; i++){
    if(carstartlocation>=3000 && carlinecount ==0){
        carstartlocation = 0;
        carlinecount = 1;

    }else if(carstartlocation>=3000 && carlinecount ==1){
            carstartlocation = 0;
    carlinecount = 2;

    }else if(carstartlocation>=3000 && carlinecount ==1){
            carstartlocation = 0;
    carlinecount = 3;
       break;
    }
    carnum = Math.floor(Math.random()*6)+1;
    cartopran = Math.floor(Math.random()*20);
    carmove[i] = document.createElement('img');
    carmove[i].src = "../mainmap/car"+carnum+".gif";
    carmove[i].style.width = "100px";
    mapimg.appendChild(carmove[i]);
    carmove[i].style.marginLeft = carstartlocation-100 + "px";
    if(carstartlocation<3000 && carlinecount ==0){
    carmove[i].style.marginTop = 720+cartopran+"px";
    carmove[i].style.transform = "scaleX(-1)";
    carrunrightcount++;
    }else if(carstartlocation<3000 && carlinecount ==1){
    carmove[i].style.marginTop = 760+cartopran+"px";
    carmove[i].style.transform = "scaleX(-1)";
    carrunrightcount++;
    }else if(carstartlocation<3000 && carlinecount ==2){
    carmove[i].style.marginTop = 800+cartopran+"px";
    }
    carmove[i].style.zIndex =1;
    carstartlocation = (Math.random()*500+120) + carstartlocation;
}

setTimeout(Loding, 1000)

function Loding(){
    LodingGround.style.opacity = 0;
    LodingGround.addEventListener('transitionend', function() {
        LodingGround.style.zIndex = -100;
    });
    window.focus();
    runGame();
}
function runGame(){
    imgmove();
    canvasdraw();
    toggleDoor();
    if(movingmap){
    requestAnimationFrame(runGame);
    }
}
function imgmove() {
    // 방향키 입력 처리
    if (keys['ArrowUp']) {PlayerY -= PlayerSpeed;characterway=1;
        if(!keys['ArrowDown']){downway = false;upway =true;if(i > 39){i=1;} if(i >= 1 || i <= 39){Player.src = "../character/characterup"+Math.floor((i/10)+1)+".png";}
            // ----상향키 맵이동 한계 지점----
            if(PlayerY<410){PlayerY+=PlayerSpeed;}//플레이어 상향키 최대치
            if(PlayerX>-100 && PlayerX<=240 &&PlayerY<445){PlayerY+=PlayerSpeed;//플레이어 백화점 왼쪽 나무 위치 경계 지점
            }else if(PlayerX>405 && mapX>-275&&PlayerY<445){PlayerY+=PlayerSpeed;//플레이어 백화점 오른쪽 나무 위치 경계 지점
            }else if(mapX<=-275&&PlayerY<420){PlayerY+=PlayerSpeed;//플레이어 영화관 왼쪽 나무 위치 경계 지점
            }else if(PlayerX>=710&&PlayerY<445){PlayerY+=PlayerSpeed;//플레이어 영화관 오른쪽 나무 위치 경계 지점
            }
            // ----상향키 맵이동 한계 지점----
        }else if(upway){Player.src = "../character/characterup1.png";} // 상반키 입력시 캐릭터 시점 설정
    }
    if (keys['ArrowDown']) {PlayerY += PlayerSpeed;characterway=2;
        if(!keys['ArrowUp']){upway=false;downway =true;if(i > 39){i=1;} if(i >= 1 || i <= 39){Player.src = "../character/characterdown"+Math.floor((i/10)+1)+".png";}
            // ----하향키 맵이동 한계 지점----
            if(PlayerY>500){PlayerY-=PlayerSpeed}//플레이어 좌측키 최대치
            // ----하향키 맵이동 한계 지점----
        }else if(downway){Player.src = "../character/characterdown1.png";} // 상반키 입력시 캐릭터 시점 설정
    }
    if (keys['ArrowLeft']) {PlayerX -= PlayerSpeed;characterway=3;
        if(!keys['ArrowRight']){leftway = true;rightway = false;if(i > 39){i=1;} if(i >= 1 || i <= 39){Player.src = "../character/characterleft"+Math.floor((i/10)+1)+".png";}
            // ----좌측키 맵이동 한계 지점----
            if(PlayerX<=650 &&mapX <0){PlayerX+=PlayerSpeed;mapX+=PlayerSpeed;}//플레이어 위치 중앙 지점
            if(PlayerX<-10){PlayerX+=PlayerSpeed}//맵 위치 왼쪽 끝 지점
            if(PlayerX>-100 && PlayerX<=240 &&PlayerY<445){PlayerX+=PlayerSpeed;}//플레이어 백화점 왼쪽 나무 위치 경계 지점
            if(PlayerX>405 && mapX>-280&&PlayerY<445){PlayerX+=PlayerSpeed;}//플레이어 영화관 왼쪽 나무 위치 경계 지점
            // ----좌측키 맵이동 한계 지점----
    }else if(leftway){Player.src = "../character/characterleft1.png";} // 상반키 입력시 캐릭터 시점 설정
    }
    if (keys['ArrowRight']) {PlayerX += PlayerSpeed;characterway=4;
        if(!keys['ArrowLeft']){rightway = true;leftway = false;if(i > 39){i=1;} if(i >= 1 || i <= 39){Player.src = "../character/characterright"+Math.floor((i/10)+1)+".png";}
            // ----우측키 맵이동 한계 지점----
            if(PlayerX>650 && mapX >-600){PlayerX-=PlayerSpeed;mapX-=PlayerSpeed;//플레이어 위치 중앙 지점
            }
            if(PlayerX>1250){PlayerX-=PlayerSpeed}//맵 위치 오른쪽 끝 지점
            if(PlayerX>405 && PlayerX<=600 &&PlayerY<445){PlayerX-=PlayerSpeed;//플레이어 백화점 오른쪽 나무 위치 경계 지점
            }else if(PlayerX>=710&&PlayerY<445){PlayerX-=PlayerSpeed;//플레이어 영화관 오른쪽 나무 위치 경계 지점
            }
            // ----우측키 맵이동 한계 지점----
        }else if(rightway){Player.src = "../character/characterright1.png";} // 상반키 입력시 캐릭터 시점 설정
    }
    if(keys['ArrowUp'] || keys['ArrowDown'] || keys['ArrowLeft'] || keys['ArrowRight']){i++;
    }else{Player.src = "../character/characterway"+ characterway +".png";
    }
}
function canvasdraw(){
    Player.style.marginLeft = PlayerX + "px";
    Player.style.marginTop = PlayerY + "px";
    mapimg.style.marginLeft = mapX + "px";
    for(let i = 0; i< carmove.length; i++){
        if(i < carrunrightcount){
        carmove[i].style.marginLeft = (parseInt(carmove[i].style.marginLeft)+6) + "px";
        if(parseInt(carmove[i].style.marginLeft)>3000){
            carmove[i].style.marginLeft = "-100px"
            }
        }else{
            carmove[i].style.marginLeft = (parseInt(carmove[i].style.marginLeft)-6) + "px";
            if(parseInt(carmove[i].style.marginLeft)<-100){
                carmove[i].style.marginLeft = "3000px"
            }
        }
    }
}
function toggleDoor(){
    if(PlayerX>282&&PlayerX<360&&PlayerY<430){
        department_doorconut = 50;
        department_doorbutton =true;
        if (keys[' ']){
            alert("open")
        }
    }
    if((PlayerX<=282||PlayerX>=360||PlayerY>=430)&&parseInt(door1_1.style.marginLeft)< -20&& department_doorconut ==0){
        door1_1.style.marginLeft = parseInt(door1_1.style.marginLeft)+ 1+"px";
        door1_2.style.marginLeft = parseInt(door1_2.style.marginLeft)- 1+"px";
    }
    if(parseInt(door1_1.style.marginLeft)> -48&&department_doorbutton){
            door1_1.style.marginLeft = parseInt(door1_1.style.marginLeft)- 1+"px";
            door1_2.style.marginLeft = parseInt(door1_2.style.marginLeft)+ 1+"px";
            if(parseInt(door1_1.style.marginLeft) == -48){
                department_doorbutton= false;
            }
        }

    if(mapX<-415&&mapX>-525&&PlayerY<430){
        cinema_doorconut = 50;
        cinema_doorbutton =true;
        if (keys[' ']){
            var linkUrl = "/human/Showsite/main/S_Cinema.jsp";
            movingmap =false;
            LodingGround.style.zIndex = 100;
            LodingGround.style.opacity = 1;
            setTimeout(() => {
                window.location.href = linkUrl;          
            }, 400);
        }
    }
    if((mapX>=-415||mapX<-525||PlayerY>=430)&&parseInt(door2_1.style.marginLeft)< 895&& cinema_doorconut ==0){
        door2_1.style.marginLeft = parseInt(door2_1.style.marginLeft)+ 1+"px";
        door2_2.style.marginLeft = parseInt(door2_2.style.marginLeft)- 1+"px";
    }
    if(parseInt(door2_1.style.marginLeft)> 872&& cinema_doorconut){
        door2_1.style.marginLeft = parseInt(door2_1.style.marginLeft)- 1+"px";
        door2_2.style.marginLeft = parseInt(door2_2.style.marginLeft)+ 1+"px";
        if(parseInt(door2_1.style.marginLeft) == 872){
            cinema_doorbutton= false;
        }
    }
    
    if(department_doorconut>0){
        department_doorconut--;
    }
    if(cinema_doorconut>0){
        cinema_doorconut--;
    }

}
</script>
</html>
