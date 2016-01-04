/*
ORACLE. SCORM item status for user/course on given date range.  
*/

SELECT 
      cc.title AS item_title
 --     , u.batch_uid
      , u.user_id
 --     , cm.batch_uidNew Prod Full
      , cm.course_id
      , sl.launch_time
      , sl.exit_time
      , sl.completion
--      , sl.satisfaction
--      , sl.update_by
--      ,floor(sl.experienced_duration_tracked) AS MISeconds 
--      ,(to_char(to_date(sl.experienced_duration_tracked,'sssss'),'hh24:mi:ss')) AS Minutes
--      , instr(substr(sl.history_log, instr(sl.history_log, '(') + 1),'=' -1) AS Originated
--      , cc.parent_pk1
      , cc_parent.title AS parent_folder_title
      , trunc(sl.exit_time) AS SUBMIT_DATE
from bblearn.scormregistration sr
left outer join bblearn.scormlaunchhistory sl on sl.scorm_registration_id = sr.scorm_registration_id
left outer join bblearn.course_contents cc on cc.pk1 = to_number(trim(REGEXP_SUBSTR(sr.content_id, '[^_]+')))
left outer join bblearn.course_main cm on cm.pk1 = cc.crsmain_pk1
INNER JOIN bblearn.users u 
  ON u.user_id = sr.global_objective_scope
INNER JOIN bblearn.course_contents cc_parent 
  ON cc.parent_pk1 = cc_parent.pk1
--OPTION: Several useful where clauses
-- WHERE 
--OPTION: completion status. Toggle "complete"/"incomplete"
-- sl.completion = 'complete'
--OPTION: Blackboard username. Fill in 'user' between single quotes 
-- sr.global_objective_scope IN ('example-student1','example-student2')
-- sr.global_objective_scope = 'n.jones7'
--OPTION: External (SIS or other) unique ID between single quotes
-- u.batch_uid='ID-0001'
--OPTION: Blackboard Course ID 
--cm.course_id IN ('EXAMPLECOURSE-01','EXAMPLECOURSE-02')
--OPTION: External (SIS or other) unique ID between single quotes 
--cm.batch_uid IN ('ID-1000','ID-1001')
--OPTION: Specify only records logged after a given date
-- sl.exit_time >= TO_DATE('01-OCT-15 00:00:00', 'DD-MON-YY HH24:MI:SS')
--OPTION: Specify only records logged before a given date
-- sl.exit_time <= TO_DATE('23-OCT-15 00:00:00', 'DD-MON-YY HH24:MI:SS')
;