<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
		 isELIgnored="false"%>

<jsp:include page="../layout/header.jsp"></jsp:include>
<link
		href="${pageContext.request.contextPath }/resources/css/styleBoard_230407.css"
		rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<style>
	a {
		cursor: pointer;
	}
	.feed-main {
		display :flex;
		justify-content: center;
	}
	.myfeed {
		max-width: 620px;
	}
	.story {
		height: auto;
		display: flex;
		padding: 45px 0 20px;
		justify-content: space-around;
	}
	.myinfo {
		width: 250px;
		height: 400px;
	}
	.story-img, .media .info-img {
		width: 60px;
		height: 60px;
		border-radius: 50%;
		border: white 2px solid;
		padding: 0;
	}
	.story-active {
		width: 64px;
		height: 64px;
		border-radius: 50%;
		border: #cceabf 2px solid;
	}
	.myboard {
		width : 470px;
		margin: auto;
		padding-top: 30px;
	}
	.board-btnbox {
		margin: 0;
		padding: 10px;
	}
	.board-btnbox li {
		padding-right: 8px;
	}
	.board-btnbox li:nth-of-type(4) {
		float : right;
		padding-right: 0;
		margin-right: -23px;
	}
	.reply-view, .reply-add {
		color: #757575;
		font-size: 15px;
	}
	.reply-view p {
		padding: 5px 0 10px;
		margin:0;
	}
	.reply-add {
		border: none;
		width: 100%;
		margin-left: -2px;
		padding-bottom: 10px;
	}
	.feed-writer, .reply-view:hover, .feed-writer:hover {
		color: #fdb3b6;
	}
	.reply-addbtn {
		float: right;
		background-color: white;
		border: none;
		cursor: pointer;
		color: #757575;
	}

	.write-img {
		border: none !important;
		border-radius: 50%;
		width: 30px !important;
		height: 30px !important;
	}

	textarea {
		border: none;
		width: 100%;
		height: 300px;
		padding: 10px 15px;
		resize: none;
		border-bottom: #e9ecef solid 1px;
	}

	.write-option {
		height: 40px;
		border-bottom: solid 1px #e9ecef;
		cursor: pointer;
	}
	
	.modalscroll {
 		overflow-x: hidden; 
 		overflow-y: auto;
  		height: 412.11px;
 	}
 	
 	.modalscroll::-webkit-scrollbar {
		display: none; /* Chrome, Safari, Opera*/
	}
	.search-main img {
		width: 100%;
		height: auto;
	}
	.profileTab {
		cursor: pointer;
	}
	.modal-heade {
	    text-align: center;
	}
	
	.memberModify, .intro, .idModify, .nameModify {
		color: #abbcae;
	}
	
	.modifyComplete{
		background-color: #ffeded;
		color: #abbcae;
		font-size : 14px;
	}
	
	.passwordModify{
		margin-top:12px;
	}
	
	.passwordModify a{
		color: #abbcae;
		border : 1px solid #abbcae;
		padding : 5px;
		border-radius: 4px;
		font-size : 12px;
	}
	
</style>

