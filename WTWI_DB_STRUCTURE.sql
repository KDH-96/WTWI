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
	"ATTRACTION_NM"	VARCHAR2(100)		NOT NULL
);

COMMENT ON COLUMN "ATTRACTION_INFO"."ATTRACTION_NO" IS '명소 게시글 번호';
COMMENT ON COLUMN "ATTRACTION_INFO"."ATTRACTION_NM" IS '명소 이름';

------------------------------------------------------------------------------------------
-- 명소 종류 테이블
------------------------------------------------------------------------------------------
--DROP TABLE "ATTRACTION_TYPE";

--CREATE TABLE "ATTRACTION_TYPE" (
--	"ATTRACTION_TYPE_NO"	NUMBER		NOT NULL,
--	"ATTRACTION_TYPE_NM"	VARCHAR2(100)		NOT NULL
--);

--COMMENT ON COLUMN "ATTRACTION_TYPE"."ATTRACTION_TYPE_NO" IS '명소 종류 번호';
--COMMENT ON COLUMN "ATTRACTION_TYPE"."ATTRACTION_TYPE_NM" IS '명소 구분';

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
--ALTER TABLE "ATTRACTION_TYPE" ADD CONSTRAINT "PK_ATTRACTION_TYPE" PRIMARY KEY (
--	"ATTRACTION_TYPE_NO"
--);
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

--ALTER TABLE "ATTRACTION_INFO" ADD CONSTRAINT "FK_ATTP_TO_ATIF_1" FOREIGN KEY (
--	"ATTRACTION_TYPE_NO"
--)
--REFERENCES "ATTRACTION_TYPE" (
--	"ATTRACTION_TYPE_NO"
--);

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

-- 문의게시판 글번호
--CREATE SEQUENCE SEQ_QNO;
--DROP SEQUENCE SEQ_QNO;
CREATE SEQUENCE SEQ_QBNO;
DROP SEQUENCE SEQ_QBNO;

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
                    '21년 8월 8일 작성한 ' || N || '번째 게시글',
                    '21년 8월 8일 작성한 ' || N || '번째 게시글 내용',
                    DEFAULT, DEFAULT, DEFAULT, DEFAULT, 1,
                    FLOOR(DBMS_RANDOM.VALUE(1,6)));
    END LOOP;
END;
/

COMMIT;

-- 자유게시판 목록 조회를 위한 VIEW
--삭제

---------------------------------------------------------------------------------------------------------
-- 지원
-- MEMBER 테이블 MEMBER_NM 컬럼 삭제
ALTER TABLE MEMBER DROP COLUMN MEMBER_NM;

-- MEMBER 테이블 MEMBER_GRADE 컬럼 CHECK 제약 조건 추가 
-- 각 컴퓨터마다 제약조건명이 다르니 확인해서 SYS_C007634 자리에 넣어주시면 됩니다!
--ALTER TABLE MEMBER ADD CONSTRAINT SYS_C0012618 check ("MEMBER_GRADE" IN('B', 'A', 'M', 'G', 'N', 'K'));

-- MEMBER 테이블 MEMBER_GRADE 컬럼 CHECK 제약 조건 COMMENT 수정
COMMENT ON COLUMN MEMBER.MEMBER_GRADE  IS '회원등급(일반B/관리자A/담딩자M/구글G/네이버N/카카오K)';

COMMIT;

-----------------------------------------------------------------------------------------------08/02 추가

-- 자유게시판 상세 조회를 위한 VIEW
--

-----------------------------------------------------------------------------------------------08/03 추가
-- 지원
-- MEMBER 테이블 MEMBER_GRADE 컬럼 DEFAULT 값 변경(일반회원 = 'B')
ALTER TABLE MEMBER MODIFY (MEMBER_GRADE DEFAULT 'B');

COMMIT;


-- 세은
-- 자유게시판 목록 조회를 위한 VIEW 생성 구문에 변동이 있습니다. 
-- 07/31 작성한 구문은 삭제했으며, 아래 구문으로 다시 실행해주세요!

-- 자유게시판 목록 조회를 위한 VIEW
--삭제

-----------------------------------------------------------------------------------------------08/04 추가

-- 문의게시판 view 생성 및 샘플데이터 삽입(도헌)

-- PL/SQL을 이용한 게시판 샘플 데이터 500개 생성
CREATE SEQUENCE SEQ_QBNO;

-- 문의게시판 카테고리 샘플
INSERT INTO QNA_CATEGORY VALUES(1,'명소 정보');
INSERT INTO QNA_CATEGORY VALUES(2,'시스템');
INSERT INTO QNA_CATEGORY VALUES(3,'기타');
COMMIT;

