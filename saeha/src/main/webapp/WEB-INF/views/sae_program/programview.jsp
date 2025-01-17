<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>     
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/css/templatemo-style.css">
     
       <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>프로그램 view</title>
</head>

<script type="text/javascript">

$(document).ready(function(){
	var formObj = $("form[name='readForm']");
	
	//수정
	$(".update_btn").on("click",function(){
		formObj.attr("action","/sae_program/programUpdateView");
		formObj.attr("method","get");
		formObj.submit();
	})
	//삭제
	$(".delete_btn").on("click",function(){
		var deleteYN = confirm("삭제하시겠습니까?");
		if (deleteYN == true) {
			
			formObj.attr("action","/sae_program/programDelete");
			formObj.attr("method","get");
			formObj.submit();
			
		}
	})
	
	//목록
	$(".list_btn").on("click",function(){
		var type = $("#pg_type").val();
		location.href="/sae_program/programlist?pg_type="+type ;
	})
	
	//예약페이지로
	$(".book_btn").on("click", function(){
		formObj.attr("action","/sae_book/bookview");
		formObj.attr("method","get");
		formObj.submit();
		
	})



$('#heart').click(function(e){
		likeupdate(e);
	});
	
	function likeupdate(e){
		var root = getContextPath(),
		likeurl = "/sae_like/likeupdate",
		lk_id = $('#lk_id').val(),
		lk_pno = $('#lk_pno').val(),
		count = $('#likecheck').val(),
		data = {"lk_id" : lk_id,
				"lk_pno" : Number($("#lk_pno").attr("value")),
				"lkcount" : count};
		console.log(data);
	$.ajax({
		url : likeurl,
		type : 'PUT',
		dataType: "json",
        contentType: "application/json; charset=utf-8",
		data : JSON.stringify(data),
		success : function(result){
			console.log("수정" + result.result);
			if(count == 1){
				console.log("좋아요 취소");
				 $('#likecheck').val(0);
				 $('#heart').attr('src','/resources/img/empty.png');
			}else if(count == 0){
				console.log("좋아요!");
				$('#likecheck').val(1);
				$('#heart').attr('src','/resources/img/full.png');
			}
		}, error : function(result){
			console.log("에러" + result.result)
		}
		
		});
	};
	
	function getContextPath() {
	    var hostIndex = location.href.indexOf( location.host ) + location.host.length;
	    return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
	} 
})
</script>
<body>
<%@include file="../include/nav.jsp" %>
<div class="page-content">
<div style="padding:60px 0; height: 100%;">
	<div class="section-heading">
				<h1>
					Ongoing<br>
					<em>Programs</em>
				</h1>
				<p>
					Praesent pellentesque efficitur magna, <br>sed pellentesque
					neque malesuada vitae.
				</p>
	</div>
<form name="readForm" role="form" method="post">
<input type="hidden" id="pg_bno" name="pg_bno" value="${programread.pg_bno}" />
<input type="hidden" id="pg_name" name="pg_name" value="${programread.pg_name}" />
<input type="hidden" id="pg_time" name="pg_time" value="${programread.pg_time}" />
</form>


<div style="padding: 25px;display: flex;border-top: 0.5px solid gray;">
<div style="background-color: orange;width:45%; height: 400px;">
</div>
<div style="width: 5%"></div>
<div style="width:50%;">
<div style="font-size: x-large;"><br><b><input style="border:0 solid black" type="text" id="pg_name" name="pg_name" value="${programread.pg_name}" readonly="readonly" /></b></div><br>
<div style="text-align: right;"><input type="text" id="pg_stock" name="pg_stock" value="${programread.pg_stock}" readonly="readonly" style="border:0 solid black" /> 명 예약가능&nbsp;&nbsp;</div><br>
<div><br>
<textarea id="pg_content" name="pg_content" style="width: 100%; height: 100px;"  readonly="readonly"><c:out value="${programread.pg_content}"/></textarea>
</div><br>
<div style="font-size: 15.5px; padding-bottom: 4px;"><br><input type="text" id="pg_startdate" name="pg_startdate" value="${programread.pg_startdate}" style="border:0 solid black" readonly="readonly" />
 - <input type="text" id="pg_enddate" name="pg_enddate"  value="${programread.pg_enddate}" readonly="readonly"style="border:0 solid black" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="text" id="pg_time" name="pg_time" value="${programread.pg_time}" readonly="readonly"style="border:0 solid black" /> 
<span style="float: right;"><button type="button" >예매하기</button></span>
</div><br>
<c:if test="${member.userId == null}">
<p style="float: right;">예매하시려면 로그인 해주세요!</p>
</c:if>
</div>
</div>



<table>
<tr>
<td id="like">
					<c:choose>
						<c:when test="${lk_bno ==0}">
							<img id="heart" src="/resources/img/empty.png"style="height:40px;" value="${programread.pg_bno}" >
							<input type="hidden" id="likecheck" value="${lk_bno }">
						</c:when>					
						<c:when test="${lk_bno ==1}">
							<img id="heart" src="/resources/img/full.png"style="height:40px;" value="${programread.pg_bno}" >
							<input type="hidden" id="likecheck" value="${lk_bno }">
						</c:when>
					</c:choose>					
				</td>
<!-- <button class="write_btn" type="submit">작성</button> -->
</tr>
</table>
<c:if test = "${member.userId == 'admin' }">
<button type="button" class="update_btn btn btn-warning">수정</button>
<button type="button" class="delete_btn btn btn-danger">삭제</button>
<button type="button" class="list_btn btn btn-primary">목록</button>
</c:if>


<input type="hidden" value="${member.userId }" id="lk_id" name="lk_id" />
<input type="hidden" value="${programread.pg_bno}" id="lk_pno" name="lk_pno" />


<hr />
</div>
</div>
<footer class="footer">
<p>Copyright &copy; 2019 Company Name . Design: TemplateMo</p>
</footer>
</body>
</html>