<div class="search-container d-flex flex-column h-100 w-100 align-items-center">

	<div class="col-12 search-main px-3">
		<div class="col-12 d-flex flex-column px-4 justify-content-around" style="height:400px">
			<!-- 추후 반응형 작업 필요 -->
			<div class="d-flex flex-row align-items-center px-5 mt-4">
				<!-- 이때 우리 이미지는 전부 1:1로 저장되기때문에 추후에 height auto로 바꾸기!!!! 안바꾸면 반응형에서 찌그러짐 -->
				<img class="col-3 ms-4" src="${pageContext.request.contextPath }/resources/img/attach.jpg"
					style="width: 150px; height:150px; border-radius:50%">
				<div class="col-9 d-flex flex-column align-items-start pb-2 ps-4 ms-5">
					<div class="fs-5 pb-2 fw-bold profile_id">${profileEmail.id} 
						<!-- 본인 프로필인 경우에만 -->
						<button class="btn border-0 p-2 px-3 ms-5 my-3" style="color:white;background-color:#c0cabf;font-size:13px" id="profileModify">프로필 편집</button>
						<!-- 본인 프로필이 아닌 경우에만 -->
						<button class="message-btn btn border-0 bg-light p-2 px-3 ms-3 my-3" style="font-size:13px" id="messageSend">메시지 보내기</button>
						<button class="btn border-0 bg-light p-2 px-3 ms-3 my-3 addFriend" style="font-size:13px " id="fallow"><i class="fas fa-user-plus"></i></button>
						<i class="fas fa-ellipsis-h ms-3 my-3"></i>  <!-- id="fallow" id="addFriend" -->
					</div>
					<div class="d-flex flex-row pb-3">
						<div class="pe-4 me-3">게시물 <span class="fw-bold boardCnt"></span></div>
						<div class="pe-4 me-3 " id="followerBtn" >팔로잉 <span class="fw-bold" id ="followCount"></span></div>
						<div class="pe-4 me-3" id="followingBtn">팔로워 <span class="fw-bold" id ="followerCount"></span></div>
					</div>
					<div class="pt-3 fw-bold profile_name">${profileEmail.name} <span class="ps-2">음악가 / 밴드</span></div>
					<div class="pt-2 border-0 col-12 overflow-hidden profile_introl" style="height:60px" readonly>${profileEmail.intro}</div>
				</div>	
			</div>
			
			<!-- 프로필 상단 탭 : 기능 수정 가능성 有 -->			
			<div class="col-12 d-flex flex-row flex-align-center text-center mt-4" style="height:50px">
				<div class="profileTab profileTab-board col-4 m-auto py-2 border-bottom border-3">게시글</div>
				<div class="profileTab profileTab-club col-4 m-auto py-2 border-bottom">모임</div>
				<!-- <div class="col-3 m-auto py-2 border-bottom">저장됨</div> -->
				<div class="profileTab profileTab-tag col-4 m-auto py-2 border-bottom">태그됨</div>
			</div>
		</div>
		
		<!-- 게시글 목록 Start -->
		<div class="profile-board col-12 d-flex mt-1 flex-wrap">
			<!-- 게시글 1 Start -->

			<!-- 게시글 1 End -->

		</div>
		<!-- 게시글 목록 End -->
	</div>

	<%-- 글 상세 --%>
	<!-- 댓글 작성 모달 -->
<%-- 	<div class="modal fade" id="boardModal" tabindex="-1"
		 role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-lg"
			 role="document">
			<div class="modal-content" style="flex-direction: row; flex-wrap: wrap; border-radius: 10px;">
				<div class="col-12" style="height:38px">
					<a>
						<i class="fas fa-arrow-left float-start pt-2" style="font-size: 22px; padding-left:10px"></i>
					</a>
					<a id="register" class="float-end" style="padding: 8px 12px 0">글쓰기</a>
				</div>
				<div class="col-7">
					<img id="detailImage" class="img-fluid" src=""
						 alt="Image" style="width: auto; height: 100%; max-height: 587.5px; object-fit: cover">
				</div>
				<div class="col-5">
					<div class="media p-3">
						<div class="d-flex">
							<a href="">
								<img class="write-img" src="${pageContext.request.contextPath }/resources/img/attach.jpg">
							</a>
						</div>
						<div class="media-body" style="padding-top: 2px;">
							<span class="" id="writer"></span>
							<div class="write-option" style="border-bottom: 0">
								<span class=" float-start pt-1 ps-3" id="content"></span>
							</div>
						</div>
					</div>
					<div class="modalscroll" style="position: relative;">
						<ul class="list-group chat">
							<!-- <li class="list-group-item" style="border:0px solid"></li>  -->
						</ul>
						<a class="icn-more" style="position: absolute; right: 0; padding: 10px 25px"><i class="fas fa-plus-circle"></i></a>
					</div>
					<div class="modal-footer" id="modalFooter" style="display: flex; justify-content: space-between;">
						<div style="flex: 8;">
							<input type="text" class="reply-add reply-modify" style="width: 100%;" id="reply" placeholder="댓글 달기..">
						</div>
						<div style="flex: 2; text-align: right;">
							<button class="btn btn-link" type="button">등록</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div> --%>

</div>
<!-- 팔로잉 모달 -->
<div class="modal fade" id="followerModal" tabindex="-1" role="dialog" aria-labelledby="followerModalLabel"
    aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-heade">
                <h5 class="modal-title" id="followerModalLabel">팔로잉 </h5>
              
            </div>
            <div class="modal-body">
                <table id="followerTable" class="table table-hover">
                    <thead>
                        <tr>

                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>