SET SERVEROUTPUT ON;

-- 문의게시판 게시글 샘플(맨 뒤의 1은 회원번호)
BEGIN
    FOR N IN 1..100 LOOP
        INSERT INTO QNA_BOARD
        VALUES(SEQ_QBNO.NEXTVAL,NULL,
                    '21년 8월 8일 작성한 ' || N || '번째 게시글',
                    '21년 8월 8일 작성한 ' || N || '번째 게시글 입니다.',
                    DEFAULT, DEFAULT, DEFAULT, DEFAULT,
                    FLOOR(DBMS_RANDOM.VALUE(1,3)), 1);
    END LOOP;
END;
/
COMMIT;

-- 문의게시판 목록 조회를 위한 VIEW
CREATE OR REPLACE VIEW QNA_LIST AS
    SELECT QNA_NO, QNA_PNO,QNA_CATEGORY_NO, QNA_CATEGORY_NM,
              QNA_TITLE, QNA_CONTENT,
              MEMBER_NO, MEMBER_NICK, MEMBER_GRADE, QNA_CREATE_DT, QNA_READ_COUNT,
               QNA_STATUS
    FROM QNA_BOARD
    JOIN QNA_CATEGORY USING(QNA_CATEGORY_NO)
    JOIN MEMBER USING(MEMBER_NO);

 -- 비공개용 게시글 목록 생성
    INSERT INTO QNA_BOARD
    VALUES(SEQ_QBNO.NEXTVAL,NULL,'비공개샘플제목','비공개샘플내용',DEFAULT,DEFAULT,DEFAULT,'S',2,1);

-- 답글 게시글 생성
    INSERT INTO QNA_BOARD
    VALUES(SEQ_QBNO.NEXTVAL, 503,'답글제목','내용',DEFAULT,DEFAULT,DEFAULT,'S',2,1);

COMMIT;


-- 지원
-- 마이페이지 자유게시판 목록 조회를 위한 VIEW + 컬럼추가(MEMBER_NO)
-- 아래 구문 실행해주시면 됩니다.
--

-----------------------------------------------------------------------------------------------08/05 추가

-- 지원
-- 마이페이지 문의게시판 목록 조회를 위한 VIEW + 컬럼추가(MEMBER_NO)
-- 아래 구문 실행해주시면 됩니다.
CREATE OR REPLACE VIEW QNA_LIST AS
    SELECT QNA_NO, QNA_PNO,QNA_CATEGORY_NO, QNA_CATEGORY_NM, QNA_TITLE, QNA_CONTENT, MEMBER_NICK, QNA_CREATE_DT, QNA_READ_COUNT,
               QNA_STATUS, MEMBER_NO
    FROM QNA_BOARD
    JOIN QNA_CATEGORY USING(QNA_CATEGORY_NO)
    JOIN MEMBER USING(MEMBER_NO);

-- 세은
-- 자유게시판 상세 조회 VIEW 컬럼 추가(MEMBER_NO)
--

-- 지원
-- 1:1 문의내역  조회(명소이름 조회)를 위한 VIEW
CREATE OR REPLACE VIEW CHAT_MANAGER_LIST AS
  SELECT CHAT_ROOM_NO, MEMBER_NO, ATTRACTION_NM
    FROM CHAT_ROOM 
    JOIN MEMBER USING(MEMBER_NO)
    JOIN MANAGER USING(MEMBER_NO)
    JOIN ATTRACTION_INFO USING(ATTRACTION_NO);
    
-----------------------------------------------------------------------------------------------08/07 추가

-- 도헌
-- 문의 게시판 list sql문 수정 - 08/07
-- 문의게시판 목록 조회를 위한 VIEW
CREATE OR REPLACE VIEW QNA_LIST AS
    SELECT QNA_NO, QNA_PNO,QNA_CATEGORY_NO, QNA_CATEGORY_NM,
              QNA_TITLE, QNA_CONTENT,
              MEMBER_NO, MEMBER_NICK, MEMBER_GRADE, QNA_CREATE_DT, QNA_READ_COUNT,
               QNA_STATUS
    FROM QNA_BOARD
    JOIN QNA_CATEGORY USING(QNA_CATEGORY_NO)
    JOIN MEMBER USING(MEMBER_NO);

