INSERT INTO CustomerService.StaffLeave_detail
SELECT
EmployeeName,
DomainAccount,
(CASE
WHEN IDCardNumber='21028219950225914x' THEN '21028219950225914X'
WHEN IDCardNumber='42088119850114582x' THEN '42088119850114582X'
WHEN IDCardNumber='42011219940711211x' THEN '42011219940711211X'
ELSE IDCardNumber
END) AS IDCardNumber,
STR_TO_DATE(DATE_FORMAT(DepartureTime, '%Y-%m-%d'), '%Y-%m-%d') AS DepartureTime,
(CASE
WHEN Division="客户服务业事业部" THEN '事业部'
ELSE Division
END) AS Division,
(CASE
WHEN UnderDivision="亿洋楼宇" THEN '客户服务业事业部'
WHEN UnderDivision IS NULL THEN '客户服务业事业部'
ELSE UnderDivision
END) AS UnderDivision,
(CASE
WHEN Project='远洋养老运营管理有限公司' THEN '远洋养老公司'
#when UnderDivision='亿洋楼宇' and Project='客户服务业事业部' then '亿家物业公司'
#when UnderDivision='亿洋楼宇' and SUBSTR(Project,1,2)='亿洋' then '亿家物业公司'
#when substr(Project,1,6)='物业上海公司' then '亿家物业公司'
#WHEN SUBSTR(Project,1,4)='亿家物业' THEN '亿家物业公司'
#when Project='天津公司' then '亿家物业公司'
ELSE Project
END) AS Project,
(CASE
WHEN Project='亿家物业公司' AND Department='工程部' THEN '亿家物业工程管理'
ELSE Department
END) AS Department,
(CASE
WHEN LeaveType='被动转主动' THEN '主动离职'
ELSE LeaveType
END) AS LeaveType,
(CASE
WHEN Leavecategory IS NULL THEN '不确定去向'
ELSE Leavecategory
END) AS Leavecategory,
LeaveDirection,
LeaveReason,
(CASE
WHEN LeaveType='主动离职' THEN NULL
WHEN LeaveType='被动转主动' THEN NULL
WHEN LeaveType='被动离职' AND PassiveLeaveType IS NULL THEN '解除辞退'
#when LeaveType='被动离职' AND PassiveLeaveType IS NULL and DismissReason is null THEN '解除辞退'
ELSE PassiveLeaveType
END) AS PassiveLeaveType,
(CASE
WHEN LeaveType='主动离职' THEN NULL
WHEN LeaveType='被动转主动' THEN NULL
WHEN LeaveType='被动离职' AND DismissReason IS NULL THEN '绩效不达标'
ELSE DismissReason
END) AS DismissReason,
CAST(SUBSTR(DATE_FORMAT(`LoadDate`,'%Y-%m-%d'),1,4) AS SIGNED INTEGER) AS `year`,
CAST(SUBSTR(DATE_FORMAT(`LoadDate`,'%Y-%m-%d'),6,2) AS SIGNED INTEGER) AS `month`
FROM CustomerService.StaffLeave
WHERE LoadDate='2018-01-11' AND DepartureTime<>'与自建表重复提报'