<!-- 팔로워 모달 -->
<div class="modal fade" id="followingModal" tabindex="-1" role="dialog" aria-labelledby="followingModalLabel"
    aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-heade">
                <h5 class="modal-title" id="followingModalLabel">팔로워 </h5>
            </div>
            <div class="modal-body">
                <table id="followingTable" class="table table-hover">
                    <thead>
                        <tr>
 
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>
<!-- 친구추가 -->
<div class="modal fade" id="addFriendModal" tabindex="-1" role="dialog" aria-labelledby="addFriendModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addFriendModalLabel">친구 추가</h5>

            </div>
            <div class="modal-body">
                <table id="addFriendTable" class="table table-hover">
                    <tbody>
                        <tr>
                            <td>
                               
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
               
            </div>
        </div>
    </div>
</div>

<!-- 프로필 수정하기 폼 Start -->
	<div class="modal fade" id="profileModifyModal" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-lg" style="width: 700px;"
			role="document">
			<div class="modal-content p-3" style="flex-direction: row; flex-wrap: wrap; border-radius: 10px;">
				<div class="col-10 m-auto d-flex flex-row flex-wrap" name="clubcreate-form" id="clubcreate-form">
					<div class="col-12 h-25 my-4 d-flex flex-column align-items-start">
						<label class="memberModify" for="memberModify">회원수정</label>
						<p class="col-12 h-0 border-0 border-bottom" type="text" id="memberModify" name="memberModify"></p>
					</div>
					<div class="club-attach col-6 bg-light mb-4 d-flex justify-content-center align-items-center" style="height: 300px; cursor:pointer">
						<i class="fas fa-image fs-3"></i>
					</div>
					<div class="col-6 d-flex flex-column p-3 pt-0 align-items-start">
						<label class="py-2 col-12 intro"  for="intro">회원소개 <i class="far fa-edit"></i></label>
						<textarea class="h-25 border col-12 memberIntro" id="intro" name="intro">${member.intro}</textarea>
						<label class="py-2 col-12 idModify" for="idModify">아이디 수정 <i class="fas fa-seedling"></i></label>
						<input class="border col-12 " type="text" id="idModify" name="idModify" value=${member.id}>
						<label class="py-2 col-12 nameModify" for="nameModify">이름수정 <i class="fas fa-seedling"></i></label>
						<input class="border col-12" type="text" id="nameModify" name="nameModify" value=${member.name}>
						<input type="hidden" id="cleader" name="cleader">
						<div class="passwordModify">
							<a id="password" href="${pageContext.request.contextPath}/member/modifyPw">비밀번호 변경 <i class="fas fa-seedling"></i></a>
							<a id="deleteMember" href="${pageContext.request.contextPath}/member/deleteMember">회원탈퇴 <i class="fas fa-seedling"></i></a>
						</div>
					</div>
					<div class="col-12 d-flex justify-content-end pe-3 py-1 mb-2">
						<button class="p-1 px-3 btn border-0 modifyComplete">수정완료</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 프로필 수정하기 폼 End -->
    <!-- 끝 -->
<script src="${pageContext.request.contextPath}/resources/js/friend.js"></script>
<%-- <script src="${pageContext.request.contextPath}/resources/js/member.js"></script> --%>
<script>
//사용자와 프로필 소유자의 이메일을 가져오기
var currentUser = "${profileEmail.id}";

var profileOwner = "${member.id}";
// 이메일이 일치하지 않으면 프로필 편집 버튼을 숨기기 
if(currentUser !== profileOwner){
	var editButton = document.getElementById("profileModify");
	editButton.style.display = "none";
}

