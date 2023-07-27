<a name="readme-top"></a>

<br />
<div align="center">
  <a href="#" target="_blank">
    <img src="http://damso.kseolha.com/resources/img/login_logo.png" alt="Logo" width="200">
  </a>

<h3 align="center">damSo</h3>

  <p align="center">
    사회 관계망 서비스 구현
    <br>
    <p>작업기간 : 2023.03 ~ 2023.04</p>
    vcs worked on svn
    <br>
  </p>
</div>

<!-- ABOUT THE PROJECT -->
## About The Project

<!-- <img src="images/4.png" > -->

<br>
JAVA CLI Project <br>
학원 세프로젝트 <br>
JAVA 콘솔창을 활용하여 CRUD 구현을 목적으로 작업

### Built With
<img src="https://img.shields.io/badge/jsp-white?style=flat&logo=jsp&logoColor=black"/><img src="https://img.shields.io/badge/javascript-F7DF1E?style=flat&logo=javascript&logoColor=black"/><img src="https://img.shields.io/badge/jquery-0868AB?style=flat&logo=jquery&logoColor=white"/> <img src="https://img.shields.io/badge/Bootstrap5-magenta?style=flat&logo=Bootstrap&logoColor=black"/><br>
<img src="https://img.shields.io/badge/Java-white?style=flat&logo=java&logoColor=white"/>
<img src="https://img.shields.io/badge/Spring-green?style=flat&logo=spring&logoColor=white"/>
<img src="https://img.shields.io/badge/Mybatis-red?style=flat&logo=Mybatis&logoColor=white"/><br>
<img src="https://img.shields.io/badge/mariaDB-lightgray?style=flat&logo=mariadb&logoColor=white"/><br>
<img src="https://img.shields.io/badge/Tomcat-orange?style=flat&logo=Tomcat&logoColor=white"/><br>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->
## Getting Started

프로젝트를 복제하여 로컬에서 설정하는 방법에 대한 설명 입니다. <br>

### 사전준비

#### 저장소 복제
   ```sh
   git clone https://github.com/seolha86/semi_damSo.git
   ```

#### 데이터베이스 구성
<img alt="ERD" src="https://github.com/seolha86/semi_damSo/assets/93528672/752a6650-9913-4dea-bfb6-f8bf53311166" width="500">


#### 데이터베이스 테이블 생성 쿼리
  
<details>
  <summary>query</summary>  
  <pre>
create table member (
  email varchar(100) PRIMARY KEY,
  pw varchar(100) not null,
  name varchar(100) not null, 
  id varchar(100) not null, 
  intro varchar(150),
  tel varchar(100), 
  addr varchar(100), 
  regdate datetime default now() 
);

create table friend (
    following varchar(50) references member(email),
    followed varchar(50) references member(email),
    primary key (following, followed)
);

create table board (
   bno bigint primary key auto_increment,
   title varchar(200) not null,
   content text not null,
   writer varchar(50) references member(email),
   regdate datetime default now(),
   updatedate datetime default now(),
   hitcount int default 0,
   category int default 1,
   replycnt int
);

create table reply (
    rno bigint primary key auto_increment,
    content text not null,
    regdate datetime default now(),
    writer varchar(75) not null,
    bno bigint references board(bno)
);

create table club (
    cno bigint primary key auto_increment,
    cname varchar(100) not null ,
    intro varchar(150),
    cleader varchar(100) references member(email),
    town varchar(100),
    status varchar(5),
    regdate datetime default now()
);

create table clubMember (
    member varchar(75) references member(email),
    club bigint references club(cno),
    regdate datetime default now(),
    primary key (member, club)
);

create table clubHashtag (
    chno bigint primary key auto_increment,
    cno bigint references club(cno),
    hno bigint references hashtag(hno)
);

create table message (
    cno bigint primary key auto_increment,
    recv_id varchar(100) references member(email),
    sent_id varchar(100) references member(email), 
    content text not null,
    sent_date datetime default now(), -- 보낸 시간
    read_date int default 0 -- 읽었는지 확인
);

create table boardLike(
    bno bigint references board(bno),
    id varchar(100) references member(email),
    regdate datetime default now(),
    primary key (bno, id)
);

create table attach (
    uuid varchar(100) primary key,
    path varchar(100),
    name varchar(100),
    image int(1),
    bno bigint references board(bno),
    cno bigint references club(cno),
    email varchar(100) references member(email)
);

create table hashtag (
    hno bigint primary key auto_increment,
    hname varchar(100)
);

create table boardHashtag (
    bhno bigint primary key auto_increment,
    bno bigint references board(bno),
    hno bigint references hashtag(hno)
);

create table replyLike (
    rlno bigint primary key auto_increment,
    rno bigint references reply(rno),
    id varchar(100) references member(email)
);

create table replyTag (
    rtno bigint primary key auto_increment,
    rno bigint references reply(rno),
    id varchar(100) references member(email)
);

create table notification (
    nno bigint primary key auto_increment,
    sender varchar(100) not null references member(email),
    receiver varchar(100) not null references member(email),
    type varchar(100) not null,
    content varchar(100),
    sdate datetime default now(),
    rdate datetime
);
  </pre>
</details>

#### 데이터베이스 연결 <br>
root/src/main/resources/jdbc.properties 생성
<br>

  ```sh
db.classname=net.sf.log4jdbc.sql.jdbcapi.DriverSpy
db.url=jdbc:log4jdbc:mariadb://'DB url':'port'/'DB name'
db.username='username'
db.password='password'
  ```

