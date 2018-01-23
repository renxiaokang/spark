
SELECT
t2.SerialNumber, #序号
(CASE 
WHEN Call.TypeClassification='系统调入' AND Call.RecallDivision=Call.CallInDivision='事业部' AND Call.RecallUnderDivision=Call.CallInUnderDivision='客户服务业事业部' THEN t2.EmployeeName
WHEN Call.TypeClassification='系统调出' AND Call.RecallDivision=Call.CallInDivision='事业部' AND Call.RecallUnderDivision=Call.CallInUnderDivision='客户服务业事业部' THEN Call.Name
WHEN Call.TypeClassification='系统调入' AND Call.RecallDivision<>Call.CallInDivision='事业部' AND Call.RecallUnderDivision<>Call.CallInUnderDivision='客户服务业事业部' THEN Call.Name
WHEN Call.TypeClassification='系统调出' AND Call.RecallDivision<>Call.CallInDivision<>'事业部' AND Call.RecallUnderDivision<>Call.CallInUnderDivision<>'客户服务业事业部' THEN Call.Name
ELSE t2.EmployeeName
END) AS EmployeeName, #员工姓名
(CASE
WHEN Call.TypeClassification='系统调入' AND Call.RecallDivision=Call.CallInDivision='事业部' AND Call.RecallUnderDivision=Call.CallInUnderDivision='客户服务业事业部' THEN t2.DomainAccount
WHEN Call.TypeClassification='系统调入' AND Call.RecallDivision<>Call.CallInDivision='事业部' AND Call.RecallUnderDivision<>Call.CallInUnderDivision='客户服务业事业部' THEN Call.DomainAccount
WHEN Call.TypeClassification='系统调出' AND Call.RecallDivision<>Call.CallInDivision<>'事业部' AND Call.RecallUnderDivision<>Call.CallInUnderDivision<>'客户服务业事业部' THEN Call.DomainAccount
ELSE t2.DomainAccount
END) AS DomainAccount, #域账号
t2.WorkingNature,
(CASE
WHEN Call.TypeClassification='系统调出' AND Call.RecallDivision<>Call.CallInDivision AND Call.RecallDivision='事业部' AND Call.RecallUnderDivision<>Call.CallInUnderDivision AND Call.CallInUnderDivision='客户服务业事业部' THEN Call.CallInDivision
ELSE t2.Division
END) AS Division,
(CASE
WHEN Call.TypeClassification='系统调出' AND Call.RecallDivision<>Call.CallInDivision AND Call.RecallDivision='事业部' AND Call.RecallUnderDivision<>Call.CallInUnderDivision AND Call.CallInUnderDivision='客户服务业事业部' THEN Call.CallInUnderDivision
ELSE t2.UnderDivision
END) AS UnderDivision, #事业部下一级组织
(CASE
WHEN Call.CallInDivision='事业部' THEN Call.CallInProject
ELSE t2.Project
END) AS Project, #项目
(CASE
WHEN Call.CallInDivision='事业部' THEN Call.PrimaryForms
ELSE t2.PrimaryForms
END) AS PrimaryForms,
(CASE
WHEN Call.CallInDivision='事业部' THEN Call.JobCategory
ELSE t2.JobCategory
END) AS JobCategory, #岗位类别
(CASE
WHEN Call.CallInDivision='事业部' THEN Call.FirJobCategory
ELSE t2.FirJobCategory
END) AS FirJobCategory, #一级岗位类别
(CASE
WHEN Call.CallInDivision='事业部' THEN Call.SecJobCategory
ELSE t2.SecJobCategory
END) AS SecJobCategory, #二级岗位类别
(CASE
WHEN Call.CallInDivision='事业部' THEN Call.MainResponsibility
ELSE t2.MainResponsibility
END) AS MainResponsibility, #三级岗位类别（第一主责）
(CASE
WHEN Call.TypeClassification='系统调入' AND Call.RecallDivision=Call.CallInDivision='事业部' AND Call.RecallUnderDivision=Call.CallInUnderDivision='客户服务业事业部' THEN t2.Department
WHEN Call.TypeClassification='系统调出' AND Call.RecallDivision<>Call.CallInDivision AND Call.RecallDivision='事业部' AND Call.RecallUnderDivision<>Call.CallInUnderDivision AND Call.RecallUnderDivision='客户服务业事业部' THEN Call.CallInDepartment
ELSE t2.Department
END) AS Department, #部门
(CASE
WHEN Call.RecallDivision=Call.CallInDivision='事业部' AND Call.RecallUnderDivision=Call.CallInUnderDivision='客户服务业事业部' THEN Call.Position
ELSE t2.Position
END) AS `Position`,  #职务
t2.Rank,  #职级
t2.Gender,  #性别
(CASE
WHEN Call.TypeClassification='系统调入' AND Call.RecallDivision=Call.CallInDivision='事业部' AND Call.RecallUnderDivision=Call.CallInUnderDivision='客户服务业事业部' THEN t2.IDCardNumber
WHEN Call.TypeClassification='系统调出' AND Call.RecallDivision=Call.CallInDivision='事业部' AND Call.RecallUnderDivision=Call.CallInUnderDivision='客户服务业事业部' THEN Call.IDCardNumber
WHEN Call.TypeClassification='系统调入' AND Call.RecallDivision<>Call.CallInDivision='事业部' AND Call.RecallUnderDivision<>Call.CallInUnderDivision='客户服务业事业部' THEN Call.IDCardNumber
WHEN Call.TypeClassification='系统调出' AND Call.RecallDivision<>Call.CallInDivision<>'事业部' AND Call.RecallUnderDivision<>Call.CallInUnderDivision<>'客户服务业事业部' THEN Call.IDCardNumber
ELSE t2.IDCardNumber
END) AS IDCardNumber, #身份证号码
(CASE
WHEN Call.TypeClassification='系统调入' AND Call.RecallDivision<>Call.CallInDivision='事业部' AND Call.RecallUnderDivision<>Call.CallInUnderDivision='客户服务业事业部' THEN STR_TO_DATE(CONCAT(SUBSTR(Call.IDCardNumber,7,4),'-',SUBSTR(Call.IDCardNumber,11,2),'-',SUBSTR(Call.IDCardNumber,13,2)), '%Y-%m-%d')
ELSE t2.BirthDate
END) AS BirthDate,    #出生日期
(CASE
WHEN Call.TypeClassification='系统调入' AND Call.RecallDivision<>Call.CallInDivision='事业部' AND Call.RecallUnderDivision<>Call.CallInUnderDivision='客户服务业事业部' THEN ROUND(DATEDIFF(CURDATE(), STR_TO_DATE(CONCAT(SUBSTR(Call.IDCardNumber,7,4),'-',SUBSTR(Call.IDCardNumber,11,2),'-',SUBSTR(Call.IDCardNumber,13,2)), '%Y-%m-%d'))/365.2422)
ELSE ROUND(DATEDIFF(CURDATE(), t2.BirthDate)/365.2422)
END) AS Age,    #年龄
(CASE
WHEN Call.ThisSignTime>Call.FirstSignTime THEN Call.FirstSignTime
ELSE t2.EntryTime
END) AS EntryTime, #入职时间
t2.PositiveDate,   #转正日期
t2.WorkStartTime,  #参加工作时间
t2.IndustryStartTime,  #行业从业起始时间
t2.HighestDegree,  #最高学历
t2.GraduateSchool, #毕业院校
t2.Major,  #专业
t2.PoliticalStatus,  #政治面貌
t2.Nation,  #民族
(CASE
WHEN Call.TypeClassification='系统调入' AND Call.RecallDivision<>Call.CallInDivision='事业部' AND Call.RecallUnderDivision<>Call.CallInUnderDivision='客户服务业事业部' THEN Call.ContractSigningUnit
ELSE t2.ContractSigningUnit
END) AS ContractSigningUnit,  #劳动合同签署单位
(CASE
WHEN Call.TypeClassification='系统调入' AND Call.RecallDivision<>Call.CallInDivision='事业部' AND Call.RecallUnderDivision<>Call.CallInUnderDivision='客户服务业事业部' THEN Call.FirstSignTime
ELSE t2.FirstSignTime
END) AS FirstSignTime,  #首签劳动合同时间
(CASE
WHEN Call.TypeClassification='系统调入' AND Call.RecallDivision<>Call.CallInDivision='事业部' AND Call.RecallUnderDivision<>Call.CallInUnderDivision='客户服务业事业部' THEN Call.ThisSignTime
ELSE t2.ThisSignTime
END) AS ThisSignTime,  #本次签订时间
(CASE
WHEN Call.TypeClassification='系统调入' AND Call.RecallDivision<>Call.CallInDivision='事业部' AND Call.RecallUnderDivision<>Call.CallInUnderDivision='客户服务业事业部' THEN Call.ContractExpiresTime
ELSE t2.ContractExpiresTime
END) AS ContractExpiresTime,  #本次合同到期时间
t2.NativePlace,    #籍贯
t2.ArchiveType,    #存档类型
t2.ArchivalPlace,  #档案存放地
t2.AccountType,    #户口类型
t2.CurrentAddress, #现住址
t2.WorkingPlace,    #工作地
t2.Company,         #公司
(CASE
WHEN Call.TypeClassification='系统调入' AND Call.RecallDivision=Call.CallInDivision='事业部' AND Call.RecallUnderDivision=Call.CallInUnderDivision='客户服务业事业部' THEN t2.WorkingStatus
WHEN Call.TypeClassification='系统调出' AND Call.RecallDivision<>Call.CallInDivision<>'事业部' AND Call.RecallUnderDivision<>Call.CallInUnderDivision<>'客户服务业事业部' THEN FALSE
ELSE t2.WorkingStatus
END) AS WorkingStatus,   #在职状态（1代表在职,0代表离职）
t2.year,  #加载数据年份
t2.month  #加载数据月份
FROM
    (SELECT 
    t1.SerialNumber,
    (CASE
    WHEN t1.IDCardNumber=Leave.IDCardNumber THEN Leave.EmployeeName
    ELSE t1.EmployeeName
    END) AS EmployeeName,
    (CASE
    WHEN t1.IDCardNumber=Leave.IDCardNumber THEN Leave.DomainAccount
    ELSE t1.DomainAccount
    END) AS DomainAccount,
    t1.WorkingNature,
    (CASE
    WHEN t1.IDCardNumber=Leave.IDCardNumber THEN Leave.Division
    ELSE t1.Division
    END) AS Division,
    (CASE
    WHEN t1.IDCardNumber=Leave.IDCardNumber THEN Leave.UnderDivision
    ELSE t1.UnderDivision
    END) AS UnderDivision,
    (CASE
    WHEN t1.IDCardNumber=Leave.IDCardNumber THEN Leave.Project
    ELSE t1.Project
    END) AS Project,
    t1.PrimaryForms,
    t1.JobCategory,
    t1.FirJobCategory,
    t1.SecJobCategory,
    t1.MainResponsibility,
    (CASE
    WHEN t1.IDCardNumber=Leave.IDCardNumber THEN Leave.Department
    ELSE t1.Department
    END) AS Department,
    t1.Position,
    t1.Rank,
    t1.Gender,
    (CASE
    WHEN t1.IDCardNumber=Leave.IDCardNumber THEN Leave.IDCardNumber
    ELSE t1.IDCardNumber
    END) AS IDCardNumber,
    t1.BirthDate,
    t1.Age,
    t1.EntryTime,
    t1.PositiveDate,
    t1.WorkStartTime,
    t1.IndustryStartTime,
    t1.HighestDegree,
    t1.GraduateSchool,
    t1.Major,
    t1.PoliticalStatus,
    t1.Nation,
    t1.ContractSigningUnit,
    t1.FirstSignTime,
    t1.ThisSignTime,
    t1.ContractExpiresTime,
    t1.NativePlace,
    t1.ArchiveType,
    t1.ArchivalPlace,
    t1.AccountType,
    t1.CurrentAddress,
    t1.WorkingPlace,
    t1.Company,
    Leave.DepartureTime,
    Leave.LeaveType,
    Leave.Leavecategory,
    Leave.LeaveDirection,
    Leave.LeaveReason,
    Leave.PassiveLeaveType,
    Leave.DismissReason,
    (CASE
    WHEN t1.IDCardNumber=Leave.IDCardNumber THEN FALSE
    ELSE TRUE
    END) AS WorkingStatus,
    YEAR(SYSDATE()) AS `year`,
    MONTH(SYSDATE()) AS `month`
    FROM
       (SELECT
       SerialNumber,
       EmployeeName,
       DomainAccount,
       WorkingNature,
       Division,
       UnderDivision,
       Project,
       PrimaryForms,
       JobCategory,
       FirJobCategory,
       SecJobCategory,
       MainResponsibility,
       Department,
       `Position`,
       Rank,
       Gender,
       IDCardNumber,
       BirthDate,
       Age,
       EntryTime,
       PositiveDate,
       WorkStartTime,
       IndustryStartTime,
       HighestDegree,
       GraduateSchool,
       Major,
       PoliticalStatus,
       Nation,
       ContractSigningUnit,
       FirstSignTime,
       ThisSignTime,
       ContractExpiresTime,
       NativePlace,
       ArchiveType,
       ArchivalPlace,
       AccountType,
       CurrentAddress,
       WorkingPlace,
       Company,
       YEAR(SYSDATE()) AS `year`,
       MONTH(SYSDATE()) AS `month`
       FROM CustomerService.ServingEmployee_detail
       UNION ALL
       SELECT
       SerialNumber,
       EmployeeName,
       DomainAccount,
       WorkingNature,
       Division,
       UnderDivision,
       Project,
       PrimaryForms,
       JobCategory,
       FirJobCategory,
       SecJobCategory,
       MainResponsibility,
       Department,
       `Position`,
       Rank,
       Gender,
       IDCardNumber,
       BirthDate,
       Age,
       EntryTime,
       PositiveDate,
       WorkStartTime,
       IndustryStartTime,
       HighestDegree,
       GraduateSchool,
       Major,
       PoliticalStatus,
       Nation,
       ContractSigningUnit,
       FirstSignTime,
       ThisSignTime,
       ContractExpiresTime,
       NativePlace,
       ArchiveType,
       ArchivalPlace,
       AccountType,
       CurrentAddress,
       WorkingPlace,
       NULL AS Company,
       `year`,
       `month`
       FROM CustomerService.EntryStaff_detail) AS t1
    LEFT JOIN CustomerService.StaffLeave_detail AS `Leave`
    ON t1.IDCardNumber=Leave.IDCardNumber) AS t2
LEFT JOIN CustomerService.CallStaff_detail AS `Call`
ON t2.IDCardNumber=Call.IDCardNumber








