<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="../include/header.jsp" %>

<div class="popup back" style="display: none;"></div>
<div id="popup_front" class="popup front" style="display: none;">
    <img id="popup_img">
</div>

<section class="content">
    <div class="row">
        <div class="col-md-12">
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">HOME PAGE</h3>
                </div>

                <form role="form" method="post">
                    <input type="hidden" name="page" value="${cri.page }">
                    <input type="hidden" name="perPageNum" value="${cri.perPageNum }">
                    <input type="hidden" name="bno" value="${boardVO.bno }">
                    <input type="hidden" name="searchType" value="${cri.searchType }">
                    <input type="hidden" name="keyword" value="${cri.keyword }">
                </form>

                <div class="box-body">
                    <div class="form-group">
                        <label for="title">Title</label>
                        <input type="text" id="title" name="title" class="form-control" value="${boardVO.title }"
                               readonly>
                    </div>

                    <div class="form-gorup">
                        <label for="content">Content</label>
                        <textarea class="form-control" id="content" name="content" rows="3"
                                  readonly>${boardVO.content }</textarea>
                    </div>

                    <div class="form-group">
                        <label for="writer">Writer</label>
                        <input type="text" id="writer" name="writer" class="form-control" value="${boardVO.writer }"
                               readonly>
                    </div>
                </div>

                <div class="box-footer">
                    <ul class="mailbox-attachments clearfix uploadedList"></ul>
                    <c:if test="${login.uid == boardVO.writer }">
	                    <button type="submit" class="btn btn-warring modifyBtn">Modify</button>
	                    <button type="submit" class="btn btn-danger removeBtn">REMOVE</button>
                    </c:if>
                    <button type="submit" class="btn btn-primary goListBtn">LIST ALL</button>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="box box-success">
                <div class="box-header">
                    <h3 class="box-title">ADD NEW REPLY</h3>
                </div>

                <c:if test="${not empty login}">
                	<div class="box-body">
	                    <label for="newReplyWriter">Writer</label>
	                    <input class="form-control" type="text" placeholder="USER ID" id="newReplyWriter" value="${login.uid }" readonly/>
	                    <label for="newReplyText">Text</label>
	                    <input class="form-control" type="text" placeholder="REPLY TEXT" id="newReplyText"/>
               		</div>

	                <div class="box-footer">
	                    <button type="submit" class="btn btn-primary" id="replyAddBtn">ADD REPLY</button>
	                </div>
                </c:if>
                
                <c:if test="${empty login}">
                	<div class="box-body">
                		<div>
                			<a href="/user/login">Login Please</a>
                		</div>
                	</div>
                </c:if>
            </div>
        </div>
    </div>

    <ul class="timeline">
        <li class="time-label" id="repliesDiv"><span class="bg-green">Replies List <small
                id="replycntSmall">[ ${boardVO.replycnt} ]</small></span></li>
    </ul>

    <div class="text-center">
        <ul id="pagination" class="pagination pagination-sm no-margin">

        </ul>
    </div>
</section>

<div id="modifyModal" class="modal modal-primary" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title"></h4>
            </div>
            <div class="modal-body" data-rno>
                <p>
                    <input type="text" id="replytext" class="form-control"/>
                </p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-info" id="replyModBtn">Modify</button>
                <button type="button" class="btn btn-danger" id="replyDelBtn">DELETE</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<script id="templateAttach" type="text/x-handlebars-template">
    <li data-src="{{fullName}}">
        <span class="mailbox-attachment-info has-img"><img src="{{imgsrc}}" alt="Attachment"></span>
        <div class="mailbox-attachment-info">
            <a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
        </div>
    </li>
</script>

