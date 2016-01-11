/*
Oracle. Selected fields related to individual discussion post or reply status within specified time range.
Use AND parameters to specify student and course.
4/30/15
*/

SELECT 
	MM.SUBJECT AS ITEM_TITLE
	, USERS.USER_ID
	, CM.COURSE_ID
	, MM.POSTED_DATE
	, MM.LAST_EDIT_DATE	
	, MM.LIFECYCLE
  , FORUM_MAIN.NAME AS PARENT_FORUM_TITLE
--	, MM.POSTED_NAME
	, TRUNC(MM.LAST_EDIT_DATE) AS SUBMIT_DATE
FROM bblearn.MSG_MAIN MM
LEFT OUTER JOIN bblearn.USERS 
  ON MM.USERS_PK1=USERS.PK1
LEFT OUTER JOIN bblearn.FORUM_MAIN 
  ON MM.FORUMMAIN_PK1=forum_main.PK1
LEFT OUTER JOIN bblearn.CONFERENCE_MAIN 
  ON FORUM_main.CONFMAIN_PK1=conference_main.PK1
LEFT OUTER JOIN bblearn.COURSE_MAIN CM
  ON CONFERENCE_MAIN.CRSMAIN_PK1=CM.PK1
--OPTION: Several useful where clauses
-- WHERE 
--OPTION: Date posted range start
-- MM.POSTED_DATE >= TO_DATE('28-JUL-15 00:00:00', 'DD-MON-YY HH24:MI:SS')
--OPTION: Date posted range end
-- AND MM.POSTED_DATE < TO_DATE('29-JUL-15 00:00:00', 'DD-MON-YY HH24:MI:SS')
--OPTION: completion/lifecycle status. Toggle "PUBLISHED"/"DRAFT"
-- MM.LIFECYCLE = 'PUBLISHED'
--OPTION: Blackboard username. Fill in 'user' between single quotes 
-- AND USERS.USER_ID IN ('example-student1')
--OPTION: External (SIS or other) unique ID between single quotes
-- USERS.BATCH_UID='ID-0001'
--OPTION: Blackboard Course ID 
-- cm.course_id IN ('EXAMPLECOURSE-01','EXAMPLECOURSE-02')
--OPTION: External (SIS or other) unique ID between single quotes 
-- cm.batch_uid IN ('ID-1000','ID-1001')
--OPTION: ORDER BY
-- ORDER BY MM.LAST_EDIT_DATE ASC
;