-- 세은
-- 자유게시판 댓글 조회 VIEW
CREATE OR REPLACE VIEW FREE_REPLY_LIST AS
    SELECT FREE_REPLY_NO, FREE_REPLY_CONTENT, FREE_REPLY_CREATE_DT, FREE_REPLY_STATUS,
              MEMBER_NO, MEMBER_NICK,
              FREE_NO,
              PARENT_REPLY_NO, PARENT_REPLY_NICK
    FROM FREE_REPLY
    JOIN MEMBER USING(MEMBER_NO)
    LEFT JOIN (SELECT FREE_REPLY_NO AS PARENT_REPLY_NO, MEMBER_NICK AS PARENT_REPLY_NICK
                    FROM FREE_REPLY
                    JOIN MEMBER USING(MEMBER_NO)
                    WHERE FREE_REPLY_NO IN(SELECT PARENT_REPLY_NO FROM FREE_REPLY)) USING(PARENT_REPLY_NO)
;

-----------------------------------------------------------------------------------------------08/08 추가

-- 세은
-- 댓글 개수 카운트 컬럼에 조건 추가했습니다. 아래 구문으로 다시 실행해주세요.

-- 자유게시판 상세조회 VIEW(구문 수정)
CREATE OR REPLACE VIEW FREE_DETAIL AS
    SELECT FREE_NO, FREE_CATEGORY_NM, FREE_TITLE, 
               MEMBER_NICK, FREE_READ_COUNT, FREE_CREATE_DT, FREE_MODIFY_DT,
               FREE_CONTENT,
               NVL(LIKE_COUNT, 0) LIKE_COUNT, NVL(REPLY_COUNT, 0) REPLY_COUNT, 
               FREE_STATUS,
               MEMBER_NO
    FROM FREE_BOARD
    JOIN FREE_CATEGORY USING(FREE_CATEGORY_NO)
    JOIN MEMBER USING(MEMBER_NO)
    LEFT JOIN (SELECT FREE_NO, COUNT(*) REPLY_COUNT
                    FROM FREE_REPLY
                    WHERE FREE_REPLY_STATUS<>'N'
                    GROUP 
	       FREE_NO) USING(FREE_NO)
    LEFT JOIN (SELECT FREE_NO, COUNT(*) LIKE_COUNT
                    FROM FREE_LIKE
                    GROUP BY FREE_NO) USING(FREE_NO)
;

-- 자유게시판 목록조회 VIEW (구문 수정)
CREATE OR REPLACE VIEW FREE_LIST AS
    SELECT FREE_NO, FREE_CATEGORY_NM, FREE_TITLE, MEMBER_NICK, FREE_CREATE_DT, FREE_READ_COUNT,
               NVL(REPLY_COUNT, 0) REPLY_COUNT, NVL(LIKE_COUNT, 0) LIKE_COUNT, 
               FREE_STATUS,
               FREE_CONTENT, FREE_CATEGORY_NO,
	       MEMBER_NO
    FROM FREE_BOARD
    JOIN FREE_CATEGORY USING(FREE_CATEGORY_NO)
    JOIN MEMBER USING(MEMBER_NO)
    LEFT JOIN (SELECT FREE_NO, COUNT(*) REPLY_COUNT
                    FROM FREE_REPLY
                    WHERE FREE_REPLY_STATUS<>'N'
                    GROUP BY FREE_NO) USING(FREE_NO)
    LEFT JOIN (SELECT FREE_NO, COUNT(*) LIKE_COUNT
                    FROM FREE_LIKE
                    GROUP BY FREE_NO) USING(FREE_NO)
;

--문의 게시판 댓글 조회용 샘플 데이터[도헌] -- 추가 08/08
    INSERT INTO QNA_REPLY
    VALUES(SEQ_Q_RNO.NEXTVAL, '댓글 테스트1', DEFAULT, 'Y', (SELECT MAX(QNA_NO) FROM QNA_LIST WHERE QNA_STATUS IN('Y','S')),1 );
    INSERT INTO QNA_REPLY
    VALUES(SEQ_Q_RNO.NEXTVAL, '댓글 테스트2', DEFAULT, 'Y', (SELECT MAX(QNA_NO) FROM QNA_LIST WHERE QNA_STATUS IN('Y','S')),1 );
    
COMMIT;


-----------------------------------------------------------------------------------------------08/09 추가

-- 설화
-- Attraction 테이블 위도 / 경도 / 명소타입 컬럼 추가
ALTER TABLE ATTRACTION_INFO ADD (LATITUDE NUMBER );
ALTER TABLE ATTRACTION_INFO ADD (LONGITUDE NUMBER );
ALTER TABLE ATTRACTION_INFO ADD (ATTRACTION_TYPE_NO NUMBER );

