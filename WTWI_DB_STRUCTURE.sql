------------------------------------------------------------------------------------------
-- 회원 테이블
------------------------------------------------------------------------------------------
DROP TABLE "MEMBER";

CREATE TABLE "MEMBER" (
	"MEMBER_NO"	NUMBER		NOT NULL,
	"MEMBER_ID"	VARCHAR2(50)		NOT NULL,
	"MEMBER_PW"	VARCHAR2(200)		NOT NULL,
	"MEMBER_NM"	VARCHAR2(30)		NOT NULL,
	"MEMBER_NICK"	VARCHAR2(30)		NOT NULL,
	"MEMBER_EMAIL"	VARCHAR2(100)		NOT NULL,
	"MEMBER_PHONE"	CHAR(13)		NOT NULL,
	"ENROLL_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"MEMBER_STATUS"	CHAR(1)	DEFAULT 'Y' CHECK(MEMBER_STATUS IN('Y','N','S'))	NOT NULL,
	"MEMBER_GRADE"	CHAR(1)	DEFAULT 'G' CHECK(MEMBER_GRADE IN('G','A','M'))	NOT NULL
);

COMMENT ON COLUMN "MEMBER"."MEMBER_NO" IS '회원번호';
COMMENT ON COLUMN "MEMBER"."MEMBER_ID" IS '회원 아이디';
COMMENT ON COLUMN "MEMBER"."MEMBER_PW" IS '회원 비밀번호';
COMMENT ON COLUMN "MEMBER"."MEMBER_NM" IS '회원 이름';
COMMENT ON COLUMN "MEMBER"."MEMBER_NICK" IS '회원 닉네임';
COMMENT ON COLUMN "MEMBER"."MEMBER_EMAIL" IS '회원 이메일';
COMMENT ON COLUMN "MEMBER"."MEMBER_PHONE" IS '회원 휴대폰 번호';
COMMENT ON COLUMN "MEMBER"."ENROLL_DATE" IS '회원 가입일';
COMMENT ON COLUMN "MEMBER"."MEMBER_STATUS" IS '회원상태(정상Y / 탈퇴N / 정지S)';
COMMENT ON COLUMN "MEMBER"."MEMBER_GRADE" IS '회원등급(일반G /  관리자A  /담딩자 M)';

------------------------------------------------------------------------------------------
-- 명소 담당자 테이블
------------------------------------------------------------------------------------------
DROP TABLE "MANAGER";

