<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"
	isELIgnored="false"%>


<jsp:include page="../layout/header.jsp"></jsp:include>
<link
	href="${pageContext.request.contextPath }/resources/css/styleBoard_230407.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath }/resources/css/clubget.css"
	rel="stylesheet">
<style>
	.ck.ck-content {
		min-height: 300px;
		max-height : 500px;
	}
	.board-btnbox li {
		padding-right : 9px; 
		padding-left : 9px ;
	}
	.board-btnbox li a {
		font-size: 20px;
		color : #b1b1b1;
	}
	.board-btnbox li a:hover {
		color: #fdb2b5;
	}
	.feed-main {
		display: flex !important;
	    flex-direction: row;
	    flex-wrap: wrap;
	    justify-content: center;
	}
	.text-red {
		color: red;
	}

</style>


<div class="feed-main">

	<div class="col-7 feeds d-flex flex-column align-items-center" style="width: 600px">
		<div class="myfeed h-100">
		<!----------------------------- 비밀모임 조건문 Start --------------------------->
		<!-- 비밀 모임인 경우 -->
		<c:if test="${club.status }">
			<!-- 비밀 모임의 모임 멤버인 경우를 가리기 위해 변수 생성 -->		
			<c:set var="private_state" value="true" />
			<!-- 비밀 모임 멤버인 경우 피드 확인 가능 -->
			<c:forEach var="clubmember" items="${clubmembers }" >
				<c:if test="${clubmember.member == member.email }">
					<c:set var="private_state" value="false" />
		
					<!-- 검색창 -->
					<div class="input-group myboard club-search">
						<input class="club-search-input" type="text"
							placeholder="글 내용, #태그, @작성자 검색" /> <i class="fas fa-search"></i>
					</div>
					<!-- 모임 글 쓰기 -->
					<div class="myboard club-write">
						<p>새로운 소식을 남겨보세요.</p>
						<ul class="club-board-btnbox">
							<li><a><i class="far fa-heart"></i></a></li>
							<li><a><i class="far fa-heart"></i></a></li>
							<li><a><i class="far fa-heart"></i></a></li>
							<li><a><i class="far fa-heart"></i></a></li>
							<li><a><i class="far fa-heart"></i></a></li>
							<li><a><i class="far fa-heart"></i></a></li>
							<li><a><i class="far fa-heart"></i></a></li>
							<li><a><i class="far fa-comment"></i></a></li>
						</ul>
					</div>
					<!-- 모임 공지사항 -->
					<div class="myboard club-notice">
						<a>
							<h6 class="notice-info ps-3 pt-2" style="color: #757575">
								공지사항
								<span class="notice-num me-3">0</span>
							</h6>
						</a>
						<!-- 공지사항 작업 필요! -->
						<c:if test="true">
							<div class="notice-info ps-4 my-2 mb-3" style="color:#b1b1b1">우리 모임에 어떤 이슈가 있나요?</div>
						</c:if>
						<c:if test="flase">
							<a><div class="notice-info ps-3 my-2">[공지] 메이플 정모 있어요 화요일8시</div></a> 
							<a><div class="notice-info ps-3 my-2">[공지] 메이플 정모 있어요 화요일8시</div></a> 
							<a><div class="notice-info ps-3 my-2">[공지] 메이플 정모 있어요 화요일8시</div></a> 
							<a><div class="notice-info ps-3 my-2">[공지] 메이플 정모 있어요 화요일8시</div></a> 
						</c:if> 
					</div>
					<!-- 모임 글 목록 -->
					<div class="clubfeed">
					</div>
				</c:if>
			</c:forEach>
			
			<!-- 비밀 모임의 멤버가 아닌 경우 (변수로 구별) -->
			<c:if test="${private_state }">

				<div class="d-flex" style="margin-top: 270px">
					<i class="fas fa-lock" style="font-size: 100px;color: #c0cabf;"></i>
				</div>
			</c:if>
		</c:if>
		
		
		<!-- 비밀모임이 아닌 경우 글 전체 공개 -->
		<c:if test="${!club.status}">		
					<!-- 검색창 -->
					<div class="input-group myboard club-search">
						<input class="club-search-input" type="text"
							placeholder="글 내용, #태그, @작성자 검색" /> <i class="fas fa-search"></i>
					</div>
					
			<c:forEach var="clubmember" items="${clubmembers }">
				<c:if test="${clubmember.member == member.email }">
					<!-- 모임 글 쓰기 -->
					<div class="myboard club-write">
						<p>새로운 소식을 남겨보세요.</p>
						<ul class="club-board-btnbox">
							<li><a><i class="far fa-heart"></i></a></li>
							<li><a><i class="far fa-heart"></i></a></li>
							<li><a><i class="far fa-heart"></i></a></li>
							<li><a><i class="far fa-heart"></i></a></li>
							<li><a><i class="far fa-heart"></i></a></li>
							<li><a><i class="far fa-heart"></i></a></li>
							<li><a><i class="far fa-heart"></i></a></li>
							<li><a><i class="far fa-comment"></i></a></li>
						</ul>
					</div>
				</c:if>
			</c:forEach>					
					<!-- 모임 공지사항 -->
					<div class="myboard club-notice">
						<a>
							<h6 class="notice-info ps-3 pt-2" style="color: #757575">
								공지사항
								<span class="notice-num me-3">0</span>
							</h6>
						</a>
						<!-- 공지사항 작업 필요! -->
						<c:if test="true">
							<div class="notice-info ps-4 my-2 mb-3" style="color:#b1b1b1">우리 모임에 어떤 이슈가 있나요?</div>
						</c:if>
						<c:if test="flase">
							<a><div class="notice-info ps-3 my-2">[공지] 메이플 정모 있어요 화요일8시</div></a> 
							<a><div class="notice-info ps-3 my-2">[공지] 메이플 정모 있어요 화요일8시</div></a> 
							<a><div class="notice-info ps-3 my-2">[공지] 메이플 정모 있어요 화요일8시</div></a> 
							<a><div class="notice-info ps-3 my-2">[공지] 메이플 정모 있어요 화요일8시</div></a> 
						</c:if> 
					</div>
					<!-- 모임 글 목록 -->
					<div class="clubfeed">
					</div>		
		
		
		</c:if>
		<!----------------------------- 비밀모임 조건문 End --------------------------->	
		</div>
	</div>


	<div class="col-5 myinfo thisclub myinfo_moblie mt-5">
		<div class="cardbox-header" style="position: relative">
			<div class="media"
				style="flex-direction: column; align-items: stretch">
				<div class="d-flex club-profile-img" data-cno="${club.cno }" data-img="${club.attaches[0]}">
 					<div class="rounded-circle  d-flex justify-content-center align-items-center overflow-hidden" 
					style="background-color:#dedede; position: absolute; right: -9px; top: 0; width:60px; height:60px">
					<!-- 프사가 있는 경우 -->
					<c:if test="${not empty club.attaches[0].uuid}">
  					<img class="thisclub-img info-img"
						style="position: absolute; top: 0; background-color: white;"
						src="${pageContext.request.contextPath }/display?name=${club.attaches[0]['name']}&path=${club.attaches[0]['path']}&uuid=${club.attaches[0]['uuid']}&image=${club.attaches[0]['image']}&thumb=on"
						alt="Image">	
					</c:if>
					<!-- 프사가 없는 경우 -->
					<c:if test="${empty club.attaches[0].uuid}">
						<i class="fas fa-user pt-3" style="font-size: 50px; color: white"></i>
					</c:if>
					</div> 
				</div>
				<div class="thisclub-profile mt-3">
					<a class="clubinfo" style="color: #757575;"> <span
						class="m-0 fw-bold clubName" style="max-width: 120px; display: block;">${club.cname}</span>
						<p class="my-2 mb-4 small clubIntro me-5">${club.intro}</p>
					</a>
					<p class="float-start m-0 small clubTown" style="cursor: pointer">
						<c:if test="${club.town != null}">
							<i class="fas fa-map-marker-alt pe-2"></i>
						</c:if><span>${club.town}</span>
					</p>
					<p class="m-0 small float-end clubMemberCnt" style="cursor: pointer">
						멤버 <span>${club.membercnt == 0 ? 1 : club.membercnt}</span>
					</p>
					<button class="my-2 clubinfo-button join-club">가입하기</button>
				</div>
				<div class="mt-2 pt-2 float-end thisclub-tag"
					style="border-top: #b1b1b1 solid 1px;">
					<a><span>#더조은</span></a> <a><span>#풀스택</span></a> <a><span>#JAVA</span></a> 
					<a><span>#HTML</span></a><a><span>#CSS</span></a> <a><span>#JAVASCRIPT</span></a> 
					<a><span>#DATABASE</span></a> <a><span>#JSP/SERVLET</span></a> <a><span>#AWS</span></a>
					<a><span>#SPRING</span></a>
				</div>
			</div>
		</div>
	</div>

	<!-- 모임 글쓰기 모달 Start -->
	<div class="modal fade" id="clubwrite-modal" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-lg"
			role="document">
			<div class="modal-content"
				style="flex-direction: row; flex-wrap: wrap; border-radius: 10px;">
				<div class="col-12" style="height: 38px">
					<a> <i class="fas fa-arrow-left float-start pt-2"
						style="font-size: 22px; padding-left: 10px"></i>
					</a> <a id="clubBoardReg" class="float-end"
						style="padding: 8px 12px 0">공유하기</a>
				</div>

				<div class="col-12 d-flex flex-column">
					<div class="media p-3">
						<div class="d-flex">
							<a href=""> <img class="write-img"
								src="${pageContext.request.contextPath }/resources/img/attach.jpg">
							</a>
						</div>
						<div class="media-body" style="padding-top: 2px">
							<span class="">${member.id}</span>
						</div>
					</div>
					<div>
						<textarea id="clubBoardContent" data-text="${board.bno }${club.cno}" placeholder="소소한 이야기를 담아보세요">${board.content }</textarea>
					</div>
					<div class="col-12 d-flex flex-column" style="height:40px">
