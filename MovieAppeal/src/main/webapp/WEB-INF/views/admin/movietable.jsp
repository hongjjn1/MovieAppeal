<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <div style="margin-top:100px; margin-left:100px;">
    	<div>
    		<table class="table table-striped" >
    			<tr>
    			<td>영화분류번호
    			</td>
    			<td>img
    			</td>
    			<td>영화제목
    			</td>
    			<td>줄거리
    			</td>
    			<td>
    			</td>
    			</tr>
    			<c:forEach var="list" items="${list}">
	    			<tr class = "movieEntity">
		    			<td>${list.m_no}
    						<input type="hidden" class="m_no" value="${list.m_no}">
    					</td>
    					<td><img src="${list.m_imgurl}">
    						<input type="hidden" class="m_imgurl" value="${list.m_imgurl}">    			
    					</td>
    					<td>${list.m_title }
    						<input type="hidden" class="m_title" value="${list.m_title}">
    					</td>
    					<td>${list.m_plot }
    						<input type="hidden" class="m_plot" value="${list.m_plot}">
    						<input type="hidden" class="m_trailerurl" value="${list.m_trailerurl}">
    					</td>
    					<td>
    						<button class="btn btn-primary editBtn" data-toggle="modal" data-target="#editModal" type="button" onclick="movieEdit(this);"><i>수정</i></button>
    						<button class="btn btn-danger" type="button" onclick="movieDelete(this);"><i>삭제</i></button>
    					</td>    			
    				</tr>
    			</c:forEach>    			
    			<tr>
    			<td colspan="5">
    							<ul class="pagination">
					<c:if test="${pageset.firstPage > pageset.pageIndex}">
				    <li>
    				<a href="/administrator/movietable.do?curPage=${pageset.firstPage-pageset.pageIndex}" aria-label="Previous">
        			<span aria-hidden="true">&laquo;</span>
      				</a>
   	 				</li>
   	 				</c:if>
   	 				<c:forEach var="i" begin="${pageset.firstPage}" end="${pageset.lastPage}" step="1">
   	 					<c:choose>
   	 					<c:when test="${i == pageset.nowPage}">
   	 					<li><a class ="nowpage">${i}</a></li>
   	 					</c:when>
   	 					<c:otherwise>
   	 					<li><a href="/administrator/movietable.do?curPage=${i}">${i}</a></li>
   	 					</c:otherwise>
   	 					</c:choose>
   	 				</c:forEach>
					<c:if test="${pageset.firstPage+pageset.pageIndex <= pageset.maxPage}">
   	 				<li>
      					<a href="/administrator/movietable.do?curPage=${pageset.firstPage+pageset.pageIndex}" aria-label="Next">
        				<span aria-hidden="true">&raquo;</span>
      					</a>
    				</li>
    				</c:if>
    			</ul>
    			</td>
    			</tr>
    		</table>
    	</div>
    </div>
    
<div  class="modal" id="editModal"  role="dialog"  aria-hidden="true" >
  <div class="modal-dialog">
    <div class="modal-content"  style="background-color:#464646; color:#fafafa; border-radius:20px; padding: 10px; z-index:30000px; ">
      <div class="modal-body">
        <div>
			<div >
				<div class="card-title" style="margin-top:30px;">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h2 class="card-title text-center" style="align:left; color:#fafafa;"id="titleArea">영화제목 : </h2>
				</div>
				<div class="card-body" id="modal-form-wrap">
    				<form class="form-horizontal form-signin" method="POST" >
        				<h5 class="form-signin-heading" id="m_no">영화관리번호 : </h5>
        				<input type="hidden" id="hide_m_no">
        				<div class="form-group">
        				<label for="m_imgurl" class="control-label">포스터 URL</label>
        				<input type="text" id="m_imgurl" class="form-control" placeholder="imgUrl" required autofocus>
        				<label for="m_imgurl" class="control-label">예고편 URL</label>
        				<input type="text" id="m_trailerurl" class="form-control" placeholder="trailerUrl" required autofocus>
        				</div>
        				<div class="form-group">
        				<label for="m_plot" class="control-label">줄거리</label>
        				<textarea id="m_plot" class="form-control" placeholder="줄거리" required></textarea>      	  				<br>
        				</div>
        				<div class="form-group" align="center">
        				<button id="btn-edit" class="btn btn-default" type="button">수 정</button>
        				<button id="btn-cancel" class="btn btn-danger close" data-dismiss="modal" type="button">취 소</button>
        				</div>
     				</form>
     				<div>
     					<h6>movie photoadder</h6>
     					<div>
     						<form id="img_file_upload" action="/administrator/movieimgupload.do" method="post"  enctype="multipart/form-data" >
     							<div class="input-group">
     								<label for="file_input" class="control-label">이미지첨부</label>
     								<input id="m_image" type="file" name="multi" class="form-control" placeholder="imageonly">
     								<span class="input-group-btn">
      					 				<button id="imageadd-btn" class="btn btn-default" type="button">등록</button>
     				 				</span>
     				 				<input type="hidden" name="m_no" id="file_m_no">
		     					</div>
     						</form>
     						<div>
     							<ul id="img_list">
     							</ul>
     						</div>
     					</div>
     				</div>
				</div>
			</div>
      </div>
    </div>
  </div>
