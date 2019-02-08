<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<title>Insert title here</title>
<script>

	function getListMember(){
		$.ajax({
			url: "${pageContext.request.contextPath}/member/list",
			type: "get",
			dataType: "json",
			success: function(json){
				console.log(json);
				
//				$("#listContent").remove();
				
				var source = $("#template1").html();
				var f = Handlebars.compile(source);
				var result = f(json.list);
				console.log(result);

				$("#tablebody").append(result);
				
				
			}
			
		})
	}
	
	$(function(){
		$("#btnAdd").click(function(){
			//추가할 때 필요한 것 : MemberVO
			//input에 있는 아이디, 이름, 비밀번호, 이메일 값 가져오기
			var userid = $("#userid").val();
			var username = $("#username").val();
			var userpw = $("#userpw").val();
			var email = $("#email").val();
			//POST -> body에 실어서 보내야되기 때문에 따로 만들어줌.
			var jsonBody = {userid: userid, username: username, userpw: userpw, email: email};
			
			//컨트롤러에 RequestBody(RestControlle에서만 RequestBody 사용함!) 있는 경우 => headers, JSON.stringify 반드시 사용해야 함.
			$.ajax({
				url: "member/",
				type: "post",
				headers:{
					"Content-Type": "application/json",
					"X-HTTP-Method-Override": "POST"
				},
				data: JSON.stringify(jsonBody),
				dataType: "text",
				success: function(json){
//					console.log(json);	
					
					if(json == "Success"){
						
						alert("추가했습니다.");
				
						//등록한 후 리스트가 나타나도록 한다.
						getListMember();
						
						//입력창 비우기
						$("#userid").val("");
						$("#username").val("");
						$("#userpw").val("");
						$("#email").val("");
					}
				}
			})
		})
	})
</script>
</head>
<body>

	<div class="container">
		<h3>REGISTER MEMBER</h3>
		
		<form class="form-horizontal" action="/action_page.php">
			<div class="form-group">
				<label class="control-label col-sm-2" for="userid">아이디</label>
				<div class="col-xs-4">
					<input type="text" class="form-control" id="userid" placeholder="Enter userid" name="userid">
				</div>
			</div>
			
			<div class="form-group"><label class="control-label col-sm-2" for="username">이름</label>
				<div class="col-xs-4">          
					<input type="text" class="form-control" id="username" placeholder="Enter username" name="username">
				</div>
			</div>
			
			<div class="form-group"><label class="control-label col-sm-2" for="userpw">비밀번호</label>
				<div class="col-xs-4">          
					<input type="password" class="form-control" id="userpw" placeholder="Enter userpw" name="userpw">
				</div>
			</div>
			
			<div class="form-group"><label class="control-label col-sm-2" for="email">이메일</label>
				<div class="col-xs-4">          
					<input type="text" class="form-control" id="email" placeholder="Enter email" name="email">
				</div>
			</div>
			
			<div class="form-group">        
				<div class="col-sm-offset-2 col-sm-10">
					<button type="button" class="btn btn-primary" id="btnAdd">추가</button>
					<button type="button" class="btn btn-default" id="btnGetList">리스트 가져오기</button>
				</div>
			</div>
		</form>
		
		<table id="t1">
			<tbody id="tablebody"></tbody>
		</table>
		
		<!-- 리스트 가져오기 -->
		<script id="template1" type="text/x-handlebars-template">
				<tr class="listContent">
					<td>{{userid}}</td>
					<td>{{username}}</td>
					<td>{{userpw}}</td>
					<td>{{email}}</td>
					<td>
						<button type="button" class="btn btn-success" id="btnModify">수정</button>
						<button type="button" class="btn btn-danger" id="btnDelete">삭제</button>
					</td>
				</tr>
		</script>
	</div>

</body>
</html>