<!-- 						<div class="write-option" style="height:50px;  ">
							<span class=" float-start px-3" style="padding-top: 12px;">위치 추가</span><i
								class="fas fa-map-marker-alt float-end p-3 pe-4"
								></i>
						</div>
						<div class="write-option"  style="height:50px">
							<span class=" float-start px-3"  style="padding-top: 12px;">태그 추가</span><i
								class="fas fa-hashtag float-end p-3 pe-4" ></i>
						</div>
						<label id="imgInsert" class="write-option w-100"  style="height:50px">
								<span class="float-start px-3"  style="padding-top: 12px;">첨부 파일</span><i
									class="fas fa-folder-plus float-end p-3 pe-4"
									></i>
						</label>
						<input type="file" class="form-control"  id="file" name="file" style="display:none" readonly> -->
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 모임 글쓰기 모달 End -->


	<!-- 모임 글 수정하기 모달 Start -->
	<div class="modal fade" id="clubboard-modify-modal" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-lg"
			role="document">
			<div class="modal-content"
				style="flex-direction: row; flex-wrap: wrap; border-radius: 10px;">
				<div class="col-12" style="height: 38px">
					<a> <i class="fas fa-arrow-left float-start pt-2"
						style="font-size: 22px; padding-left: 10px"></i>
					</a> <a id="clubBoardModifyBtn" class="float-end"
						style="padding: 8px 12px 0">수정하기</a>
				</div>

				<div class="col-12 d-flex flex-column">
					<div class="media p-3">
						<div class="d-flex">
							<a href=""> <img class="write-img"
								src="${pageContext.request.contextPath }/resources/img/attach.jpg">
							</a>
						</div>
						<div class="media-body" style="padding-top: 2px">
							<span class="">${member.id}</span>
						</div>
					</div>
					<div>
						<textarea id="clubBoardModifyCon" placeholder="소소한 이야기를 담아보세요"></textarea>
					</div>
 					<div class="col-12 d-flex flex-column" style="height:40px">