CREATE TABLE "MANAGER" (
	"MEMBER_NO"	NUMBER		NOT NULL,
	"ATTRACTION_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "MANAGER"."MEMBER_NO" IS '회원번호';
COMMENT ON COLUMN "MANAGER"."ATTRACTION_NO" IS '명소 게시글 번호';

------------------------------------------------------------------------------------------
-- 명소 정보 테이블
------------------------------------------------------------------------------------------
DROP TABLE "ATTRACTION_INFO";

CREATE TABLE "ATTRACTION_INFO" (
	"ATTRACTION_NO"	NUMBER		NOT NULL,
	"ATTRACTION_NM"	VARCHAR2(100)		NOT NULL,
	"ATTRACTION_ADDR"	VARCHAR2(300)		NOT NULL,
	"ATTRACTION_PHONE"	NUMBER		NOT NULL,
	"ATTRACTION_INFO"	VARCHAR2(500)		NULL,
	"LATITUDE"	NUMBER		NOT NULL,
	"LONGITUDE"	NUMBER		NOT NULL,
	"VISIT_METHOD"	VARCHAR2(1000)		NOT NULL,
	"ATTRACTION_HOMEPAGE"	VARCHAR2(500)		NULL,
	"ATTRACTION_START_TIME"	DATE		NULL,
	"ATTRACTION_END_TIME"	DATE		NULL,
	"ATTRACTION_STATUS"	CHAR	DEFAULT 'Y'	NOT NULL,
	"ATTRACTION_PHOTO"	VARCHAR2(500)		NOT NULL,
	"ATTRACTION_TYPE_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "ATTRACTION_INFO"."ATTRACTION_NO" IS '명소 게시글 번호';
COMMENT ON COLUMN "ATTRACTION_INFO"."ATTRACTION_NM" IS '명소 이름';
COMMENT ON COLUMN "ATTRACTION_INFO"."ATTRACTION_ADDR" IS '명소 주소';
COMMENT ON COLUMN "ATTRACTION_INFO"."ATTRACTION_PHONE" IS '명소 연락처';
COMMENT ON COLUMN "ATTRACTION_INFO"."ATTRACTION_INFO" IS '명소 정보';
COMMENT ON COLUMN "ATTRACTION_INFO"."LATITUDE" IS '위도';
COMMENT ON COLUMN "ATTRACTION_INFO"."LONGITUDE" IS '경도';
COMMENT ON COLUMN "ATTRACTION_INFO"."VISIT_METHOD" IS '방문 방법';
COMMENT ON COLUMN "ATTRACTION_INFO"."ATTRACTION_HOMEPAGE" IS '명소 홈페이지';
COMMENT ON COLUMN "ATTRACTION_INFO"."ATTRACTION_START_TIME" IS '이용시작시간';
COMMENT ON COLUMN "ATTRACTION_INFO"."ATTRACTION_END_TIME" IS '이용종료시간';
COMMENT ON COLUMN "ATTRACTION_INFO"."ATTRACTION_STATUS" IS '명소 상태';
COMMENT ON COLUMN "ATTRACTION_INFO"."ATTRACTION_PHOTO" IS '명소 사진';
COMMENT ON COLUMN "ATTRACTION_INFO"."ATTRACTION_TYPE_NO" IS '명소 종류 번호';

------------------------------------------------------------------------------------------
-- 명소 종류 테이블
------------------------------------------------------------------------------------------
DROP TABLE "ATTRACTION_TYPE";

CREATE TABLE "ATTRACTION_TYPE" (
	"ATTRACTION_TYPE_NO"	NUMBER		NOT NULL,
	"ATTRACTION_TYPE_NM"	VARCHAR2(100)		NOT NULL
);

COMMENT ON COLUMN "ATTRACTION_TYPE"."ATTRACTION_TYPE_NO" IS '명소 종류 번호';
COMMENT ON COLUMN "ATTRACTION_TYPE"."ATTRACTION_TYPE_NM" IS '명소 구분';

------------------------------------------------------------------------------------------
-- 리뷰 테이블
------------------------------------------------------------------------------------------
DROP TABLE "REVIEW";

CREATE TABLE "REVIEW" (
	"REVIEW_NO"	NUMBER		NOT NULL,
	"REVIEW_POINT"	NUMBER	DEFAULT 0	NOT NULL,
	"REVIEW_CONTENT"	VARCHAR2(1000)		NOT NULL,
	"REVIEW_CREATE_DT"	TIMESTAMP	DEFAULT SYSTIMESTAMP	NOT NULL,
	"REVIEW_STATUS"	CHAR(1)	DEFAULT 'Y' CHECK(REVIEW_STATUS IN('Y','N'))	NOT NULL,
	"ATTRACTION_NO"	NUMBER		NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "REVIEW"."REVIEW_NO" IS '리뷰게시글 번호';
COMMENT ON COLUMN "REVIEW"."REVIEW_POINT" IS '리뷰 별점';
COMMENT ON COLUMN "REVIEW"."REVIEW_CONTENT" IS '리뷰게시글 내용';
COMMENT ON COLUMN "REVIEW"."REVIEW_CREATE_DT" IS '리뷰게시글 작성일';
COMMENT ON COLUMN "REVIEW"."REVIEW_STATUS" IS '리뷰게시글 글상태(Y:등록/N:삭제)';
COMMENT ON COLUMN "REVIEW"."ATTRACTION_NO" IS '명소 게시글 번호';
COMMENT ON COLUMN "REVIEW"."MEMBER_NO" IS '회원번호';

------------------------------------------------------------------------------------------
-- 리뷰 이미지 테이블
------------------------------------------------------------------------------------------
DROP TABLE "REVIEW_IMAGE";

CREATE TABLE "REVIEW_IMAGE" (
	"FILE_NO"	NUMBER		NOT NULL,
	"FILE_NM"	VARCHAR2(500)		NOT NULL,
	"FILE_PATH"	VARCHAR2(100)		NOT NULL,
	"REVIEW_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "REVIEW_IMAGE"."FILE_NO" IS '리뷰이미지 파일번호';
COMMENT ON COLUMN "REVIEW_IMAGE"."FILE_NM" IS '리뷰이미지 파일명';
COMMENT ON COLUMN "REVIEW_IMAGE"."FILE_PATH" IS '리뷰이미지 파일경로';
COMMENT ON COLUMN "REVIEW_IMAGE"."REVIEW_NO" IS '리뷰게시글 번호';

------------------------------------------------------------------------------------------
-- 리뷰 추천 테이블
------------------------------------------------------------------------------------------
DROP TABLE "RECOMMENDATION";

CREATE TABLE "RECOMMENDATION" (
	"MEMBER_NO"	NUMBER		NOT NULL,
	"REVIEW_NO"	NUMBER		NOT NULL,
	"RECOMMEND_STATUS"	CHAR(1) CHECK(RECOMMEND_STATUS IN('R','N'))	NOT NULL
);

COMMENT ON COLUMN "RECOMMENDATION"."MEMBER_NO" IS '회원번호';
COMMENT ON COLUMN "RECOMMENDATION"."REVIEW_NO" IS '리뷰게시글 번호';
COMMENT ON COLUMN "RECOMMENDATION"."RECOMMEND_STATUS" IS '리뷰게시글 추천상태(R:추천/N:비추천)';

------------------------------------------------------------------------------------------
-- 자유게시판 테이블
------------------------------------------------------------------------------------------
DROP TABLE "FREE_BOARD";

CREATE TABLE "FREE_BOARD" (
	"FREE_NO"	NUMBER		NOT NULL,
	"FREE_TITLE"	VARCHAR2(200)		NOT NULL,
	"FREE_CONTENT"	VARCHAR2(4000)		NOT NULL,
	"FREE_READ_COUNT"	NUMBER	DEFAULT 0	NOT NULL,
	"FREE_STATUS"	CHAR(1)	DEFAULT 'Y' CHECK(FREE_STATUS IN('Y','N')) 	NOT NULL,
	"FREE_CREATE_DT"	TIMESTAMP	DEFAULT SYSTIMESTAMP	NOT NULL,
	"FREE_MODIFY_DT"	TIMESTAMP	DEFAULT SYSTIMESTAMP	NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
	"FREE_CATEGORY_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "FREE_BOARD"."FREE_NO" IS '자유게시판 글번호';
COMMENT ON COLUMN "FREE_BOARD"."FREE_TITLE" IS '자유게시판 글제목';
COMMENT ON COLUMN "FREE_BOARD"."FREE_CONTENT" IS '자유게시판 글내용';
COMMENT ON COLUMN "FREE_BOARD"."FREE_READ_COUNT" IS '자유게시판 조회수';
COMMENT ON COLUMN "FREE_BOARD"."FREE_STATUS" IS '자유게시판 글상태(Y:등록/N:삭제)';
COMMENT ON COLUMN "FREE_BOARD"."FREE_CREATE_DT" IS '자유게시판 글 작성일자';
COMMENT ON COLUMN "FREE_BOARD"."FREE_MODIFY_DT" IS '자유게시판 글 수정일자';
COMMENT ON COLUMN "FREE_BOARD"."MEMBER_NO" IS '회원번호';
COMMENT ON COLUMN "FREE_BOARD"."FREE_CATEGORY_NO" IS '자유게시판 카테고리번호';

------------------------------------------------------------------------------------------
-- 자유게시판 카테고리 테이블
------------------------------------------------------------------------------------------
DROP TABLE "FREE_CATEGORY";

CREATE TABLE "FREE_CATEGORY" (
	"FREE_CATEGORY_NO"	NUMBER		NOT NULL,
	"FREE_CATEGORY_NM"	VARCHAR2(100)		NOT NULL
);

COMMENT ON COLUMN "FREE_CATEGORY"."FREE_CATEGORY_NO" IS '자유게시판 카테고리번호';
COMMENT ON COLUMN "FREE_CATEGORY"."FREE_CATEGORY_NM" IS '자유게시판 카테고리이름';

------------------------------------------------------------------------------------------
-- 자유게시판 댓글 테이블
------------------------------------------------------------------------------------------
DROP TABLE "FREE_REPLY";

CREATE TABLE "FREE_REPLY" (
	"FREE_REPLY_NO"	NUMBER		NOT NULL,
	"FREE_REPLY_CONTENT"	VARCHAR2(2000)		NOT NULL,
	"FREE_REPLY_CREATE_DT"	TIMESTAMP	DEFAULT SYSTIMESTAMP	NOT NULL,
	"FREE_REPLY_STATUS"	CHAR(1)	DEFAULT 'Y' CHECK(FREE_REPLY_STATUS IN('Y','N','M'))	 NOT NULL,
	"FREE_NO"	NUMBER		NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
	"PARENT_REPLY_NO"	NUMBER		NULL
);

COMMENT ON COLUMN "FREE_REPLY"."FREE_REPLY_NO" IS '자유게시판 댓글번호';
COMMENT ON COLUMN "FREE_REPLY"."FREE_REPLY_CONTENT" IS '자유게시판 댓글내용';
COMMENT ON COLUMN "FREE_REPLY"."FREE_REPLY_CREATE_DT" IS '자유게시판 댓글 작성일자';
COMMENT ON COLUMN "FREE_REPLY"."FREE_REPLY_STATUS" IS '자유게시판 댓글상태(Y:등록/N:삭제/수정:M)';
COMMENT ON COLUMN "FREE_REPLY"."FREE_NO" IS '자유게시판 글번호';
COMMENT ON COLUMN "FREE_REPLY"."MEMBER_NO" IS '회원번호';
COMMENT ON COLUMN "FREE_REPLY"."PARENT_REPLY_NO" IS '자유게시판 댓글번호';

------------------------------------------------------------------------------------------
-- 자유게시판 이미지 테이블
------------------------------------------------------------------------------------------
DROP TABLE "FREE_IMAGE";

CREATE TABLE "FREE_IMAGE" (
	"FILE_NO"	NUMBER		NOT NULL,
	"FILE_NM"	VARCHAR2(500)		NOT NULL,
	"FILE_PATH"	VARCHAR2(100)		NOT NULL,
	"FREE_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "FREE_IMAGE"."FILE_NO" IS '자유게시판 파일번호';
COMMENT ON COLUMN "FREE_IMAGE"."FILE_NM" IS '자유게시판 파일명';
COMMENT ON COLUMN "FREE_IMAGE"."FILE_PATH" IS '자유게시판 파일경로';
COMMENT ON COLUMN "FREE_IMAGE"."FREE_NO" IS '자유게시판 글번호';

------------------------------------------------------------------------------------------
-- 자유게시판 좋아요 테이블
------------------------------------------------------------------------------------------
DROP TABLE "FREE_LIKE";

CREATE TABLE "FREE_LIKE" (
	"FREE_NO"	NUMBER		NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "FREE_LIKE"."FREE_NO" IS '자유게시판 글번호';
COMMENT ON COLUMN "FREE_LIKE"."MEMBER_NO" IS '회원번호';

------------------------------------------------------------------------------------------
-- 문의게시판 테이블
------------------------------------------------------------------------------------------
DROP TABLE "QNA_BOARD";

CREATE TABLE "QNA_BOARD" (
	"QNA_NO"	NUMBER		NOT NULL,
	"QNA_PNO"	NUMBER		NULL,
	"QNA_TITLE"	VARCHAR2(200)		NOT NULL,
	"QNA_CONTENT"	VARCHAR2(4000)		NOT NULL,
	"QNA_READ_COUNT"	NUMBER	DEFAULT 0	NOT NULL,
	"QNA_CREATE_DT"	TIMESTAMP	DEFAULT SYSTIMESTAMP	NOT NULL,
	"QNA_MODIFY_DT"	TIMESTAMP	DEFAULT SYSTIMESTAMP	NOT NULL,
	"QNA_STATUS"	CHAR(1)	DEFAULT 'Y' CHECK(QNA_STATUS IN('Y','N','S'))	 NOT NULL,
	"QNA_CATEGORY_NO"	NUMBER		NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "QNA_BOARD"."QNA_NO" IS '문의게시글 번호';
COMMENT ON COLUMN "QNA_BOARD"."QNA_PNO" IS '문의 부모게시글 번호';
COMMENT ON COLUMN "QNA_BOARD"."QNA_TITLE" IS '문의게시글 제목';
COMMENT ON COLUMN "QNA_BOARD"."QNA_CONTENT" IS '문의게시글 내용';
COMMENT ON COLUMN "QNA_BOARD"."QNA_READ_COUNT" IS '문의 게시글 조회수';
COMMENT ON COLUMN "QNA_BOARD"."QNA_CREATE_DT" IS '문의 게시글 작성일';
COMMENT ON COLUMN "QNA_BOARD"."QNA_MODIFY_DT" IS '문의게시글 수정일';
COMMENT ON COLUMN "QNA_BOARD"."QNA_STATUS" IS '문의게시글 상태(Y:등록/N:삭제/S:비공개)';
COMMENT ON COLUMN "QNA_BOARD"."QNA_CATEGORY_NO" IS '문의게시글 말머리 코드';
COMMENT ON COLUMN "QNA_BOARD"."MEMBER_NO" IS '회원번호';

------------------------------------------------------------------------------------------
-- 문의 게시판 카테고리 테이블
------------------------------------------------------------------------------------------
DROP TABLE "QNA_CATEGORY";

CREATE TABLE "QNA_CATEGORY" (
	"QNA_CATEGORY_NO"	NUMBER		NOT NULL,
	"QNA_CATEGORY_NM"	VARCHAR2(30)		NOT NULL
);

COMMENT ON COLUMN "QNA_CATEGORY"."QNA_CATEGORY_NO" IS '문의게시글 카테고리번호';
COMMENT ON COLUMN "QNA_CATEGORY"."QNA_CATEGORY_NM" IS '문의게시글 카테고리이름';

------------------------------------------------------------------------------------------
-- 문의게시판 댓글 테이블
------------------------------------------------------------------------------------------
DROP TABLE "QNA_REPLY";

CREATE TABLE "QNA_REPLY" (
	"QNA_REPLY_NO"	NUMBER		NOT NULL,
	"QNA_REPLY_CONTENT"	CLOB		NOT NULL,
	"QNA_REPLY_CREATE_DT"	TIMESTAMP	DEFAULT SYSTIMESTAMP	NOT NULL,
	"QNA_REPLY_STATUS"	CHAR(1)	CHECK(QNA_REPLY_STATUS IN('Y','N','M'))	NOT NULL,
	"QNA_NO"	NUMBER		NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "QNA_REPLY"."QNA_REPLY_NO" IS '문의게시글 댓글 번호';
COMMENT ON COLUMN "QNA_REPLY"."QNA_REPLY_CONTENT" IS '문의게시글 댓글 내용';
COMMENT ON COLUMN "QNA_REPLY"."QNA_REPLY_CREATE_DT" IS '문의게시글 댓글 작성일';
COMMENT ON COLUMN "QNA_REPLY"."QNA_REPLY_STATUS" IS '문의게시글  댓글상태(Y:등록/N:삭제/수정:M)';
COMMENT ON COLUMN "QNA_REPLY"."QNA_NO" IS '문의게시글 번호';
COMMENT ON COLUMN "QNA_REPLY"."MEMBER_NO" IS '회원번호';

------------------------------------------------------------------------------------------
-- 신고 테이블
------------------------------------------------------------------------------------------
DROP TABLE "REPORT";

CREATE TABLE "REPORT" (
	"REPORT_NO"	NUMBER		NOT NULL,
	"REPORT_TITLE"	VARCHAR2(200)		NOT NULL,
	"REPORT_CONTENT"	VARCHAR2(4000)		NOT NULL,
	"REPORT_CREATE_DT"	TIMESTAMP	DEFAULT SYSTIMESTAMP	NOT NULL,
	"REPORT_STATUS"	CHAR(1)	DEFAULT 'Y' CHECK(REPORT_STATUS IN('Y','N'))	NOT NULL,
	"REPORT_TYPE"	NUMBER CHECK(REPORT_TYPE IN('1','2'))	NOT NULL,
	"REPORT_TYPE_NO"	NUMBER		NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
	"REPORT_CATEGORY_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "REPORT"."REPORT_NO" IS '신고번호';
COMMENT ON COLUMN "REPORT"."REPORT_TITLE" IS '신고제목';
COMMENT ON COLUMN "REPORT"."REPORT_CONTENT" IS '신고내용';
COMMENT ON COLUMN "REPORT"."REPORT_CREATE_DT" IS '신고 작성일';
COMMENT ON COLUMN "REPORT"."REPORT_STATUS" IS '신고글상태(Y:등록/N:삭제)';
COMMENT ON COLUMN "REPORT"."REPORT_TYPE" IS '게시글 :1 , 댓글 : 2';
COMMENT ON COLUMN "REPORT"."REPORT_TYPE_NO" IS '게시글 또는 댓글 번호';
COMMENT ON COLUMN "REPORT"."MEMBER_NO" IS '회원번호';
COMMENT ON COLUMN "REPORT"."REPORT_CATEGORY_NO" IS '신고카테고리 코드';

------------------------------------------------------------------------------------------
-- 신고 카테고리 테이블
------------------------------------------------------------------------------------------
DROP TABLE "REPORT_CATEGORY";

CREATE TABLE "REPORT_CATEGORY" (
	"REPORT_CATEGORY_NO"	NUMBER		NOT NULL,
	"REPORT_CATEGORY_NM"	VARCHAR2(20)		NOT NULL
);

COMMENT ON COLUMN "REPORT_CATEGORY"."REPORT_CATEGORY_NO" IS '신고카테고리 코드';
COMMENT ON COLUMN "REPORT_CATEGORY"."REPORT_CATEGORY_NM" IS '신고카테고리 이름';

------------------------------------------------------------------------------------------
-- 채팅내역 테이블
------------------------------------------------------------------------------------------
DROP TABLE "CHAT_MESSAGE";

CREATE TABLE "CHAT_MESSAGE" (
	"CHAT_NO"	NUMBER		NOT NULL,
	"CHAT_CONTENT"	VARCHAR2(4000)		NOT NULL,
	"CHAT_CREATE_DT"	TIMESTAMP	DEFAULT SYSTIMESTAMP	NOT NULL,
	"CHAT_READ_YN"	CHAR(1)	DEFAULT 'N'	CHECK(CHAT_READ_YN IN('N','Y')) NOT NULL,
	"CHAT_ROOM_NO"	NUMBER		NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "CHAT_MESSAGE"."CHAT_NO" IS '채팅 번호';
COMMENT ON COLUMN "CHAT_MESSAGE"."CHAT_CONTENT" IS '채팅 내용';
COMMENT ON COLUMN "CHAT_MESSAGE"."CHAT_CREATE_DT" IS '채팅 작성일';
COMMENT ON COLUMN "CHAT_MESSAGE"."CHAT_READ_YN" IS '채팅 확인여부(N:미확인 Y:확인)';
COMMENT ON COLUMN "CHAT_MESSAGE"."CHAT_ROOM_NO" IS '1:1 채팅방 번호';
COMMENT ON COLUMN "CHAT_MESSAGE"."MEMBER_NO" IS '회원번호';

------------------------------------------------------------------------------------------
-- 채팅방 테이블
------------------------------------------------------------------------------------------
DROP TABLE "CHAT_ROOM";

CREATE TABLE "CHAT_ROOM" (
	"CHAT_ROOM_NO"	NUMBER		NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "CHAT_ROOM"."CHAT_ROOM_NO" IS '1:1 채팅방 번호';
COMMENT ON COLUMN "CHAT_ROOM"."MEMBER_NO" IS '회원번호';


------------------------------------------------------------------------------------------
-- 기본키(PK)
------------------------------------------------------------------------------------------
-- 회원 번호
ALTER TABLE "MEMBER" ADD CONSTRAINT "PK_MEMBER" PRIMARY KEY (
	"MEMBER_NO"
);
-- 자유게시판 번호
ALTER TABLE "FREE_BOARD" ADD CONSTRAINT "PK_FREE_BOARD" PRIMARY KEY (
	"FREE_NO"
);
-- 문의게시판 번호
ALTER TABLE "QNA_BOARD" ADD CONSTRAINT "PK_QNA_BOARD" PRIMARY KEY (
	"QNA_NO"
);
-- 명소정보게시판 번호
ALTER TABLE "ATTRACTION_INFO" ADD CONSTRAINT "PK_ATTRACTION_INFO" PRIMARY KEY (
	"ATTRACTION_NO"
);
-- 후기 이미지 파일 번호
ALTER TABLE "REVIEW_IMAGE" ADD CONSTRAINT "PK_REVIEW_IMAGE" PRIMARY KEY (
	"FILE_NO"
);
-- 추천 번호
ALTER TABLE "RECOMMENDATION" ADD CONSTRAINT "PK_RECOMMENDATION" PRIMARY KEY (
	"MEMBER_NO",
	"REVIEW_NO"
);
-- 신고 번호
ALTER TABLE "REPORT" ADD CONSTRAINT "PK_REPORT" PRIMARY KEY (
	"REPORT_NO"
);
-- 문의게시판 카테고리 번호
ALTER TABLE "QNA_CATEGORY" ADD CONSTRAINT "PK_QNA_CATEGORY" PRIMARY KEY (
	"QNA_CATEGORY_NO"
);
-- 자유게시판 카테고리 번호
ALTER TABLE "FREE_CATEGORY" ADD CONSTRAINT "PK_FREE_CATEGORY" PRIMARY KEY (
	"FREE_CATEGORY_NO"
);
-- 후기 번호
ALTER TABLE "REVIEW" ADD CONSTRAINT "PK_REVIEW" PRIMARY KEY (
	"REVIEW_NO"
);
-- 자유게시판 댓글 번호
ALTER TABLE "FREE_REPLY" ADD CONSTRAINT "PK_FREE_REPLY" PRIMARY KEY (
	"FREE_REPLY_NO"
);
-- 자유게시판 이미지 파일 번호
ALTER TABLE "FREE_IMAGE" ADD CONSTRAINT "PK_FREE_IMAGE" PRIMARY KEY (
	"FILE_NO"
);
-- 문의게시판 댓글 번호
ALTER TABLE "QNA_REPLY" ADD CONSTRAINT "PK_QNA_REPLY" PRIMARY KEY (
	"QNA_REPLY_NO"
);
-- 자유게시판 좋아요 번호
ALTER TABLE "FREE_LIKE" ADD CONSTRAINT "PK_FREE_LIKE" PRIMARY KEY (
	"FREE_NO",
	"MEMBER_NO"
);
-- 명소 종류 번호
ALTER TABLE "ATTRACTION_TYPE" ADD CONSTRAINT "PK_ATTRACTION_TYPE" PRIMARY KEY (
	"ATTRACTION_TYPE_NO"
);
-- 명소 담당자 번호(복합키)
ALTER TABLE "MANAGER" ADD CONSTRAINT "PK_MANAGER" PRIMARY KEY (
	"MEMBER_NO",
	"ATTRACTION_NO"
);
-- 신고 카테고리 번호
ALTER TABLE "REPORT_CATEGORY" ADD CONSTRAINT "PK_REPORT_CATEGORY" PRIMARY KEY (
	"REPORT_CATEGORY_NO"
);
-- 채팅 내역 번호
ALTER TABLE "CHAT_MESSAGE" ADD CONSTRAINT "PK_CHAT_MESSAGE" PRIMARY KEY (
	"CHAT_NO"
);
-- 채팅방 번호(복합키)
ALTER TABLE "CHAT_ROOM" ADD CONSTRAINT "PK_CHAT_ROOM" PRIMARY KEY (
	"CHAT_ROOM_NO",
	"MEMBER_NO"
);

------------------------------------------------------------------------------------------
-- 외래키(FK) ... 설명 생략 ^^.. (긴 이름들은 짧게 줄임)
-- MEMBER -> MEM / BOARD -> BD / CATEGORY -> CT
-- FREE -> FR / QNA -> Q / REPLY -> R
-- ATTRACTION -> AT / TYPE -> TP / INFO -> IF
-- REVIEW -> RE / IMAGE -> IM
-- RECOMMENDATION -> RECO / LIKE -> LK
-- REPORT -> RP / MANAGER -> MN
-- CHAT -> CH / ROOM -> RM / MESSAGE -> MS
------------------------------------------------------------------------------------------
ALTER TABLE "FREE_BOARD" ADD CONSTRAINT "FK_MEM_TO_FR_BD_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "FREE_BOARD" ADD CONSTRAINT "FK_FR_CT_TO_FR_BD_1" FOREIGN KEY (
	"FREE_CATEGORY_NO"
)
REFERENCES "FREE_CATEGORY" (
	"FREE_CATEGORY_NO"
);

ALTER TABLE "QNA_BOARD" ADD CONSTRAINT "FK_Q_BD_TO_Q_BD_1" FOREIGN KEY (
	"QNA_PNO"
)
REFERENCES "QNA_BOARD" (
	"QNA_NO"
);

ALTER TABLE "QNA_BOARD" ADD CONSTRAINT "FK_Q_CT_TO_Q_BD_1" FOREIGN KEY (
	"QNA_CATEGORY_NO"
)
REFERENCES "QNA_CATEGORY" (
	"QNA_CATEGORY_NO"
);

ALTER TABLE "QNA_BOARD" ADD CONSTRAINT "FK_MEM_TO_Q_BD_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "ATTRACTION_INFO" ADD CONSTRAINT "FK_ATTP_TO_ATIF_1" FOREIGN KEY (
	"ATTRACTION_TYPE_NO"
)
REFERENCES "ATTRACTION_TYPE" (
	"ATTRACTION_TYPE_NO"
);

ALTER TABLE "REVIEW_IMAGE" ADD CONSTRAINT "FK_RE_TO_RE_IM_1" FOREIGN KEY (
	"REVIEW_NO"
)
REFERENCES "REVIEW" (
	"REVIEW_NO"
);

ALTER TABLE "RECOMMENDATION" ADD CONSTRAINT "FK_MEM_TO_RECO_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "RECOMMENDATION" ADD CONSTRAINT "FK_RE_TO_RECO_1" FOREIGN KEY (
	"REVIEW_NO"
)
REFERENCES "REVIEW" (
	"REVIEW_NO"
);

ALTER TABLE "REPORT" ADD CONSTRAINT "FK_MEM_TO_RP_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "REPORT" ADD CONSTRAINT "FK_RP_CT_TO_RP_1" FOREIGN KEY (
	"REPORT_CATEGORY_NO"
)
REFERENCES "REPORT_CATEGORY" (
	"REPORT_CATEGORY_NO"
);

ALTER TABLE "REVIEW" ADD CONSTRAINT "FK_AT_IN_TO_RE_1" FOREIGN KEY (
	"ATTRACTION_NO"
)
REFERENCES "ATTRACTION_INFO" (
	"ATTRACTION_NO"
);

ALTER TABLE "REVIEW" ADD CONSTRAINT "FK_MEM_TO_RE_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "FREE_REPLY" ADD CONSTRAINT "FK_FRBD_TO_FRR_1" FOREIGN KEY (
	"FREE_NO"
)
REFERENCES "FREE_BOARD" (
	"FREE_NO"
);

ALTER TABLE "FREE_REPLY" ADD CONSTRAINT "FK_MEM_TO_FR_R_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "FREE_REPLY" ADD CONSTRAINT "FK_FR_R_TO_FR_R_1" FOREIGN KEY (
	"PARENT_REPLY_NO"
)
REFERENCES "FREE_REPLY" (
	"FREE_REPLY_NO"
);

ALTER TABLE "FREE_IMAGE" ADD CONSTRAINT "FK_FRBD_TO_FRIM_1" FOREIGN KEY (
	"FREE_NO"
)
REFERENCES "FREE_BOARD" (
	"FREE_NO"
);

ALTER TABLE "QNA_REPLY" ADD CONSTRAINT "FK_Q_BD_TO_Q_R_1" FOREIGN KEY (
	"QNA_NO"
)
REFERENCES "QNA_BOARD" (
	"QNA_NO"
);

ALTER TABLE "QNA_REPLY" ADD CONSTRAINT "FK_MEM_TO_Q_R_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "FREE_LIKE" ADD CONSTRAINT "FK_FRBD_TO_FRLK_1" FOREIGN KEY (
	"FREE_NO"
)
REFERENCES "FREE_BOARD" (
	"FREE_NO"
);

ALTER TABLE "FREE_LIKE" ADD CONSTRAINT "FK_MEM_TO_FR_LK_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "MANAGER" ADD CONSTRAINT "FK_MEM_TO_MN_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "MANAGER" ADD CONSTRAINT "FK_AT_IN_TO_MN_1" FOREIGN KEY (
	"ATTRACTION_NO"
)
REFERENCES "ATTRACTION_INFO" (
	"ATTRACTION_NO"
);

ALTER TABLE "CHAT_ROOM" ADD CONSTRAINT "FK_MEM_TO_CT_RM_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "CHAT_MESSAGE" ADD CONSTRAINT "FK_CHRM_TO_CH_MS_1" FOREIGN KEY (
	"CHAT_ROOM_NO",
    "MEMBER_NO"
)
REFERENCES "CHAT_ROOM" (
	"CHAT_ROOM_NO",
    "MEMBER_NO"
);

--ALTER TABLE "CHAT_MESSAGE" ADD CONSTRAINT "FK_CHRM_TO_CH_MS_2" FOREIGN KEY (
--	"MEMBER_NO"
--)
--REFERENCES "CHAT_ROOM" (
--	"MEMBER_NO"
--);

---------------------------------------------------------------------------------------------------------
-- 시퀀스
---------------------------------------------------------------------------------------------------------
-- 회원번호
CREATE SEQUENCE SEQ_MNO;
DROP SEQUENCE SEQ_MNO;

-- 명소 번호
CREATE SEQUENCE SEQ_ATNO;
DROP SEQUENCE SEQ_ATNO;

-- 명소 리뷰 번호
CREATE SEQUENCE SEQ_RE_NO;
DROP SEQUENCE SEQ_RE_NO;

-- 명소 리뷰 이미지 번호
CREATE SEQUENCE SEQ_RE_INO;
DROP SEQUENCE SEQ_RE_INO;

-- 자유게시판 글번호
CREATE SEQUENCE SEQ_FRNO;
DROP SEQUENCE SEQ_FRNO;

-- 자유게시판 이미지 번호
CREATE SEQUENCE SEQ_FR_INO;
DROP SEQUENCE SEQ_FR_INO;

-- 자유게시판 댓글 번호
CREATE SEQUENCE SEQ_FR_RNO;
DROP SEQUENCE SEQ_FR_RNO;

-- 문의게시판 번호
CREATE SEQUENCE SEQ_QNO;
DROP SEQUENCE SEQ_QNO;

-- 문의게시판 댓글 번호
CREATE SEQUENCE SEQ_Q_RNO;
DROP SEQUENCE SEQ_Q_RNO;

-- 신고번호
CREATE SEQUENCE SEQ_RPNO;
DROP SEQUENCE SEQ_RPNO;

-- 채팅방 번호
CREATE SEQUENCE SEQ_CR_NO;
DROP SEQUENCE SEQ_CR_NO;

-- 채팅내역 번호
CREATE SEQUENCE SEQ_CM_NO;
DROP SEQUENCE SEQ_CM_NO;

---------------------------------------------------------------------------------------------------------
-- 이 아래부터는 VIEW 작성해주시면 됩니다. (또는 추가할 시퀀스라던지...) 윗부분에는 되도록 추가 X !
---------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------07/31 추가

-- 자유게시판 카테고리 샘플
INSERT INTO FREE_CATEGORY VALUES(1, '잡담');
INSERT INTO FREE_CATEGORY VALUES(2, '추천');
INSERT INTO FREE_CATEGORY VALUES(3, '궁금');
INSERT INTO FREE_CATEGORY VALUES(4, '같이');
INSERT INTO FREE_CATEGORY VALUES(5, '기타');

SET SERVEROUTPUT ON;

-- 자유게시판 게시글 샘플
BEGIN
    FOR N IN 1..100 LOOP
        INSERT INTO FREE_BOARD
        VALUES(SEQ_FRNO.NEXTVAL,
                    N || '번째 게시글',
                    N || '번째 게시글 내용',
                    DEFAULT, DEFAULT, DEFAULT, DEFAULT, 999,
                    FLOOR(DBMS_RANDOM.VALUE(1,6)));
    END LOOP;
END;
/

COMMIT;

-- 자유게시판 목록 조회를 위한 VIEW
CREATE OR REPLACE VIEW FREE_LIST AS
    SELECT FREE_NO, FREE_CATEGORY_NM, FREE_TITLE, MEMBER_NICK, FREE_CREATE_DT, FREE_READ_COUNT,
               NVL(REPLY_COUNT, 0) REPLY_COUNT, NVL(LIKE_COUNT, 0) LIKE_COUNT,
               FREE_STATUS
    FROM FREE_BOARD
    JOIN FREE_CATEGORY USING(FREE_CATEGORY_NO)
    JOIN MEMBER USING(MEMBER_NO)
    LEFT JOIN (SELECT FREE_NO, COUNT(*) REPLY_COUNT
                    FROM FREE_REPLY
                    GROUP BY FREE_NO) USING(FREE_NO)
    LEFT JOIN (SELECT FREE_NO, COUNT(*) LIKE_COUNT
                    FROM FREE_LIKE
                    GROUP BY FREE_NO) USING(FREE_NO)
;
---------------------------------------------------------------------------------------------------------
-- By 지원.
-- MEMBER 테이블 MEMBER_NM 컬럼 삭제
ALTER TABLE MEMBER DROP COLUMN MEMBER_NM;

-- MEMBER 테이블 MEMBER_GRADE 컬럼 CHECK 제약 조건 추가 
ALTER TABLE MEMBER
DROP CONSTRAINT SYS_C008250;

ALTER TABLE MEMBER
ADD CONSTRAINT SYS_C008250 check ("MEMBER_GRADE" IN('B', 'A', 'M', 'G', 'N', 'K'));

-- MEMBER 테이블 MEMBER_GRADE 컬럼 CHECK 제약 조건 COMMENT 수정
COMMENT ON COLUMN MEMBER.MEMBER_GRADE  IS '회원등급(일반B/관리자A/담딩자M/구글G/네이버N/카카오K)';

-- MEMBER 테이블 SEQ_MNO 시퀀스 생성 
CREATE SEQUENCE SEQ_MNO;

COMMIT;

