/*
Oracle. Selected fields related to logged activity in gradebook_log within specified time range.
Use AND parameters to specify student and course.
5/02/15
*/

SELECT 
   gm.title AS ITEM_TITLE
  , gl.username
  , cm.course_id
  , attempt_creation AS CREATED_DATE
  , date_logged AS LAST_EDIT_DATE
  , event_key AS LIFECYCLE
  , trunc(date_logged) AS SUBMIT_DATE
--  , gl.grade
--  , gl.deletion_event_ind
--  , modifier_role
--  , modifier_username
--  , gm.score_provider_handle
--  , gg.status
FROM BBLEARN.GRADEBOOK_LOG GL
LEFT OUTER JOIN BBLEARN.GRADEBOOK_MAIN GM
   ON GL.GRADEBOOK_MAIN_PK1=GM.PK1
LEFT OUTER JOIN BBLEARN.GRADEBOOK_GRADE GG
   ON GM.PK1=GG.GRADEBOOK_MAIN_PK1
LEFT OUTER JOIN BBLEARN.COURSE_MAIN CM
   ON gm.CRSMAIN_PK1=CM.PK1
--OPTION: Several useful where clauses
--WHERE 
--OPTION: Date logged range start
-- DATE_LOGGED > TO_DATE('15-MAR-15 00:00:00', 'DD-MON-YY HH24:MI:SS')
--OPTION: Date logged range end
-- AND DATE_LOGGED < TO_DATE('18-MAR-15 00:00:00', 'DD-MON-YY HH24:MI:SS')
--OPTION: Restrict role of modifier to Student
-- AND GL.MODIFIER_ROLE='S'
--OPTION: Blackboard username. Fill in 'user' between single quotes 
-- AND GL.USERNAME IN ('example-student1')
--OPTION: Blackboard Course ID 
-- cm.course_id IN ('EXAMPLECOURSE-01','EXAMPLECOURSE-02')
--OPTION: External (SIS or other) unique ID between single quotes 
-- cm.batch_uid IN ('ID-1000','ID-1001')
;