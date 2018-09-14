<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="../include/header.jsp" %>

<section class="content">
    <div class="row">
        <div class="col-md-12">
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">HOME PAGE</h3>
                </div>

                <form id="registerForm" role="form" method="post">
                    <div class="box-body">
                        <div class="form-group">
                            <label for="title">Title</label>
                            <input type="text" id="title" name="title" class="form-control" placeholder="Enter Title">
                        </div>

                        <div class="form-group">
                            <label for="content">Content</label>
                            <textarea class="form-control" id="content" name="content" rows="3"
                                      placeholder="Enter ..."></textarea>
                        </div>

                        <div class="form-group">
                            <label for="writer">Writer</label>
                            <input type="text" id="writer" name="writer" class="form-control" value="${login.uid }" placeholder="Enter Writer" readonly>
                        </div>

                        <div class="form-group">
                            <label>File DROP Here</label>
                            <div class="fileDrop"></div>
                        </div>
                    </div>

                    <div class="box-footer">
                        <div>
                            <hr>
                        </div>

                        <ul class="mailbox-attachments clearfix uploadedList"></ul>

                        <button type="submit" class="btn btn-primary">Submit</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>

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

    $("#registerForm").submit(function(event) {
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

<%@ include file="../include/footer.jsp" %>