</div>
</div>	
<script type="text/javascript">

	$(function(){
		$('#imageadd-btn').click(function(){
			$('#file_m_no').val($(this).parents('#modal-form-wrap').find('#hide_m_no').val());
			var form = document.getElementById('img_file_upload');
			var formData = new FormData(form);
			formData.append("file",$('#m_image'));
	        $.ajax({
	            async: true,
	            type : 'POST',
	            data : formData,
	            url : "/administrator/movieimgupload.do",
	            processData : false,
	            contentType: false,
	            dataType : "json",
//	            contentType: "application/json; charset=UTF-8",
	            success : function(json) {
	            	alert(json.data);
	            	var a = json.data
	            	switch(a){
	            	case "파일업로드 성공" : {
	            		 
	            			var m_no = $('#file_m_no').val();
	            			imglistexpress(m_no);
	        		 break;
	            	}
	            		
	            	}
	            },
	            error : function(error) {		                
	                alert("10Mb 이하만 이미지파일만 업로드가능합니다.");
	            }
	        });
			
			//$this.parents('.input-group').children('#m_image');
			
		});
	});
	
/* 	function fileExtendcheck(name){
		var ext = name.substring		
	}
 */
 
	function imglistexpress(m){
	 
		var m_no = m;
		$.ajax({
            async: true,
            type : 'POST',
            data : JSON.stringify({
            	'm_no' : m_no,
             }),
            url : "/administrator/movieimglist.do",
            dataType : "json",
            contentType: "application/json; charset=UTF-8",
            success : function(data) {
            	if(data.cnt > 0 ){
        			$('#img_list').text("");
            		$.each(data.list, function(idx, val) {
	            		$('#img_list').append('<li>');
	            		$('#img_list').append('<a href="/upload/movie/'+val.storage_fileNm+'">'+val.storage_fileNm+'</a>');
	            		$('#img_list').append('<input type="hidden" value="'+val.mi_no+'" >');
						$('#img_list').append('<button type="button" class="img_delete_btn btn btn-danger"> 삭제 </button>');
	            		$('#img_list').append('</li>');
            		});
            	}
            	else{
        			$('#img_list').text("");
            		$('#img_list').append('<li> 등록된 이미지 데이터가 없습니다');
            		$('#img_list').append('</li>');
            	}
            },
            error : function(error) {		                
                alert("error : " + error);
            }
        });	 
 } 
 
 
	function movieEdit(btn){
		var m_no = $(btn).parents('.movieEntity').children().children('.m_no').val();
		var m_title = $(btn).parents('.movieEntity').children().children('.m_title').val();
		var m_imgurl = $(btn).parents('.movieEntity').children().children('.m_imgurl').val();
		var m_plot = $(btn).parents('.movieEntity').children().children('.m_plot').val();
		var m_trailerurl = $(btn).parents('.movieEntity').children().children('.m_trailerurl').val();
			$('#hide_m_no').val(m_no);
			imglistexpress(m_no);	
			m_no = '영화관리번호 : '+m_no;
			$('#m_no').text(m_no);
			$('#titleArea').text('영화제목 :'+m_title);
			$('#m_imgurl').val(m_imgurl);
			$('#m_plot').val(m_plot);
			$('#m_trailerurl').val(m_trailerurl);
	}
	
	function movieDelete(btn){
		var m_no = $(btn).parents('.movieEntity').children().children('.m_no').val();
		if(confirm("정말 삭제하시겠습니까??") == true){
	        $.ajax({
	            async: true,
	            type : 'POST',
	            data : JSON.stringify({
	            	'm_no' : m_no,
	             }),
	            url : "/administrator/moviedelete.do",
	            dataType : "json",
	            contentType: "application/json; charset=UTF-8",
	            success : function(data) {
	            	if(data.msg == "OK"){
	            		location.reload();
	            	}
	            	else{
	            		alert("삭제실패");
	            		location.reload();
	            	}
	            },
	            error : function(error) {		                
	                alert("error : " + error);
	            }
	        });
		}		
	}
	
	$(function(){
		$('#btn-edit').click(function(){
			var m_no = $('#hide_m_no').val();
			var m_imgurl = $('#m_imgurl').val();
			var m_plot = $('#m_plot').val();
			var m_trailerurl = $('#m_trailerurl').val();
			alert(m_no+m_imgurl+m_plot);
		        $.ajax({
		            async: true,
		            type : 'POST',
		            data : JSON.stringify({
		            	'm_no' : m_no,
		            	'm_imgurl' : m_imgurl,
		            	'm_plot' : m_plot,
		            	'm_trailerurl' : m_trailerurl
		             }),
		            url : "/administrator/movieedit.do",
		            dataType : "json",
		            contentType: "application/json; charset=UTF-8",
		            success : function(data) {
		            	if(data.msg == "OK"){
		            		location.reload();
		            	}
		            	else{
		            		alert("수정실패");
		            		location.reload();
		            	}
		            },
		            error : function(error) {		                
		                alert("error : " + error);
		            }
		        });
			
		});
	});

</script>