if(currentUser == profileOwner){
	var messageBtn = document.getElementById("messageSend");
	var fallowBtn = document.getElementById("fallow");
	messageBtn.style.display ="none";
	fallowBtn.style.display ="none";
}
$(function() {

	$(".profileTab-club").on("click", function() {
		// console.log("모임리스트 출력하기~")
		$(".profile-board").empty()
		$(".profileTab-club").addClass("border-3")
		$(".profileTab-board").removeClass("border-3")
		$(".profileTab-tag").removeClass("border-3")
		if('${not empty member}'){
			clubService.getMyClubList({email: encodeURIComponent('${member.email}')}, function(result){
				for(let i in result){
					// console.log(result[i])
					// console.log(result[i].cname)
				}
			})
		}
	})
	
	$(".message-btn").on("click", function() {
		messageService.chat({}, function(result) {
			
		})
	})

	/*-------------------------- 태그 탭 -------------------------- */
	$(".profileTab-tag").click(function () {
		$(".profile-board").empty()
		$(".profileTab-tag").addClass("border-3")
		$(".profileTab-board").removeClass("border-3")
		$(".profileTab-club").removeClass("border-3")
	})

	/*-------------------------- 글 목록 탭 -------------------------- */

	boardService.getList({id : '${profileEmail.email}'}, function (result) {
		let str = "";
		for (let i in result) {
			str += getMyFeedStr(result[i])
		}
		$(".profile-board").html(str)
	})

	boardService.getAllList({email : '${profileEmail.email}'}, function (result) {
		$(".boardCnt").html(result.length)
	})

	$(".profileTab-board").click(function () {
		$(".profile-board").empty()
		$(".profileTab-board").addClass("border-3")
		$(".profileTab-tag").removeClass("border-3")
		$(".profileTab-club").removeClass("border-3")
		boardService.getList({id : '${profileEmail.email}'}, function (result) {
			// console.log("게시글 탭")
			// console.log(result)
			let str = "";
			for (let i in result) {
				str += getMyFeedStr(result[i])
			}
			$(".profile-board").html(str)
		})
	})

	$(".profile-board").on("click", ".profileBoard", function () {
		let src = $(this).data("src");
		let rno = '${reply.rno}'
		// console.log(src)

		boardService.get($(this).data("bno"), function (result) {
			$("#boardModal").modal("show").data("bno", result.bno)
			$("#detailImage").attr("src", src)
			$("#writer").text(result.writer)
			$("#content").text(result.content)
			$("#regdate").text(moment(result.regdate).startOf('day').fromNow())
			$("#modalFooter button").show()
			$("#modalFooter button").eq(2).hide()
			$("#boardModal").modal("show").data("bno", result.bno)

			replyService.getList({bno:$("#boardModal").modal("show").data("bno"), rno:rno}, function(result) {
				var str = "";
				for(var i in result) {
					str += getReplyLiStr(result[i]);
				}
				$(".chat").html(str);
			})
		})
	})

	// 내 글 목록 조회
	function getMyFeedStr(obj) {
		return `
		<div class="col-4 overflow-hidden profileBoard" data-bno="\${obj.bno}" data-src="/display?name=\${obj.attaches[0]['name']}&path=\${obj.attaches[0]['path']}&uuid=\${obj.attaches[0]['uuid']}&image=\${obj.attaches[0]['image']}&thumb=on">
			<a>
				<img class="p-1" src="/display?name=\${obj.attaches[0]['name']}&path=\${obj.attaches[0]['path']}&uuid=\${obj.attaches[0]['uuid']}&image=\${obj.attaches[0]['image']}&thumb=on">
			</a>
		</div>
	`
	}

	// 댓글 리스트 조회
	function getReplyLiStr(obj) {
		return `<li class="list-group-item" style="border-bottom: 0" data-rno="\${obj.rno}">
			   		<div class="header">
						<strong class="primary-font" data-writer="\${obj.writer}">\${obj.writer}</strong>
						<small class="float-right text-muted">\${moment(obj.regdate).fromNow()}</small>
					</div>
					<div class="d-flex">
					<div class="col-9">
					<span class="reply-content" data-content="\${obj.content}">\${obj.content}</span>
					</div>
					<div class="dropdown col-2 float-left">
					  <a class="btn" data-toggle="dropdown">
						<i class="fas fa-ellipsis-h dropicon"></i>
					  </a>
					  <div class="dropdown-menu">
					    <a class="dropdown-item">답글 달기</a>
					    <a class="dropdown-item" id="replymodify">수정</a>
					    <a class="dropdown-item text-danger" id="replydelete">삭제</a>
					  </div>
					</div>
					<div class="col-2">
					<a><i class="far fa-heart" id="heart"></i></a></div></div>
					</li>`;
	}
	
	/* 프로핊 편집 클릭 -> 모달 메서드*/
	$("#profileModify").on("click", function() {
		$("#profileModifyModal").modal("show")
		var val = '${email}';
		// console.log(val);
		$('.modifyComplete').on("click", function(){
			event.preventDefault();
			var x = {
					intro : $(".memberIntro").val(),
					id : $("#idModify").val(),
					name : $("#nameModify").val(),
					email : val
				  };
			// console.log(x);
			memberservice.update(x,function(result){
					alert("정보수정이 완료되었습니다")
				  $("#profileModifyModal").modal("hide")
				    location.href = "${pageContext.request.contextPath}/member/profile/${member.email}/damso"  
			})
		})
	})
	

	

})

</script>

<jsp:include page="../layout/footer.jsp"></jsp:include>