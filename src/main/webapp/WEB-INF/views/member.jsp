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
<style>
	#t1{
		width: 700px;
	}
	
	#btnDelete{
		margin-left: 5px;
	}
</style>
<script>

	function getListMember(){
		$.ajax({
			url: "${pageContext.request.contextPath}/member/list",
			type: "get",
			dataType: "json",
			success: function(json){
				console.log(json);
				
				$("#tablebody").empty();
					
				$(json).each(function(i, obj){
					var trTag = $("<tr>").addClass("listContent");
					var tdId = $("<td>").attr("data-userid", obj.userid).text(obj.userid);
					var tdPw = $("<td>").text(obj.userpw);
					var tdName = $("<td>").text(obj.username);
					var tdEmail = $("<td>").text(obj.email);
					var btnMod = $("<button>").attr("type", "button").addClass("btn btn-success btn-sm").prop("id", "btnModify").attr("data-toggle", "modal").attr("data-target", "#modifyModal").text("수정");
					var btnDel = $("<button>").attr("type", "button").addClass("btn btn-danger btn-sm").prop("id", "btnDelete").text("삭제");
					var tdBtn = $("<td>").append(btnMod).append(btnDel);
					
					trTag.append(tdId);
					trTag.append(tdName);
					trTag.append(tdPw);
					trTag.append(tdEmail);
					trTag.append(tdBtn);
					
					$("#tablebody").append(trTag);
					
				})		
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
		
		//리스트 가져오기
		$("#btnGetList").click(function(){
			getListMember();
		})
		
		//삭제 버튼
		$(document).on("click", "#btnDelete", function(){
			//삭제할 때 userid 필요
			var userid = $(this).parent().parent().children().first().html();
			
			$.ajax({
				url: "member/" + userid,
				type: "delete",
				dataType: "text",
				success: function(json){
					console.log(json);
					
					if(json == "Success"){
						alert("삭제되었습니다.");
					}
					//리스트 새로 불러오기
					getListMember();
				}
			})	
		})
		
		//수정 버튼 클릭했을 때 기존에 있는 값들 가지고 오기
		$(document).on("click", "#btnModify", function(){
			var userid = $(this).parent().parent().children().first().html();
			$("#modifyUserid").val(userid);
			
			var username = $(this).parent().parent().children().eq(1).html();
			$("#modifyUsername").val(username);
			
			var userpw = $(this).parent().parent().children().eq(2).html();
			$("#modifyUserpw").val(userpw);
			
			var useremail = $(this).parent().parent().children().eq(3).html();
			$("#modifyEmail").val(useremail);
			
		})
		
		//모달창에 있는 Modify 버튼 눌렀을 때
		$(document).on("click", "#btnUpdate", function(){
			var userid = $("#modifyUserid").val();
			var modifyName = $("#modifyUsername").val();
			var modifyPw = $("#modifyUserpw").val();
			var modifyEmail = $("#modifyEmail").val();
			
			var jsonbody = {username: modifyName, userpw: modifyPw, email: modifyEmail};
			
			$.ajax({
				url: "member/" + userid,
				type: "put",
				headers:{
					"Content-Type": "application/json",
					"X-HTTP-Method-Override": "PUT"
				},
				data: JSON.stringify(jsonbody),	
				dataType: "text",
				success: function(json){
					console.log(json);
					
					if(json == "Success"){
						alert("수정되었습니다.");
					}
					
					$("#modifyModal").modal("hide");
					
					//리스트 갱신시킨다.
					getListMember();
				}
			})
		})
		
	})
</script>
</head>
<body>

	<div class="container">
		<h3>REGISTER MEMBER</h3><br>
		
		<form class="form-horizontal">
			<div class="form-group">
				<label class="control-label col-sm-2" for="userid">아이디</label>
				<div class="col-xs-4">
					<input type="text" class="form-control" id="userid" placeholder="Enter id" name="userid">
				</div>
			</div>
			
			<div class="form-group"><label class="control-label col-sm-2" for="username">이름</label>
				<div class="col-xs-4">          
					<input type="text" class="form-control" id="username" placeholder="Enter name" name="username">
				</div>
			</div>
			
			<div class="form-group"><label class="control-label col-sm-2" for="userpw">비밀번호</label>
				<div class="col-xs-4">          
					<input type="password" class="form-control" id="userpw" placeholder="Enter password" name="userpw">
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
		
		<br><br>
		
		<!-- 리스트 들어갈 부분 -->
		<table class="table table-hover" id="t1">
			<tbody id="tablebody"></tbody>
		</table>
		
		<!-- 수정 모달창 -->
		<div class="modal fade" id="modifyModal" role="dialog">
			<div class="modal-dialog">			
            
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
	            	<button type="button" class="close" data-dismiss="modal">&times;</button>
	            	<h4 class="modal-title">MODIFY MEMBER</h4>
            	</div>
            	
				<div class="modal-body">
					<form class="form-horizontal">
					<div class="form-group">
						<label class="control-label col-sm-2" for="modifyUserid">아이디</label>
						<div class="col-xs-8">
							<input type="text" class="form-control" id="modifyUserid" name="modifyUserid" readonly="readonly">
						</div>
					</div>
								
					<div class="form-group">
						<label class="control-label col-sm-2" for="modifyUsername">이름</label>
						<div class="col-xs-8">          
							<input type="text" class="form-control" id="modifyUsername" name="modifyUsername">
						</div>
					</div>
								
					<div class="form-group">
						<label class="control-label col-sm-2" for="modifyUserpw">비밀번호</label>
						<div class="col-xs-8">          
							<input type="text" class="form-control" id="modifyUserpw" name="modifyUserpw">
						</div>
					</div>
								
					<div class="form-group">
						<label class="control-label col-sm-2" for="modifyEmail">이메일</label>
						<div class="col-xs-8">          
							<input type="text" class="form-control" id="modifyEmail" name="modifyEmail">
						</div>
					</div>
					
					</form>
				</div>
				
				<!-- 버튼 -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-modifyuserid="" id="btnUpdate">Modify</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
			      
			</div>
		</div>	<!-- 모달창 끝 -->

	</div>	<!-- 컨테이너 끝 -->

</body>
</html>