<!-- 						<div class="write-option" style="height:50px;  ">
							<span class=" float-start px-3" style="padding-top: 12px;">위치 추가</span><i
								class="fas fa-map-marker-alt float-end p-3 pe-4"
								></i>
						</div>
						<div class="write-option"  style="height:50px">
							<span class=" float-start px-3"  style="padding-top: 12px;">태그 추가</span><i
								class="fas fa-hashtag float-end p-3 pe-4" ></i>
						</div>
						<label id="imgInsert" for="file" class="write-option w-100"  style="height:50px">
								<span class="float-start px-3"  style="padding-top: 12px;">첨부 파일</span><i
									class="fas fa-folder-plus float-end p-3 pe-4"
									></i>
						</label>
						<input type="file" class="form-control"  id="file" name="file" style="display:none" readonly> -->
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 모임 글 수정하기 모달 End -->
	
	
	<!-- 모임 글 자세히 보기 + 댓글 모달 Start -->
	<div class="modal fade" id="ClubboardModal" tabindex="-1"
		 role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" style="min-width:700px"
			 role="document">
			<div class="modal-content" style="min-width: 700px; flex-direction: row; flex-wrap: wrap; border-radius: 10px;">
				<!-- 글 자세히보기 상단 탭 -->
				<div class="col-12 border-bottom" style="height:38px">
					<a>
						<i class="fas fa-arrow-left float-start pt-2" style="font-size: 22px; padding-left:10px"></i>
					</a>
				</div>
				<!-- 글 정보 -->
				<div class="col-7 border-end">
					<!-- 이미지 처리 수정 필요 -->
					<c:if test="false">
					<div class="col-12">
						<img id="detailImage" class="img-fluid" src=""
							 alt="Image" style="width: auto; height: 100%; max-height: 587.5px; object-fit: cover">
					</div>
					</c:if>
					
					
					
					<!-- 글 작성자 정보 -->
					<div class="media p-3 col-12">
						<div class="d-flex">
							<a href="">
								<img class="write-img" src="${pageContext.request.contextPath }/resources/img/attach.jpg">
							</a>
						</div>
						<div class="media-body" style="padding-top: 2px;">
							<span class="" id="writer"></span>
						</div>
					</div>
					<!-- 글 내용 -->	
					<div class="py-3 px-4 col-12" style="border-bottom: 0; height: 300px; overflow-y: auto;" id="content">
					</div>
					<!-- 좋아요 개수 --> 
					<p class="p-3 col-12 m-0 mt-auto" style="font-size:13px; color:#2b2b2b">좋아요 <span id="likeCnt"></span>개</p>
				</div>
				<div class="col-5 d-flex flex-column">	
					<!-- 댓글 모아보기 -->
					<div class="modalscroll mb-auto" style="position: relative;">
						<ul class="list-group chat" style=" height: 341px;
														    overflow-y: auto;
														    overflow-x: hidden;
														">
						</ul>
