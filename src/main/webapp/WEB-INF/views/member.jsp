<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<title>Insert title here</title>
</head>
<body>

	<div class="container">
		<h2>Horizontal form</h2>
		
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
					<button type="submit" class="btn btn-default">Submit</button>
				</div>
			</div>
		</form>
	</div>

</body>
</html>