<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	
	<div>
		<div style="text-align:right" >
			<img src="./resources/ls_img/btn_add.gif" alt="인사서식 추가 버튼" style="cursor:pointer;" onclick="goDocinsert('${userNo}','${mbrAuthVo_Session.user_no}');"/>
		</div>
	</div>
	<div class= "tableStyle2" style="margin-top:5px;">
		<table>
			<thead>
				<tr>
					<th width="15%">구분</th>
					<th width="50%">품의제목</th>
					<th width="10%">확인상태</th>
					<th width="10%">다운로드</th>
					<th width="10%">비고</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${mbrDocList}" var="docVo">
					<tr onMouseOver="this.style.backgroundColor='#FFECEC'" onMouseOut="this.style.backgroundColor=''" style= "cursor:pointer;">
						<!-- 구분 -->
						<td>${docVo.col_val}</td>
						
						<!-- 품의제목-->
						<td>${docVo.doc_title}</td>
						
						<!-- 확인상태 -->
						<c:choose>
							<c:when test="${docVo.doc_state == 0}" >
								<td>미확인</td>
							</c:when>
							<c:when test="${docVo.doc_state == 8}" >
								<td>삭제요청</td>
							</c:when>
							<c:otherwise>
								<td>확인 완료</td>
							</c:otherwise>
						</c:choose>
						
						<!-- 다운로드 -->
						<td>
						<c:if test="${mbrVo_Session.user_no == '966' || mbrVo_Session.user_no == '6' || mbrVo_Session.user_no == '62' || mbrVo_Session.user_no == '670'}">
							<a href="./mbrDocFileDownload?path=${docVo.file_path}&fname=${docVo.file_name}&dstate=${docVo.doc_state}">
								<span class="mark_alarm">다운로드</span>
							</a> 
						</c:if>
						</td>
							
						<!-- 비고 -->
						<td>
<%-- 							<span class="mark_alarm" id="confirmBtn" onclick="docStateChange(${docVo.serial_no},'confirm')"> --%>
<!-- 								<font color="#0000DB">확인</font> -->
<!-- 							</span> -->
							
							<span class="mark_alarm" id="delBtn" onclick="docStateChange(${docVo.serial_no},'delete')">
								<font color="#DB0000">삭제</font>
							</span>
							
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div><!-- //tableStyle2 -->

	<script>
		function goDocinsert(user_no,reg_user_no){
			
			var cw=screen.availWidth;
			var ch=screen.availHeight;
			
			var sw=470; //띄울 창의 넓이
			var sh=320;  //띄울 창의 높이

			var ml=(cw-sw)/2;   //가운데 띄우기위한 창의 x위치
			var mt=(ch-sh)/2;   //가운데 띄우기위한 창의 y위치
			
			window.open("mbrDocInsForm?reg_user_no="+reg_user_no+"&user_no="+user_no,'test','width='+sw+',height='+sh+',top='+mt+',left='+ml+',resizable=no,scrollbars=yes')
		}
		
		function docStateChange(serial_no,flag){
			if (flag == "delete"){
				var r = confirm("해당 내용을 삭제하시겠습니까?");	
			}
			
			if (r == false){
				return;
			}
			
			$.post( "./mbrDocStateChange"
					, {serial_no : serial_no
					  ,flag : flag}
					,function(data,status){
						if(status == "success" && data == 2){ //삭제 요청
							alert("삭제가 완료되었습니다.");
							popMbrDetail.tabGubun.value = "doc";
							popMbrDetail.submit();
						}else{
							alert("잠시 후 다시 시도해 주세요.");
						}
					}
			);
		}
	</script>