<!-- 					<a class="icn-more" style="position: absolute; right: 0; padding: 10px 25px"><i class="fas fa-plus-circle"></i></a>
							<!-- <li class="list-group-item" style="border:0px solid"></li>  -->
					</div>
				<!-- 댓글달기 -->
				<div class="p-3 col-12 d-flex flex-row border-top" id="modalFooter">
					  <div class="col-9 p-0 m-0 d-flex ">
					    <input type="text" class="reply-add reply-modify p-0" style="width: 100%;" id="reply" placeholder="댓글 달기..">
					  </div>
					  <div class="col-3 m-0" style="text-align: right;">
					    <button class="btn btn-link" type="button">등록</button>
					  </div>
				</div>
				</div>
			</div>
		</div>
	</div>	
	<!-- 모임 글 자세히 보기 모달 End -->



	<!-- 모임 가입하기 모달 Start -->
	<div class="modal fade" id="joinClub-modal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-lg"
			style="width: 400px;" role="document">
			<div class="modal-content"
				style="flex-direction: row; flex-wrap: wrap; border-radius: 10px;">
				<div class="col-12 join-title my-2" style="font-size: 20px">${club.cname }</div>
				<c:if test="${not empty club.question}">				
				<div class="px-3 py-2 mx-2 join-title" style="width: 100%">
				가입질문에 답해주세요
				</div>
				<div class="col-12" style="text-align: center;">
					<div class="my-2 ms-4 py-2 float-start">
						<span>Q . ${club.question}</span>
					</div>
					<textarea class="p-2 col-10" id="clubAnswer"
						style="background-color: #f0f0f066; border: #b1b1b1 solid 1px; height: 100px"
						placeholder="답변을 작성해 주세요"></textarea>
				</div>
				</c:if>
				<div class="col-12 my-3 mb-4" style="text-align: center">
					<div class="col-2 me-4 btn join-btn">취소</div>
					<div class="col-2 btn join-btn">가입</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 모임 가입하기 모달 End -->

	<!-- 모임 정보 수정하기 모달 Start -->
	<div class="modal fade" id="modifyclub-modal" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-lg" style="width: 700px;"
			role="document">
			<div class="modal-content p-3" style="flex-direction: row; flex-wrap: wrap; border-radius: 10px;">
				<div class="col-12 px-3 py-2 fw-bold" style="color:#2b2b2b;">
					<i class="fas fa-seedling pe-2"></i>모임 수정하기
				</div>
				<div class="col-10 m-auto d-flex flex-row flex-wrap" > <!-- 기존의 form 위치. id 필요? -->
					<div class="col-12 h-25 my-4 d-flex flex-column align-items-start">
						<label class="" for="updatecname">모임 이름</label>
						<input class="col-12 h-75 p-2 border-0 border-bottom" type="text" id="updatecname" name="updatecname" value="${club.cname }">
					</div>
					<label for="clubProfileAttach" class="col-6">
					<!-- 모임 프로필 사진 -->
	 					<div class="club-attach bg-light mb-4 d-flex justify-content-center align-items-center overflow-hidden" 
						style="max-width:280px ; height: 280px; cursor:pointer">
							<!-- 프사가 있는 경우 -->
							<c:if test="${not empty club.attaches[0].uuid}">
		  					<img class="thisclub-img info-img"
								src="${pageContext.request.contextPath }/display?name=${club.attaches[0]['name']}&path=${club.attaches[0]['path']}&uuid=${club.attaches[0]['uuid']}&image=${club.attaches[0]['image']}&thumb=on"
								alt="Image">	
							</c:if>
							<!-- 프사가 없는 경우 -->
							<c:if test="${empty club.attaches[0].uuid}">
								<i class="fas fa-image fs-3"></i>
							</c:if>
						</div> 					
					
					</label>
					<input type="file" id="clubProfileAttach" style="display : none">
					
					<div class="col-6 d-flex flex-column p-3 ps-4 pt-0 align-items-start">
						<label class="py-2 col-12" for="updateintro">모임 소개</label>
						<textarea class="h-25 border col-12 p-2" id="updateintro" name="updateintro">${club.intro }</textarea>
						<label class="py-2 col-12" for="updatetown">모임 동네</label>
						<input class="border col-12 py-1 px-2" type="text" id="updatetown" name="updatetown" value="${club.town }">
						<label class="py-2 col-12" for="updateQuestion">모임 가입 질문</label>
						<input class="border col-12 py-1 px-2" type="text" id="updateQuestion" name="updateQuestion" value="${club.question }">
						<div class="col-12 py-2 mt-2 d-flex align-items-center justify-content-end">
							<label class="py-2 pe-2" for="updatestatus">비밀 모임 설정</label>
							<input class="pt-1" type="checkbox" id="updatestatus" name="updatestatus" style="width:16px; height:16px;"
							${club.status ? 'checked': '' }>
						</div>
						<input type="hidden" value="{club.cleader}" id="updatecleader" name="updatecleader">
					</div>
					<div class="col-12 d-flex justify-content-end py-1 mb-3">
						<button class="p-2 px-3 btn border-0 bg-light modifyClubBtn">수정하기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 모임 정보 수정하기 모달 End -->




	<!-- 모임 정보 자세히 보기 모달 Start -->
	<div class="modal fade" id="clubinfo-modal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-lg"
			style="width: 400px;" role="document">
			<div class="modal-content h-100"
				style="flex-direction: row; flex-wrap: wrap; border-radius: 10px;">
				<div class="media p-4"
					style="flex-direction: column; align-items: stretch">
					<div class="d-flex justify-content-center">
					<!-- 프로필 사진 -->
		 				<div class="my-3 rounded-circle d-flex justify-content-center align-items-center border overflow-hidden" 
							style="background-color:#dedede; width:190px; height:190px">
							<!-- 프사가 있는 경우 -->
							<c:if test="${not empty club.attaches[0].uuid}">
		  					<img class="info-img bg-white"
								style="width:190px; height:190px"
								src="${pageContext.request.contextPath }/display?name=${club.attaches[0]['name']}&path=${club.attaches[0]['path']}&uuid=${club.attaches[0]['uuid']}&image=${club.attaches[0]['image']}&thumb=on"
								alt="Image">	
							</c:if>
							<!-- 프사가 없는 경우 -->
							<c:if test="${empty club.attaches[0].uuid}">
								<i class="fas fa-user pt-5" style="font-size: 170px; color: white"></i>
							</c:if>
						</div>
					</div>
					<div class="thisclub-profile mt-3">
						<a class="clubinfo" style="color: #757575;"> 
						<span class="m-0 fw-bold">${club.cname }  <%-- ( <span>${moment(club.regdate).fromNow()} ~ ing</span> ) --%> </span>
							<p class="my-2 small">${club.intro }</p>
						</a>
						<p class="float-start m-0 small" style="cursor: pointer">
							<i class="fas fa-map-marker-alt pe-2"></i>${club.town }
						</p>
						<p class="m-0 small float-end" style="cursor: pointer">
							멤버 <span>${club.membercnt }</span> ( 모임장 : <span>${club.cleader}</span> )
						</p>
					</div>
					<div class="mt-2 py-2 float-end border-top thisclub-tag">
						<a><span>#더조은</span></a> <a><span>#풀스택</span></a> <a><span>#JAVA</span></a> 
						<a><span>#HTML</span></a><a><span>#CSS</span></a> <a><span>#JAVASCRIPT</span></a> 
						<a><span>#DATABASE</span></a> <a><span>#JSP/SERVLET</span></a> <a><span>#AWS</span></a>
						<a><span>#SPRING</span></a>
					</div>
					<c:if test="${club.cleader == member.email}">
					<!-- 모임 멤버 리스트 보기 -->	
					<div class="clubmember-list border-top d-flex flex-column overflow-auto" style="max-height: 200px">
						<div class="py-2 fw-bold">모임 멤버</div>

					</div>
					<div class="pt-4 d-flex justify-content-end">
						<button class="btn border-0 p-2 px-3 me-3 update-btn" style="background-color:#cacaca; color: white">정보 수정</button>
						<button class="btn border-0 p-2 px-3 remove-btn" style="background-color:#ff6767; color: white">모임 삭제하기</button>
					</c:if>
					<c:if test="${club.cleader != member.email}">
					<c:forEach var="clubmember" items="${clubmembers }">
					<c:if test="${clubmember.member == member.email }">
						<div class="pt-4 d-flex justify-content-end">
							<button class="btn border-0 p-2 px-3 withdraw-btn" style="background-color:#ff6767; color: white">탈퇴하기</button>
					</c:if>
					</c:forEach>
					</c:if>
					</div>
				</div>
			</div>
		</div>
	<!-- 모임 정보 자세히 보기 모달 End -->



		
</div>
	 
<%--<script src="${pageContext.request.contextPath}/resources/js/reply.js"></script>--%>
	