<script id="template" type="text/x-handlebars-template">
    {{#each .}}
    <li class="replyLi" data-rno={{rno}}>
        <i class="fa fa-comments bg-blue"></i>
        <div class="timeline-item">
                <span class="time">
                    <i class="fa fa-clock-o"></i>{{prettifyDate regdate}}
                </span>
            <h3 class="timeline-header">
                <strong>{{rno}}</strong>-{{replyer}}
            </h3>
            <div class="timeline-body">{{replytext}}</div>
            <div class="timeline-footer">
				{{#eqReplyer replyer}}
                <a class="btn btn-primary btn-xs" data-toggle="modal" data-target="#modifyModal">Modify</a>
				{{/eqReplyer}}
            </div>
        </div>
    </li>
    {{/each}}
</script>

<%@ include file="../include/footer.jsp" %>

<style>
    .popup {position: absolute;}
    .back {background-color: gray; opacity: 0.5; width: 100%; height: 300%; overflow: hidden; z-index: 1101;}
    .front {z-index: 1110; opacity: 1; border: 1px; margin: auto;}
    .show {position: relative; max-width: 1200px; max-height: 800px; overflow: auto;}
</style>

<script src="/resources/js/upload.js"></script>

<script>
    const formObj = $("form[role='form']");
    const template = Handlebars.compile($("#templateAttach").html());
    let bno = ${boardVO.bno};
    let replyPage = 1;

    const printData = (replyArr, target, templateObject) => {
        let template = Handlebars.compile(templateObject.html());

        let html = template(replyArr);
        $('.replyLi').remove();
        target.after(html);
    };

    const getPage = (pageInfo) => {
        $.getJSON(pageInfo)
            .then((data) => {
                printData(data.list, $('#repliesDiv'), $('#template'));
                printPaging(data.pageMaker, $('.pagination'));

                $('#modifyModal').modal('hide');
                $("#replycntSmall").html("[ " + data.pageMaker.totalCount + " ]");
            })
            .fail((err) => {
                console.error(err);
            });
    };

    const printPaging = (pageMaker, target) => {
        let str = "";

        if (pageMaker.prev) {
            str += "<li><a href='" + (pageMaker.startpage - 1) + "'> << </a></li>";
        }

        for (let i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) {
            let strClass = pageMaker.cri.page === i ? 'class=active' : '';
            str += "<li " + strClass + "><a href='" + i + "'>" + i + "</a></li>";
        }

        if (pageMaker.next) {
            str += "<li><a href='" + (pageMaker.endPage + 1) + "'> << </a></li>";
        }

        target.html(str);
    };

    Handlebars.registerHelper("prettifyDate", (timeValue) => {
        let dateObj = new Date(timeValue);
        let year = dateObj.getFullYear();
        let month = dateObj.getMonth() + 1;
        let date = dateObj.getDate();
        return year + "/" + month + "/" + date;
    });
    
    Handlebars.registerHelper("eqReplyer", (replyer, block) => {
        let accum = "";
        if (replyer == "${login.uid}") {
        	accum += block.fn();
        }
        return accum;
    });

    $(".modifyBtn").on("click", () => {
        formObj.attr("action", "/sboard/modifyPage");
        formObj.attr("method", "get");
        formObj.submit();
    });

    $(".removeBtn").on("click", () => {
    	const replyCnt = $("#replycntSmall").html().replace(/[^0~9]/g, "");
    	
    	if (replyCnt > 0) {
    		alert("댓글이 달린 게시물은 삭제할 수 없습니다.");
    		return;
    	}
    	
    	let arr = [];
    	
    	$(".uploadedList li").index(function(index) {
    		arr.push($(this).attr("data-src"));
    	});
    	
    	if (arr.length > 0) {
    		$.post("/deleteAllFiles", {files:arr}, function() {
    			
    		});
    	}
    	
        formObj.attr("action", "/sboard/removePage");
        formObj.submit();
    });

    $(".goListBtn").on("click", () => {
        formObj.attr("method", "get");
        formObj.attr("action", "/sboard/list");
        formObj.submit();
    });

    $('#repliesDiv').on('click', () => {
        if ($('.timeline li').size() > 1) {
            return;
        }

        getPage('/replies/' + bno + '/1');
    });

    $('.pagination').on('click', 'li a', function (event) {
        event.preventDefault();
        replyPage = $(this).attr('href');
        getPage('/replies/' + bno + '/' + replyPage);
    });

    $("#replyAddBtn").on("click", () => {
        let replyerObj = $("#newReplyWriter");
        let replytextObj = $("#newReplyText");
        let replyer = replyerObj.val();
        let replytext = replytextObj.val();

        $.ajax({
            type: "POST",
            url: "/replies",
            headers: {
                "Content-Type": "application/json",
                "X-HTTP-Method-Override": "POST"
            },
            dataType: "text",
            data: JSON.stringify({
                bno: bno,
                replyer: replyer,
                replytext: replytext
            })
        })
            .then((result) => {
                if (result === "success") {
                    alert("등록되었습니다.");
                    replyPage = 1;
                    getPage("/replies/" + bno + '/' + replyPage);
                    replyerObj.val("");
                    replytextObj.val("");
                }
            })
            .fail((err) => {
                console.error(err);
            });
    });

    $(".timeline").on("click", ".replyLi", function (event) {
        let reply = $(this);

        $("#replytext").val(reply.find(".timeline-body").text());
        $(".modal-title").html(reply.attr("data-rno"));
    });

    $("#replyModBtn").on("click", () => {
        let rno = $(".modal-title").html();
        let replytext = $("#replytext").val();

        $.ajax({
            type: "PUT",
            url: "/replies/" + rno,
            headers: {
                "Content-Type": "application/json",
                "X-HTTP-Method-Override": "PUT"
            },
            dataType: "text",
            data: JSON.stringify({
                replytext: replytext
            })
        })
            .then((result) => {
                if (result === "success") {
                    alert("수정 되었습니다.");
                    getPage("/replies/" + bno + "/" + replyPage);
                }
            })
            .fail((err) => {
                console.error(err);
            });
    });

    $("#replyDelBtn").on("click", () => {
        let rno = $(".modal-title").html();
        let replytext = $("#replytext").val();

        $.ajax({
            type: "DELETE",
            url: "/replies/" + rno,
            headers: {
                "Content-Type": "application/json",
                "X-HTTP-Method-Override": "DELETE"
            },
            dataType: "text"
        })
            .then((result) => {
                if (result === "success") {
                    alert("삭제 되었습니다.");
                    getPage("/replies/" + bno + "/" + replyPage);
                }
            })
            .fail((err) => {
                console.error(err);
            });
    });

    $.getJSON("/sboard/getAttach/" + bno, (list) => {
        $(list).each(function () {
            let fileInfo = getFileInfo(this);
            let html = template(fileInfo);
            $(".uploadedList").append(html);
        })
    });

    // 썸네일 이미지 클릭시 원본 이미지 보여줌
    $(".uploadedList").on("click", ".mailbox-attachment-info a", function(event) {
        const fileLink = $(this).attr("href");

        if (checkImageType(fileLink)) {
            event.preventDefault();

            const imgTag = $("#popup_img");
            imgTag.attr("src", fileLink);

            $(".popup").show("slow");
            imgTag.addClass("show");
        }
    });

    // 썸네일 이미지 제거
    $("#popup_img").on("click", function() {
        $(".popup").hide("show");
    });
</script>