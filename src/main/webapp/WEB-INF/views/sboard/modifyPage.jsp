<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../include/header.jsp" %>

	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<div class="box-header with-border">
						<h3 class="box-title">HOME PAGE</h3>
					</div>
					
					<form id="modifyForm" role="form" action="modifyPage" method="post">
						<input type="hidden" name="page" value="${cri.page }">
						<input type="hidden" name="perPageNum" value="${cri.perPageNum }">
						<input type="hidden" name="searchType" value="${cri.searchType }">
						<input type="hidden" name="keyword" value="${cri.keyword }">
						
						<div class="box-body">
							<div class="form-group">
								<label for="exampleInputEmail">BNO</label>
								<input type="text" name="bno" class="form-control" value="${boardVO.bno }" readonly>
							</div>
							
							<div class="form-group">
								<label for="exampleInputEmail1">Title</label>
								<input type="text" name="title" class="form-control" value="${boardVO.title }">
							</div>
							
							<div class="form-group">
								<label for="exampleInputPassword1">Content</label>
								<textarea class="form-control" name="content" rows="5">${boardVO.content }</textarea>
							</div>
							
							<div class="form-group">
								<label for="exampleInputEmail1">Writer</label>
								<input type="text" name="writer" class="form-control" value="${boardVO.writer }" readonly>
							</div>
							
							<div class="form-group">
							    <label>File DROP Here</label>
							    <div class="fileDrop"></div>
							</div>							
						</div>
					</form>
					
					<div class="box-footer">
						<div>
						    <hr>
						</div>
						
						<ul class="mailbox-attachments clearfix uploadedList"></ul>					
						<button type="submit" class="btn btn-primary">SAVE</button>
						<button type="submit" class="btn btn-warring">CANCEL</button>
					</div>
				</div>
			</div>
		</div>
	</section>
	
<%@ include file="../include/footer.jsp" %>

<style>
    .fileDrop {
        width: 80%;
        height: 100px;
        border: 1px dotted gray;
        background-color: lightslategray;
        margin: auto;
    }
</style>

<script src="/resources/js/upload.js"></script>

<script id="template" type="text/x-handlebars-template">
    <li>
        <span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment"></span>
        <div class="mailbox-attachment-info">
            <a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
            <a href="{{fullName}}" class="btn btn-default btn-xs pull-right delbtn"><i
                    class="fa fa-fw fa-remove"></i></a>
        </div>
    </li>
</script>

<script>
    let template = Handlebars.compile($("#template").html());

    $(".fileDrop").on("dragenter dragover", (event) => {
        event.preventDefault();
    });

    $(".fileDrop").on("drop", (event) => {
        event.preventDefault();
        let files = event.originalEvent.dataTransfer.files;
        let file = files[0];
        let formData = new FormData();
        formData.append("file", file);

        $.ajax({
            type: "POST",
            url: "/uploadAjax",
            data: formData,
            dataType: "text",
            processData: false,
            contentType: false
        })
            .then((data) => {
                let fileInfo = getFileInfo(data);
                let html = template(fileInfo);
                $(".uploadedList").append(html);
            });
    });

    $("#modifyForm").submit(function(event) {
       event.preventDefault();

       let that = $(this);

       let str = "";

       $(".uploadedList .delbtn").each(function(index) {
          str += "<input type='hidden' name='files[" + index + "]' value='" + $(this).attr("href") + "'>";
       });

       that.append(str);

       that.get(0).submit();
    });
</script>

<script>
	var formObj = $("form[role='form']");
	
	$(".btn-warring").on("click", function() {
		self.location = "/sboard/list?page=${cri.page}&perPageNum=${cri.perPageNum}"
					+ "&searchType=${cri.searchType}&keyword=${cri.keyword}";
	});
	
	$(".btn-primary").on("click", function() {
		formObj.submit();
	});
</script>