COMMIT;

-- 세은
-- 채팅 메세지 조회용 VIEW
CREATE OR REPLACE VIEW CHAT_MESSAGES AS
    SELECT MEMBER_NO, MEMBER_NICK, CHAT_CONTENT, CHAT_CREATE_DT, CHAT_READ_YN, CHAT_ROOM_NO, CHAT_NO
    FROM CHAT_MESSAGE
    JOIN MEMBER USING(MEMBER_NO)
;


-----------------------------------------------------------------------------------------------08/11 추가

-- 지원
-- MEMBER 테이블 체크제약조건 변경 
ALTER TABLE MEMBER DROP CONSTRAINT SYS_C008250;
ALTER TABLE MEMBER ADD CONSTRAINT SYS_C008250 check ("MEMBER_GRADE" IN('B', 'A', 'M', 'G', 'N', 'K', 'F'));
COMMENT ON COLUMN MEMBER.MEMBER_GRADE  IS '회원등급(일반B/관리자A/담딩자M/구글G/네이버N/카카오K/페이스북F)';



-----------------------------------------------------------------------------------------------08/12 추가

-- 설화
-- ATTRACTION 테이블 컬럼 데이터 크기 변경
alter table ATTRACTION_INFO
modify ATTRACTION_NM varchar2(300);



-----------------------------------------------------------------------------------------------08/18 추가

-- 준석
-- 테스트용 ATTRACTION_NO = 127220 북한산
CREATE SEQUENCE SEQ_RNO;

SET SERVEROUTPUT ON;

-- 리뷰 작성 샘플
BEGIN
    FOR N IN 1..100 LOOP
        INSERT INTO REVIEW
        VALUES(SEQ_RNO.NEXTVAL,
                    FLOOR(DBMS_RANDOM.VALUE(1,5)),
                    '21년 8월 10일 작성한 ' || N || '번째 리뷰 내용',
                    DEFAULT,
                    DEFAULT,
                    127220,
                    FLOOR(DBMS_RANDOM.VALUE(1,12)));
    END LOOP;
END;
/

COMMIT;

-------------------------------------------------------

-- 리뷰용 뷰 생성
CREATE OR REPLACE VIEW REVIEW_LIST AS
SELECT REVIEW_NO, REVIEW_POINT, REVIEW_CONTENT, REVIEW_CREATE_DT, REVIEW_STATUS, ATTRACTION_NO, MEMBER_NO, MEMBER_NICK, RECOMMEND, NOT_RECOMMEND
FROM REVIEW
JOIN MEMBER USING(MEMBER_NO)
LEFT JOIN (SELECT REVIEW_NO, COUNT(*) RECOMMEND
    FROM RECOMMENDATION
    WHERE RECOMMEND_STATUS = 'R'
    GROUP BY REVIEW_NO) USING(REVIEW_NO) 
LEFT JOIN (SELECT REVIEW_NO, COUNT(*) NOT_RECOMMEND
    FROM RECOMMENDATION
    WHERE RECOMMEND_STATUS = 'N'
    GROUP BY REVIEW_NO) USING(REVIEW_NO) 
LEFT JOIN (SELECT REVIEW_NO, COUNT(*)
    FROM RECOMMENDATION
    GROUP BY REVIEW_NO) USING(REVIEW_NO);

-- 명소별 리뷰 개수 조회
SELECT COUNT(*) FROM REVIEW_LIST WHERE ATTRACTION_NO = 127220;

-- 명소별 List Count 조회        
SELECT * FROM REVIEW_LIST
WHERE REVIEW_STATUS = 'Y'
AND ATTRACTION_NO = 122334
ORDER BY REVIEW_NO DESC;

-- 명소별 평점(126573 리뷰 없는 명소 / 127220 리뷰 있는 명소)
SELECT NVL(AVG_POINT, 0)AVG_POINT
FROM(SELECT AVG(REVIEW_POINT) AVG_POINT FROM REVIEW
     WHERE ATTRACTION_NO = 127220
     GROUP BY ATTRACTION_NO
     
     UNION ALL
     
     SELECT NULL AVG_POINT
     FROM DUAL)
     WHERE AVG_POINT IS NOT NULL OR ROWNUM = 1;

-- 명소별 리뷰 작성 sql 구문
INSERT INTO REVIEW VALUES(
SEQ_RNO.NEXTVAL, 5, 'TEST', DEFAULT, DEFAULT, 126573, 3);

SELECT * FROM ATTRACTION_INFO where ATTRACTION_NO = 127220 ;
