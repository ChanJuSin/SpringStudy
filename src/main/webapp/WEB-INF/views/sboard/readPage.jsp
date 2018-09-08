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
						<input type="hidden" name="page" value="${cri.page }">
						<input type="hidden" name="perPageNum" value="${cri.perPageNum }">
						<input type="hidden" name="bno" value="${boardVO.bno }">
						<input type="hidden" name="searchType" value="${cri.searchType }">
						<input type="hidden" name="keyword" value="${cri.keyword }">
					</form>
					
					<div class="box-body">
						<div class="form-group">
							<label for="title">Title</label>
							<input type="text" id="title" name="title" class="form-control" value="${boardVO.title }" readonly>
						</div>
						
						<div class="form-gorup">
							<label for="content">Content</label>
							<textarea class="form-control" id="content" name="content" rows="3" readonly>${boardVO.content }</textarea>
						</div>
						
						<div class="form-group">
							<label for="writer">Writer</label>
							<input type="text" id="writer" name="writer" class="form-control" value="${boardVO.writer }" readonly>
						</div>
					</div>
					
					<div class="box-footer">
						<button type="submit" class="btn btn-warring modifyBtn">Modify</button>
						<button type="submit" class="btn btn-danger removeBtn">REMOVE</button>
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

					<div class="box-body">
						<label for="newReplyWriter">Writer</label>
						<input class="form-control" type="text" placeholder="USER ID" id="newReplyWriter" />
						<label for="newReplyText">Text</label>
						<input class="form-control" type="text" placeholder="REPLY TEXT" id="newReplyText" />
					</div>

					<div class="box-footer">
						<button type="submit" class="btn btn-primary" id="replyAddBtn">ADD REPLY</button>
					</div>
				</div>
			</div>
		</div>

		<ul class="timeline">
			<li class="time-label" id="repliesDiv"><span class="bg-green">Replies List</span></li>
		</ul>

		<div class="text-center">
			<ul id="pagination" class="pagination pagination-sm no-margin">

			</ul>
		</div>
	</section>

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
                    <a class="btn btn-primary btn-xs" data-toggle="modal" data-target="#modifyModal">Modify</a>
                </div>
            </div>
        </li>
    {{/each}}
    </script>
	
<%@ include file="../include/footer.jsp" %>

<script>
	const formObj = $("form[role='form']");
    let bno = ${boardVO.bno};
    let replyPage = 1;

    const prinfData = (replyArr, target, templateObject) => {
        let template = Handlebars.compile(templateObject.html());

        let html = template(replyArr);
        $('.replyLi').remove();
        target.after(html);
    };

    const getPage = (pageInfo) => {
        $.getJSON(pageInfo)
            .then((data) => {
                prinfData(data.list, $('#repliesDiv'), $('#template'));
                printPaging(data.pageMaker, $('.pagination'));

                $('#modifyModal').modal('hide');
            })
            .fail((err) => {
                console.log(`댓글 조회 오류 : ${err}`);
            });
    };

    const printPaging = (pageMaker, target) => {
        console.dir(pageMaker);
        console.log(target);
        console.log('페이징 처리 함수 호출');
        let str = '';

        if (pageMaker.prev) {
            str += '<li><a href=' + (pageMaker.startPage - 1) + '> << </a></li>';
        }

        for (let i = pagemaker.startPage, len = pageMaker.endPage; i <= len; i++) {
            let strClass = pageMaker.cri.page === i ? 'class=active':'';
            str += '<li' + strClass + '><a href=' + i + '>'+ i +'</a></li>';
        }

        if (pageMaker.next) {
            str += '<li><a href=' + (pageMaker.endPage + 1) + '> >> </a></li>';
        }

        target.html(str);
        console.log('페이징 처리 함수 호출 끝');
    };

    Handlebars.registerHelper("prettifyDate", (timeValue) => {
        let dateObj = new Date(timeValue);
        let year = dateObj.getFullYear();
        let month = dateObj.getMonth() + 1;
        let date = dateObj.getDate();
        return year + "/" + month + "/" + date;
    });

    $(".modifyBtn").on("click", () => {
        formObj.attr("action", "/sboard/modifyPage");
        formObj.attr("method", "get");
        formObj.submit();
    });

    $(".removeBtn").on("click", () => {
        formObj.attr("action", "/sboard/removePage");
        formObj.submit();
    });

    $(".goListBtn").on("click", () => {
        formObj.attr("method", "get");
        formObj.attr("action", "/sboard/list");
        formObj.submit();
    });

    $('#repliesDiv').on('click', () => {
        if ($('.timeline li').size() > 1)  {
            console.log('이미 댓글 목록이 로드되었습니다.');
            return;
        }

        getPage('/replies/' + bno + '/1');
    });

    $('.pagination').on('click', 'li a', function(event) {
        event.preventDefault();
        replyPage = $(this).attr('href');
        getPage('/replies/' + bno + '/' + replyPage);
    });
</script>