### 설치

1. JDK 1.8
2. STS 3.9.4
3. MariaDB
4. Lombok
5. Tomcat9

<!-- USAGE EXAMPLES -->
## 사용방법 및 기능소개
#### 기능소개
<pre>
  - 회원
    - 가입 : id, password, name, tel, email, addr, nickname을 입력받아 가입 진행
    - 로그인 : id, password를 입력받아 로그인
    - 정보 수정 : 비밀번호, 집주소, 닉네임(중복여부체크), 자기소개, 프로필사진 변경
    - 탈퇴 : 회원의 모든 정보와 지금까지 남긴 게시물, 댓글(자신과 친구 모두 포함)등을 전부 일괄 삭제
- 게시물
    - 게시물 생성
    - 게시물 조회
        - 단일 조회 : 게시물 상세 정보 조회
        - 목록 조회 : 친구로 추가한 모든 사람의 글을 조회
    - 게시물 수정 : 회원의 게시글 제목이나 내용 수정
    - 게시물 삭제
    - 좋아요
- 댓글
    - 댓글 작성
    - 댓글 조회
    - 댓글 수정
    - 댓글 삭제
- 모임
    - 모임 가입
    - 모임 관리
    - 모임원 관리
    - 모임 삭제
- 친구
    - 추가
    - 삭제
- 알림
    - 댓글 알림 : 다른 회원이 내 게시물에 댓글을 남기면 알림 생성
    - 좋아요 알림 : 다른 회원이 내 게시물에 좋아요를 누르면 알림 생성
    - 팔로우 알림 : 다른 회원이 나를 팔로우하면 알림 생성
- 채팅
</pre>

#### 사용방법
<pre>
  1. 회원가입
  2. 로그인 (demo 페이지 기준 nhue630@gmail.com/1234 입력)
</pre>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Collaborator
 Team Project 
 <pre>
   공통 : DB설계, 디지털 프로토 타이핑, 서류작성 (요구사항 정의서, 테이블 명세서, TEST CASE, 인터페이스 명세서 / Etc.document 참고) 
   
   김설하(본인) : <b>팀장</b>, 게시글, 알림
   
   천은경 : 모임, 메시지, UI/UX 디자인
   
   강태수 : 친구
   
   박현민 : 댓글
   
   김민수 : 회원, UI/UX 디자인, 로고 디자
</pre>
 
 <p align="right">(<a href="#readme-top">back to top</a>)</p>

 <!-- LICENSE -->
## Etc
#### 작업 서류
<a href="https://docs.google.com/spreadsheets/d/1Dofu9ugGKLxQQulQ4o6Gfn1cHgOCtG88HjmJctyVSfI/edit?usp=sharing">
  요구사항 정의서, 일정관리, test case, 테이블 명세서, 인터페이스 명세서 등
</a>

#### PPT
<details>
<summary>PPT Image</summary>
</details>

#### Digital Prototyping

### 프로젝트 후기
#### 김설하
<pre>
  스프링과 비동기처리에 대한 이해도를 높일 수 있는
  좋은 경험이었습니다. SNS를 구현하며 테이블 간 관
  계에 대한 이해도도 높아졌습니다. 설계했던 부분을
  모두 구현하지 못해 아쉬움이 남습니다.
</pre>

#### 천은경
<pre>
  비동기 방식 및 Spring에 대한 구현 경험이 적어 부
  담도 느꼈지만, 오히려 부족한 부분을 채울 수 있었
  습니다. 설계한 모든 기능을 구현할 수는 없었기에 아
  쉽지만, 다대다 테이블 관계와 비동기 방식 및 웹 소
  켓에 대한 이해도를 높일 수 있었고, 팀 프로젝트에서
  의 협업 등 전체적으로 폭넓게 성장할 수 있었습니다.
</pre>

#### 강태수
<pre>
  시작할 때 걱정이 많았고 생각처럼 구현이 안 돼서 힘
  들었지만 팀원들의 도움으로 구현하면서 팀워크의 중요
  성과 좋은 경험이 되었던 거 같습니다. 스스로 부족한 
  부분들이 느껴져서 아쉬움이 들었습니다.
</pre>

#### 박현민
<pre>
  처음에는 SNS를 하게 되면서 막막함을 느꼈습니다. 
  자주 접하던 인스타그램을 토대로 구현을 하고자 하니
  어렵기도 하지만 재미있던 것 같습니다. 계획했던
  것을 전부 구현하지는 못해 아쉬움이 많이 남지만 
  이번 경험을 통해 스프링의 전체적인 구조와 비동기에
  대해 조금이나마 이해를 하게되어 보람을 느꼈습니다.
</pre>

#### 김민수
<pre>
  기초적인 부분과 공부하지 않았던 부분의 공백이 느
  껴져서 아쉬웠습니다. 부족한 부분을 팀원들과 함께 
  공부하고 만들면서 협동심의 중요성을 알게 되는 시
  간이었습니다.
</pre>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTACT -->
## Contact

Kim Seolha - nhue630@gmail.com

<a href="https://damso.kseolha.com" target="_blank">Demo Link</a>

<a href="https://www.kseolha.com" target="_blank">Portfolio Link</a>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

이 프로젝트를 사용해주시고 README를 읽어주신 여러분께 대단히 감사합니다!

### References
README Template : [README-Template](https://github.com/othneildrew/Best-README-Template)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Fseolha86%2Fsemi_damSo&count_bg=%23A1EF67&title_bg=%2300FF57&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)
