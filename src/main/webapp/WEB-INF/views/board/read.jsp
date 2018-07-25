<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../include/header.jsp" %>

	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<div class="box-header with-border">
						<h3 class="box-title">HOME PAGE</h3>
					</div>
					
					<form role="form" method="post">
						<input type="hidden" name="bno" value="${boardVO.bno }">
					</form>
					
					<div class="box-body">
						<div class="form-group">
							<label for="exampleInputEmail1">Title</label>
							<input type="text" name="title" class="form-control" value="${boardVO.title }" readonly>
						</div>
						
						<div class="form-gorup">
							<label for="exampleInputPassword1">Content</label>
							<textarea class="form-control" name="content" rows="3" readonly>${boardVO.content }</textarea>
						</div>
						
						<div class="form-group">
							<label for="exampleInputEmail1">Writer</label>
							<input type="text" name="writer" class="form-control" value="${boardVO.writer }" readonly>
						</div>
					</div>
					
					<div class="box-footer">
						<button type="submit" class="btn btn-warring">Modify</button>
						<button type="submit" class="btn btn-danger">REMOVE</button>
						<button type="submit" class="btn btn-primary">LIST ALL</button>
					</div>
				</div>
			</div>
		</div>
	</section>
	
<%@ include file="../include/footer.jsp" %>

<script>
	var formObj = $("form[role='form']");
	
	$(".btn-warring").on("click", function() {
		formObj.attr("action", "/board/modify");
		formObj.attr("method", "get");
		formObj.submit();
	});
	
	$(".btn-danger").on("click", function() {
		formObj.attr("action", "/board/remove");
		formObj.submit();
	});
	
	$(".btn-primary").on("click", function() {
		self.location = "/board/listAll";
	});
</script>