<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.replyLi .item{
		border-bottom: 1px solid #ddd;
		padding: 5px;
		width: 400px;
	}
	
	.replyLi .rno{
		font-weight: bold;
	}
	
	.pagination{
		width: 100%;
	}
	
	.pagination li{
		list-style: none;
		float: left;
		padding: 3px;
		border: 1px solid black;
		margin: 3px;
	}
	
	.pagination li a{
		margin: 3px;
		text-decoration: none;
		color: black;
	}
	
	.pagination .active a{
		color: white;
		background-color: black;
	}
	
	#modDiv{
		width: 300px;
		height: 100px;
		background-color: gray;
		position: absolute;
		top: 40%;
		left: 40%;
		padding: 10px;
		z-index: 1000;
		display: none;	/* 수정 버튼 누를 때 수정 화면 나오도록 한다. */
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- handlebars -> 제이쿼리 먼저 있어야 함. -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>

<script id="template1" type="text/x-handlebars-template">
	{{#each.}}
	<li data-rno="{{rno}}" class="replyLi">
		<div class="item">
			<span class="rno">{{rno}}</span> : <span class="writer">{{replyer}}</span><br>
			<span>{{replytext}}</span>
			<div class="btnWrap">
				<button class="modify">수정</button>
				<button class="delete">삭제</button>
			</div>
		</div>
	</li>
	{{/each}}
</script>



<script>
	//처음 bno는 받아올 수 없으니까 전역변수로 사용
	var bno = 34804;
	
	//리스트 먼저 보이게 한다 => 페이지 번호 누를 때마다 리스트 보이게 한다. (함수로 만들어서 호출시킨다.)
	//매개변수 타입 적지 않고 변수명만 사용.
	function getPageList(page){
		$.ajax({
			//컨트롤러에 있는 주소 replies/{bno}/{page}
			url: "replies/" + bno + "/" + page,
			type: "get",
			dataType: "json",
			success: function(json){
				console.log(json);
				
				
				//새로고침 될 때 안에 있는 내용 날린다. => 댓글 작성 성공하면 다시 getPageList 호출하기 때문에
				$("#replies").empty();
				
				var source = $("#template1").html();
				var f = Handlebars.compile(source);
				var result = f(json.list);
				
				$("#replies").append(result);
				
				/* $(json.list).each(function(i, obj){
					//비어있는 태그 만들어서 속성 추가하기
					var liTag = $("<li>").attr("data-rno", obj.rno).attr("class", "replyLi");
					//attr 말고도 class 추가니까 addClass도 가능.
					var divTag = $("<div>").addClass("item");
					var rnoSpanTag = $("<span>").addClass("rno").text(obj.rno);
					var writerSpanTag = $("<span>").addClass("writer").text(obj.replyer);
					var contentSapnTag = $("<span>").text(obj.replytext);
					var btnDivTag = $("<div>").addClass("btnWrap");
					var btnModifyTag = $("<button>").addClass("modify").text("수정");
					var btnDeleteTag = $("<button>").addClass("delete").text("삭제");
					
					liTag.append(divTag);
					divTag.append(rnoSpanTag).append(" : ").append(writerSpanTag).append("<br>");
					divTag.append(contentSapnTag);
					divTag.append(btnDivTag);
					btnDivTag.append(btnModifyTag).append(btnDeleteTag);
					
					$("#replies").append(liTag);
						
				}) */
				
				
				
				//pagination
				/* <li class="active"><a href="#">1</a></li> */
				
				//새로고침 될 때 안에 있는 내용 날린다. => 댓글 작성 성공하면 다시 getPageList 호출하기 때문에
				$(".pagination").empty();
				
				for(var i = json.pageMaker.startPage ; i <= json.pageMaker.endPage ; i++){
					
					var liTag = $("<li>");
					var aTag = $("<a>").attr("href", "#").append(i);
					liTag.append(aTag);
					
					//시작하는 페이지가 선택한 페이지와 같으면
					if(i == json.pageMaker.cri.page){
						liTag.addClass("active");
					}
					
					$(".pagination").append(liTag);
					
				}
				
			}
		})	
	}

	$(function(){
		getPageList(1);	//1번 페이지 호출
		
		$("#bno").val(bno);
		
		$("#btnAdd").click(function(){
			//댓글 등록할 때 => 컨트롤러 안에 bno, replyer, replytext 필요.
			var bno = $("#bno").val();
			var replyer = $("#replyer").val();
			var replytext = $("#replytext").val();
			
			//post 방식에서는 body에 실어서보내야 되기 때문에 변수로 만들어줌. {키:값, 키: 값, ..}
			var jsonBody = {bno: bno, replyer: replyer, replytext: replytext};
			
			//컨트롤러에 RequestBody(RestControlle에서난 RequestBody 사용함!) 있는 경우 => headers, JSON.stringify 반드시 사용해야 함.
			$.ajax({
				url: "replies/",
				type: "post",
				//stringify 사용할 때 headers도 같이 사용해야 함.
				headers:{
					"Content-Type": "application/json",
					"X-HTTP-Method-Override": "POST"
				},
				//컨트롤러에 RequestBody가 있는 경우 stringify를 사용해야 함.
				//"{bno: bno, replyer: replyer, replytext: replytext}" String 방식으로 보내줌.
				data: JSON.stringify(jsonBody),	
				//컨트롤러에서 register return 값이 String이므로 text로 받아야함.
				dataType: "text",
				success: function(json){
					console.log(json);	
					
					if(json == "success"){
						alert("등록하였습니다.");
						
						//등록한 후 댓글창 새로고침되도록 한다.
						getPageList(1);
					}
				}
			})
		})
		
		
		// ====== 수정버튼 : 동적으로 버튼 만들어지까 on 사용해야 함. ======
		$(document).on("click", ".modify", function(){
			//rno 가져오기
			//this: 수정버튼
			var rno = $(this).parents(".replyLi").attr("data-rno");
			$("#modDiv").find(".modal-title").text(rno);
			
			//댓글 내용 가져오기
			var text = $(this).parent().prev().text();
			$("#replyModText").val(text);
			
			$("#modDiv").show();
		})
		
		//이미 body안에 태그가 있으므로 굳이 document 사용안해도 됨.
		//취소 버튼 누르면 수정할 수 있는 창 안보이게한다.
		$("#btnCancel").click(function(){
			$("#modDiv").hide();
		})
		
		$("#btnReplyMod").click(function(){
			//수정하려는 내용 들고오기(그럴려면 rno의 값을 알아야 함!)
			var rno = $(".modal-title").text();
			var replytext = $("#replyModText").val();
			var jsonBody = {replytext: replytext};
			
			//ajax로 보냄.
			$.ajax({
				url: "replies/" + rno,
				type: "put",
				//보낼 데이터 => int rno와 vo(RequestBody있으니까 headers, stringify 필요)
				headers:{
					"Content-Type": "application/json",
					"X-HTTP-Method-Override": "PUT"
				},
				data: JSON.stringify(jsonBody),	
				dataType: "text",
				success: function(json){
					console.log(json);
					
					if(json == "Success"){
						alert(rno + "가 수정되었습니다.");
					}
					
					//수정되고 나서 창 안보이게 처리한다.
					$("#modDiv").hide();
					//리스트 갱신시킨다.
					getPageList(1);
				}
				
			})
		})
		
		
		// ====== 삭제버튼 : 동적으로 버튼 생기니까 on 사용해야 함. ======
		$(document).on("click", ".delete", function(){
			//삭제할 때 rno 필요하니까 가져온다.
			var rno = $(this).parents(".replyLi").attr("data-rno");
			
			$.ajax({
				url: "replies/" + rno,
				type: "delete",
				dataType: "text",
				success: function(json){
					console.log(json);
					
					if(json == "Success"){
						alert("삭제되었습니다.");
					}
					
					//리스트 갱신시킨다.
					getPageList(1);
				}
			})
		})
		
		
		// ====== 페이지 이동 : 동적으로 버튼 생기니까 on 사용해야 함. ======
		$(document).on("click", ".pagination a", function(e){
			 e.preventDefault();	//클릭 차단
			 
			 //내가 몇 번째 클릭하는지 어떻게 알지? => 일단 페이지 번호를 가지고 온다. <a>안에 페이지 번호 있으니까 this
			 var num = $(this).text();
			 getPageList(num);
			 
			
		})
	})
</script>
</head>
<body>
	<div id="modDiv">
		<div class="modal-title">rno</div>
		<div>
			<input type="text" id="replyModText">
		</div>
		<div>
			<button id="btnReplyMod">수정</button>
			<button id="btnCancel">취소</button>
		</div>
	</div>

	<h2>Ajax Test Page</h2>
	
	<div>
		<div>
			bno : <input type="text" name="bno" id="bno">
		</div>
		<div>
			replyer : <input type="text" name="replyer" id="replyer">
		</div>
		<div>
			replytext : <input type="text" name="replytext" id="replytext">
		</div>
		<button id="btnAdd">ADD REPLY</button>
	</div>
	
	<!-- 댓글 리스트 나오는 부분 -->
	<ul id="replies">
		<!-- <li data-rno="1" class="replyLi">
			<div class="item">
				<span class="rno">1</span> : <span class="writer">user</span><br>
				<span>댓글 내용</span>
				<div class="btnWrap">
					<button class="modify">수정</button>
					<button class="delete">삭제</button>
				</div>
			</div>
		</li> -->
	</ul>
	
	<!-- 페이지 번호 나오는 부분 -->
	<ul class="pagination">
		<!-- <li class="active"><a href="#">1</a></li>
		<li><a href="#">2</a></li>
		<li><a href="#">3</a></li> -->
	</ul>
</body>
</html>