<script>

	$(function () {

		let rno = '${reply.rno}'; // 댓글 번호 변수
		jQuery.fn.serializeObject = function() {
		    var obj = null;
		    try {
		        if ( this[0].tagName && this[0].tagName.toUpperCase() == "FORM" ) {
		            var arr = this.serializeArray();
		            if ( arr ) {
		                obj = {};
		                jQuery.each(arr, function() {
		                    obj[this.name] = this.value;
		                });
		            }
		        }
		    }
		    catch(e) {alert(e.message);}
		    finally  {}

		    return obj;
		};
		var id = '${member.email}';

		moment.locale('ko')
		/* let str = "";
		var rno = '${reply.rno}'; */
		
		
		/* 모임에 탈퇴하기 기능 */
		$(".withdraw-btn").on("click", function() {
			let membercnt = '${club.membercnt}'
			console.log("삭제 클릭")
			if(confirm('${club.cname}' + " 에서 탈퇴하시겠습니까?")) {
		 		clubMemberService.deleteMember({member: '${member.email}', club : '${club.cno}'}, function(result) {
					console.log(result)
		 			$("#clubinfo-modal").modal("hide");
					location.href = cp + "club/get/" + '${club.cno}'
				})
			}
	 	})

		/* 모임 가입하기 클릭 -> 모달 */
		$(".join-club").on("click", function() {
			$("#joinClub-modal").modal("show")
			$(".join-btn").eq(0).on("click", function() {
				$(".join-club textarea").val('')
				$("#joinClub-modal").modal("hide");
			})
		})
		
		
		/* 해당 모임 정보 자세히 보기 -> 모달  */
		$(".thisclub-profile :not(button)").on("click", function() {
			$("#clubinfo-modal").modal("show")
		})
		
		
		/* 클릭 시 글 자세히 보기 -> 모달 */
		$(".clubfeed ").on("click", ".clubboard-base", function() {
			
			boardService.get($(this).data("bno"), function (result) {
				$("#ClubboardModal").modal("show").data("bno", result.bno)
				console.log(result)
				/* $("#detailImage").attr("src", src) */
				$("#writer").text(result.writer)
				$("#content").html(result.content)
				$("#likeCnt").html(result.likecnt)
				$("#regdate").text(moment(result.regdate).startOf('day').fromNow())
				$("#modalFooter button").show()
				$("#modalFooter button").eq(2).hide()

				replyService.getList({bno:$("#ClubboardModal").modal("show").data("bno"), rno:rno}, function(result) {
					var str = "";
					for(var i in result) {
						str += getReplyLiStr(result[i]);
					}
					$(".chat").html(str);
				})
			})
			console.log(this)
		})
		
		
		/* DM 버튼 클릭시 작성자에게 메시지 보내기? or 글 내용을 친구에게 메시지 보내기? */
		
		
		// 해당 모임의 해당 멤버에게 가입하기 버튼 숨기기
		clubMemberService.get({club : '${club.cno}', member : '${member.email}'}, function(result) {
			if(result.status != 200) {
				$(".join-club").css("display", "none");
			}
		})
		
		// 해당 모임의 멤버 리스트 Str
		function getClubMemberList(obj) {
			return `<!-- 모임 멤버 1 -->
				<div id="clubMember" class="ms-2 d-flex flex-row align-items-center justify-content-between" style="font-size:14px">
					<p class="m-0 pe-2">\${obj.member} <span class="px-2" style="color:#b1b1b1; font-size:11px">가입: \${moment(obj.regdate).format("YY/MM/DD")}</span></p>
					<input type="hidden" value="\${obj.member}">
					<button class="btn border-0 col-2" style="color:red; font-size:14px">삭제</button>
				</div>			
			`;
		}
		
		// 해당 모임의 멤버 리스트 출력
		clubMemberService.getClubList({club : '${club.cno}'}, function(result) {
			console.log(result)
			for(let i in result){
				let str = '';
				if(result[i].member != '${member.email}'){
					str = getClubMemberList(result[i]);
					$(".clubmember-list").append(str);
				}
			}
					
			/* 모임의 멤버 강제 탈퇴 */
			$(".clubmember-list").children().each(function() {
				$(this).find("button").on("click", function() {
					let removeMember = $(this).parent().find("input").val();
					if(confirm(removeMember + "님을 강제 탈퇴하시겠습니까?")) {
						clubMemberService.deleteMember({member: removeMember , club: '${club.cno}'}, function() {
							alert("강제 탈퇴되었습니다.")
						})
						$(this).parent().remove()
					}
				})
			})
		
		})
		
		/* 모임에 가입하기 기능 */
		$(".join-btn").eq(1).on("click", function() {
		let membercnt = '${club.membercnt}'
			clubMemberService.register({
				member: '${member.email}', 
				club : '${club.cno}',
				answer: $("#clubAnswer").val()
				}, function(result) {
				$("#joinClub-modal").modal("hide");
				location.href = cp + "club/get/" + '${club.cno}'

				notiService.insert({type : 'clubRegister', sender : '${member.email}', receiver : '${club.cleader}', cno : '${club.cno}'}, function (result) {})

				let msg = "clubRegister," + '${member.id}' + "," + '${club.cleader}' + "," + null
				aws.send(msg);
			})
		})
		
		
		/* 모임 정보 수정 버튼 -> 수정 모달*/
		$(".update-btn").on("click", function() {
			$("#clubinfo-modal").modal("hide");
			$("#modifyclub-modal").modal("show");
		})
		
		/* 수정 모달 -> 모임 정보 수정 기능 */
		$(".modifyClubBtn").on("click", function() {
			event.preventDefault();
				
			/* status의 체크유무 값이 받아와지지 않아서 만든 조건식 */
			let checked = $("#updatestatus").is(':checked');
			if(checked){
				$("#updatestatus").val('true')
			} else {
				$("#updatestatus").val('false')
			}
			
				clubService.modify({
					cname : $("#updatecname").val(),
					intro : $("#updateintro").val(),
					town : $("#updatetown").val(),
					status : $("#updatestatus").val(),
					question : $("#updateQuestion").val(),
					cno : '${club.cno}'				
				}, function(result) {
					
					// club/get 모임정보에 비동기 적용
					clubService.findBy({cno: '${club.cno}'}, function(result) {
						$(".clubName").html(result.cname)
						$(".clubIntro").html(result.intro)
						$(".clubTown").find("span").html(result.town)
						$(".clubMemberCnt").find("span").html(result.membercnt)
					})
					// 모달 닫기
					$("#modifyclub-modal").modal("hide")
				})
			})
		
		/* 모임 삭제 기능 */
		$(".remove-btn").on("click", function() {
			$("#clubinfo-modal").modal("hide")
			if(confirm("삭제 시, 모임 회원과 모임 글의 모든 정보가 함께 삭제됩니다.")) {
				clubService.deleteClub({cno :'${club.cno}'}, function(result) {
					console.log(result)
					alert("삭제되었습니다.")
					location.href = cp + "board/feed"
				})
			}
			
		})
		
		
	/* ----------------------------------------- 모임 글쓰기 관련 ----------------------------------------- */
		
	/* 모임 글 str */
	function getClubBoardLiStr(obj) {
		let hasLike = obj.likeOn;
		let like = hasLike ? 'fas\" style=\"color: red' : 'far';			
		return `
		<!-- 모임 글 폼 -->
		<div class="myboard clubboard" data-bno="\${obj.bno}">
			<!-- 모임글: 작성자 정보 -->
			<div class="clubboard-header cardbox-header py-2">
				<div class="float-end">
					<button class="btn btn-flat btn-flat-icon clubBoardEditBtn" data-writer="\${obj.writer}" data-bno="\${obj.bno}" data-content="\${obj.content}" type="button">
					<i data-writer="\${obj.writer}" data-bno="\${obj.bno}" data-content="\${obj.content}" class="fas fa-ellipsis-h"></i>
					</button>
				</div>
				<div class="media m-0">
					<!-- 작성자 프로필 사진 -->
					<div class="d-flex mr-3">
						<a href=""><img class="img-fluid rounded-circle"
							src="${pageContext.request.contextPath }/resources/img/attach.jpg"
							alt="User"></a>
					</div>
					<!-- 작성자, 글번호, 등록일 -->
					<div class="media-body">
						<p class="m-0">\${obj.writer}</p>
						<small><span><i class="icon ion-md-pin"></i>
						\${obj.bno}</span></small> <small><span><i
						class="icon ion-md-time"></i> \${moment(obj.regdate).fromNow()}</span></small>
					</div>
				</div>
			</div>
			<!-- 모임글: 이미지 -->
				<div class="cardbox-item clubboard-item" data-bno="\${obj.bno}">
			</div>
			
			<!-- 모임글: 내용 -->
			<div class="cardbox-base clubboard-base" data-bno="\${obj.bno}" style="cursor:pointer">
				<div>
					<span class="clubBoard-content">\${obj.content}</span>
				</div>
				<div>
					<p style="margin: 30px auto 0">좋아요<span class="likeCnt"> \${obj.likecnt}개</span></p>
				</div>
			</div>
			<ul class="board-btnbox d-flex flex-row list-unstyled">
				<li><a><i data-bno="\${obj.bno}" class="fa-heart \${like}"></i></a></li>
				<li><a><i class="far fa-comment"></i></a></li>
				<li><a><i class="far fa-paper-plane"></i></a></li>
			</ul>
		</div>
		`;
	}
		/* 모임글에 이미지 넣기 Str 분리 메서드 -> 미사용 */
		function AddClubBoardImage(obj) {
			return `
			<img class="img-fluid"
			 src="${pageContext.request.contextPath }/display?name=\${obj.attaches[0]['name']}&path=\${obj.attaches[0]['path']}&uuid=\${obj.attaches[0]['uuid']}&image=\${obj.attaches[0]['image']}&thumb=on"
			 alt="Image" style="width:100%; max-height:587.5px">			
			`;
		}
		
		/* 모임에 글 쓰기 클릭 -> 모달 */
		$(".club-write").on("click", function() {
			$("#clubwrite-modal").modal("show")
			$(".ck-file-dialog-button").remove()
		})
		
		/* 모임 글 쓰기 모달창 -> 글 쓰기 */
		$("#clubBoardReg").on("click", function() {
			event.preventDefault();
			
			let imagestr = "";
		 	boardService.register({
		 		content : editor.getData(), 
		 		writer : '${member.email}', 
		 		category : '${club.cno}'
		 		}, function (result) {
					let str = "";
					str = getClubBoardLiStr(result);
					boardService.get(result, function (data) {
						$(".clubfeed").prepend(getClubBoardLiStr(data))
						/* 이미지가 있는 경우만 이미지 추가 */
						if(data.attaches[0].uuid != null) {
							imagestr = AddClubBoardImage(data)
							$(".clubfeed").find(".clubboard-item").html(imagestr)
						}
						/* imagestr인거 추가해야함 prepend?? */
					})
				})
			$("#clubwrite-modal").modal("hide");
		 	editor.setData('')
		})

	
		// 클럽 글 Edit 버튼 클릭 -> 모달
		$(".clubfeed").on("click", ".clubBoardEditBtn", function () {
			let $this = $(this);
			$("#editModal").data("bno", $(this).data("bno"))

			if ($(this).data("writer") === '${member.id}') {
				$("#editModal").modal("show")
			}
		})
		
		
		// Edit 버튼 -> 삭제 버튼 클릭 -> 삭제 재확인 모달
		$("#remove").click(function () {
			$("#editModal").modal("hide")
			$("#removeModal").modal("show");
			$("#removeModal").data("bno", $("#editModal").data("bno"))
			$("#removeModal .write-option:nth-of-type(2)").data("bno", $("#editModal").data("bno"))
			/* $("#removeModal").data("bno") */
		});
		
		// 삭제 재확인 모달 -> 삭제 선택
		$("#removeModal .write-option:nth-of-type(2)").click(function () {
			let $this = $(this)
  			boardService.remove($("#removeModal").data("bno"), function (result) {
				
				$(".clubfeed .clubboard").each(function () {
					if ($(this).data("bno") == $this.data("bno")) {
						$(this).remove()
					}
				})
				$("#removeModal").modal("hide")
			})  
		})
		
		// 삭제 재확인 모달 -> 취소 선택		
		$("#removeModal .write-option:nth-of-type(3)").click(function () {
			$("#removeModal").modal("hide")
		})

		
		// Edit 버튼 -> 수정 버튼 클릭 -> 수정 모달
 		$("#modify").click(function () {
			$("#editModal").modal("hide")
			$("#clubboard-modify-modal").modal("show")
			$("#clubboard-modify-modal").data("bno", $("#editModal").data("bno"));
			console.log($("#clubboard-modify-modal").data("bno"));
			$(".clubboard").each(function() {
				if($("#clubboard-modify-modal").data("bno") == $(this).data("bno")) {
					console.log($(this).find(".clubBoardEditBtn").data("content"))
					modifyEditor.setData($(this).find(".clubBoardEditBtn").data("content"))
					$("#clubBoardModifyCon").val($(this).find(".clubBoardEditBtn").data("content"));
				}
			})
 		});		
		
		// 수정 모달 -> 글 수정하기
		$("#clubBoardModifyBtn").on("click", function () {
 			boardService.modify({
				content : modifyEditor.getData() , 
				writer : '${member.email}', 
				bno : $("#clubboard-modify-modal").data("bno")}, 
				function (result) {
				$(".clubfeed .clubboard").each(function () {
					if ($(this).data("bno") == $("#clubboard-modify-modal").data("bno")) {
						$this = $(this)
						boardService.get($this.data("bno"), function (data) {
							$this.replaceWith(getClubBoardLiStr(data))
						})
					}
				}) 
 				$("#clubboard-modify-modal").modal("hide")
			}) 
		})
		
		// Edit 버튼 -> 취소 버튼 클릭
		$("#modify").next().click(function() {
			$("#editModal").modal("hide")
		})
		
		
 
	// 해당 모임의 글 리스트 출력 (초기화면)
	boardService.getList({category : '${club.cno}'}, function(result) {
		console.log(result)
		for(let i in result){
			var str = '';
			str = getClubBoardLiStr(result[i]);
			$(".clubfeed").append(str);
		}
	})
	
	// 해당 모임의 글 리스트 출력 (스크롤 이벤트)
	$(window).scroll(function () {
        if (Math.floor(($(window).scrollTop() / ($(document).height() - $(window).height())) * 100) >= 90) {
            boardService.getList({bno : $(".clubboard:last").data("bno"), category : '${club.cno}'}, function (result) {
                str = ""
                console.log(result)
                for (let i in result) {
                    str += getClubBoardLiStr(result[i])
                }
                $(".clubfeed").append(str)
            })
        }
    });		
	
					
	/* ------------------------------ 모임글 좋아요 -------------------------------- */				
	
	/* 이미지 더블 클릭 시 좋아요 */
	$(".clubfeed").on("dblclick", ".clubboard-item", function() {
		let $this = $(this);
		console.log($(this).data("bno") + " heart")
		let imgheart = $this.parent().find(".fa-heart");
		console.log(imgheart)
		
  		if (imgheart.closest("i").hasClass("fa-heart far") || imgheart.closest("i").hasClass("far fa-heart")) {
			boardService.insertLike({bno : $(this).data("bno"), id :'${member.email}'}, function (result) {
				imgheart.closest("i").attr("class", "fas fa-heart").css("color", "red").closest("div").find(".likeCnt").text(parseInt(imgheart.closest("div").find(".likeCnt").text()) + 1);
			})
		} else {
			boardService.removeLike({bno : $(this).data("bno"), id :'${member.email}'}, function (result) {
				imgheart.closest("i").attr("class", "far fa-heart").css("color", "#757575").closest("div").find(".likeCnt").text(parseInt(imgheart.closest("div").find(".likeCnt").text()) - 1);
			})
		} 
	})
	
	/* 좋아요 버튼 클릭시 좋아요 */
	$(".clubfeed").on("click", ".fa-heart", function() {
		let $this = $(this);
		console.log($(this).data("bno") + " heart")

		if ($this.closest("i").hasClass("fa-heart far") || $this.closest("i").hasClass("far fa-heart")) {
			boardService.insertLike({bno : $(this).data("bno"), id :'${member.email}'}, function (result) {
				$this.closest("i").attr("class", "fas fa-heart").css("color", "red").closest("div").find(".likeCnt").text(parseInt($this.closest("div").find(".likeCnt").text()) + 1);
			})
		} else {
			boardService.removeLike({bno : $(this).data("bno"), id :'${member.email}'}, function (result) {
				$this.closest("i").attr("class", "far fa-heart").css("color", "#757575").closest("div").find(".likeCnt").text(parseInt($this.closest("div").find(".likeCnt").text()) - 1);
			})
		}
	})
	
	
	
	/* --------------------------------- 댓글 관련 ---------------------------------- */
	
	// 댓글 리스트 조회
	function getReplyLiStr(obj) {
			let hasLike = obj.likeOn;
			let like = hasLike ? 'fas text-red' : 'far';
			return `<li class="list-group-item border-0" style="border-bottom: 0" data-rno="\${obj.rno}">
			   		<div class="header">
				   		<a href="">
						<img class="write-img" src="${pageContext.request.contextPath }/resources/img/attach.jpg">
						</a>
						<strong class="primary-font" data-writer="\${obj.writer}">&nbsp;\${obj.writer}</strong>
						<small class="float-right text-muted">\${moment(obj.regdate).fromNow()}</small>
					</div>
					<div class="d-flex">
					<div class="col-9">
					<span class="reply-content" data-content="\${obj.content}">\${obj.content}</span>
					</div>
					<div class="dropdown col-2 float-left" >
					  <a class="btn" data-toggle="dropdown">
						<i class="fas fa-ellipsis-h dropicon" style="color: white"></i>
					  </a>	
					  <div class="dropdown-menu">
					    <a class="dropdown-item replymodify">수정</a>
					    <a class="dropdown-item text-danger replydelete">삭제</a>
					  </div>
					</div>
					<div class="col-2">
					<a><i class="heart fa-heart \${like} " data-rno="\${obj.rno}" ></i></a></div>
					</div>
					<div>
					<p style="margin-bottom:5px; font-size:13px">좋아요 <span class="likeCnt">\${obj.likecnt}</span>개</p>
					</div>													
					</li>`;
		}
	
	// 더보기 버튼 클릭 이벤트
	$(".icn-more").click(function() {
		var rno = $(".chat li:last").data("rno"); //last:마지막 번호
		replyService.getList({bno:$("#ClubboardModal").modal("show").data("bno"), rno:rno}, function(result) {
			if(!result.length) { 
				$(".icn-more").prop("disabled", true);
				$(".icn-more").css("color", "#757575");
				return;
			}
			var str = "";
			for(var i in result) {
				str += getReplyLiStr(result[i]);
			}
			$(".chat").append(str);
		});
	})
	
	
	// 댓글 작성 버튼 이벤트 및 엔터키 이벤트
	$("#modalFooter button").eq(0).click(addReply);
	$("#reply").keyup(function(event){
		if(event.keyCode === 13){
	    	addReply();
	 	}
	});

	function addReply() {
		var obj = {bno: $("#ClubboardModal").data("bno"), content: $("#reply").val(), writer: '${member.email}'};
		replyService.add(obj, function(result) {
		    $("#modalFooter").find("input").val("");
		    // 작성한 댓글을 맨 위로 보냄
		    replyService.get(result, function(data) {
		      $(".chat").prepend(getReplyLiStr(data));
		    });
		});
	}
	
	// 댓글에 마우스 hover 이벤트
	$(document).on('mouseover', '.list-group-item', function(){
		var rno = $(this).closest(".list-group-item").data("rno");
		var writer = $(this).closest(".list-group-item").find(".primary-font").data("writer");
		/* 댓글 작성자와 일치하지 않으면 ... 아이콘이 보이지 않고 클릭 금지 */
		if ('${member.id}' != writer) {
			$(this).find('.dropicon').css('color', 'white');
			$(this).find('.btn').css("pointer-events", "none");
		/* 일치하면 ...이 보임 */
		}
		else {
			$(this).find('.dropicon').css('color', '#757575');
			$(this).find('.btn').css("cursor", "pointer");
		}
	});
	// 본인 작성 게시글에서 마우스가 벗어나면 ...이 보이지 않게
		$(document).on('mouseout', '.list-group-item', function(){
	    $(this).find('.dropicon').css('color', 'white');
	});
	
	
		$(document.replyform).submit(function() {
			event.preventDefault();
			if(!this.content.value.length) {
				alert("댓글 내용을 입력해주세요.");
				return false;
			}
			// 작성 수정 분기
			var obj = $(this).serializeObject();
			// 수정일때
			if($(this).prop("modify")) {
				replyService.modify(obj, function(result) {
					// 초기화
				    $(document.replyform).prop("modify", false).find("button").text("등록").prev().val("");
			    	$(".list-group-item").each(function() {
						if($(this).data("rno") == obj.rno) {
							var $this = $(this);
							replyService.get($this.data("rno"), function(r) {
								console.log(r);
								$this.replaceWith(getReplyLiStr(r))
                            })
                        }
                    })
				});
			}
			else {
				replyService.add(obj, function(result) {
				    $("#modalFooter").find("input[name='content']").val("");
				    // 작성한 댓글을 맨 위로 보냄
				    replyService.get(result, function(data) {
				    	$(".chat").prepend(getReplyLiStr(data));
				    });
				});
			}
		})

	    $(".chat").on("click", ".replymodify", function() {
	    	var  $li = $(this).closest("li")
	    	var content = $li.find(".reply-content").text()
	    	var rno = $li.data("rno");
	    	console.log(rno, content);
	    	$(document.replyform).prop("modify", true)
	    	.find("[name='rno']").val(rno).end()
	    	.find("button").text("수정").prev().val(content).focus();
	    })
	    
	    $(".chat").on("click", ".replydelete", function() {
            var $listItem = $(this).closest(".list-group-item");
            var rno = $listItem.data("rno");
            replyService.remove(rno, function(result) {
                $listItem.remove();
	        })
	    })
	
	 // 댓글 좋아요
		$(".chat").on("click", ".heart", function () {
			let $this = $(this);
			var rno = $(this).closest(".list-group-item").data("rno");
			var obj = {rno : rno, id : id};
			replyService.like(obj, function(data) {
				if(data < 0) { // 좋아요 빼기
					$this.removeClass("fas text-red").addClass("far")
				} else { // 좋아요 상태 되기
					$this.removeClass("far").addClass("fas text-red")
				}
				$likeCnt = $this.closest(".list-group-item").find(".likeCnt");
				$likeCnt.text(parseInt($likeCnt.text()) + parseInt(data));
			})
		})
	

	
})		
</script>
	
<script>

	/* 글작성시 ck 에디터 사용 */
	let editor;
	
	ClassicEditor.create($('#clubBoardContent').get(0), {
		ckfinder : {
		},
		language : 'ko'
	}).then( newEditor => {
		editor = newEditor;
	}).catch( error => {
		console.log(error);
	})
	
	ClassicEditor.create($('#clubBoardModifyCon').get(0), {
		ckfinder : {
		},
		language : 'ko'
	}).then( newEditor => {
		modifyEditor = newEditor;
	}).catch( error => {
		console.log(error);
	})
	
	
/*  	ClassicEditor.create($('#board-content').get(0), {
		toolbar : []
	}).then(function(editor) {
		editor.enableReadOnlyMode('lock');
	}); */
 
</script>


<jsp:include page="../layout/footer.jsp"></jsp:include>

