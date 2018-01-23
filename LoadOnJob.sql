INSERT INTO CustomerService.ServingEmployee_detail
SELECT 
SerialNumber, #序号
EmployeeName, #员工姓名
(CASE
WHEN DomainAccount='1899/12/31 00:00:00.000' THEN NULL
WHEN DomainAccount='2190/06/22 00:00:00.000' THEN NULL
ELSE DomainAccount
END) AS DomainAccount, #域账号
WorkingNature, #用工性质
Division,  #事业部
UnderDivision, #事业部下一级组织
Project,  #项目
PrimaryForms, #一级业态
JobCategory,  #岗位类别
FirJobCategory,  #一级岗位类别
SecJobCategory,  #二级岗位类别
MainResponsibility,  #三级岗位类别（第一主责）
Department,          #部门
`Position`,          #职务
Rank,                #职级
Gender, #性别
IDCardNumber,  #身份证号码
STR_TO_DATE(BirthDate,'%Y-%m-%d') AS BirthDate, #出生日期
CAST(Age AS SIGNED INTEGER) AS Age, #年龄
STR_TO_DATE(EntryTime,'%Y-%m-%d') AS EntryTime, #入职时间
(CASE 
#WHEN PositiveDate='2017/727' THEN STR_TO_DATE(DATE_FORMAT(CONCAT(SUBSTR(PositiveDate,1,6),'/','27'),'%Y-%m-%d'),'%Y-%m-%d')
WHEN PositiveDate RLIKE '[1-9]{4}/[0-9]{4}' THEN STR_TO_DATE(DATE_FORMAT(CONCAT(SUBSTR(PositiveDate,1,7),'/',SUBSTR(PositiveDate,8,2)),'%Y-%m-%d'),'%Y-%m-%d')
WHEN PositiveDate RLIKE '[1-9]{4}/[1-9]{1}0[1-9]{1}' THEN STR_TO_DATE(DATE_FORMAT(CONCAT(SUBSTR(PositiveDate,1,6),'/',SUBSTR(PositiveDate,7,2)),'%Y-%m-%d'),'%Y-%m-%d')
WHEN PositiveDate RLIKE '[1-9]{4}/[0-9]{3}' THEN STR_TO_DATE(DATE_FORMAT(CONCAT(SUBSTR(PositiveDate,1,6),'/',SUBSTR(PositiveDate,7,2)),'%Y-%m-%d'),'%Y-%m-%d')
WHEN PositiveDate RLIKE '[0-9]{4}/[0-9]{1,2}'THEN STR_TO_DATE(DATE_FORMAT(CONCAT(PositiveDate,'/','1'), '%Y-%m-%d'),'%Y-%m-%d')
WHEN PositiveDate RLIKE '[1-9]{4}-[0-9]{4}' THEN STR_TO_DATE(DATE_FORMAT(CONCAT(SUBSTR(PositiveDate,1,7),'-',SUBSTR(PositiveDate,8,2)),'%Y-%m-%d'),'%Y-%m-%d')
WHEN PositiveDate RLIKE '[1-9]{4}-[1-9]{1}0[1-9]{1}' THEN STR_TO_DATE(DATE_FORMAT(CONCAT(SUBSTR(PositiveDate,1,6),'-',SUBSTR(PositiveDate,7,2)),'%Y-%m-%d'),'%Y-%m-%d')
WHEN PositiveDate RLIKE '[1-9]{4}-[0-9]{3}' THEN STR_TO_DATE(DATE_FORMAT(CONCAT(SUBSTR(PositiveDate,1,7),'/',SUBSTR(PositiveDate,8,1)),'%Y-%m-%d'),'%Y-%m-%d')
WHEN PositiveDate RLIKE '[0-9]{4}-[0-9]{1,2}' THEN STR_TO_DATE(DATE_FORMAT(CONCAT(PositiveDate,'-','1'), '%Y-%m-%d'),'%Y-%m-%d')
ELSE STR_TO_DATE(DATE_FORMAT(PositiveDate, '%Y-%m-%d'), '%Y-%m-%d')
END) AS PositiveDate, #转正日期
(CASE 
WHEN TIMESTAMPDIFF(YEAR,BirthDate,WorkStartTime) <17 THEN STR_TO_DATE(DATE_FORMAT(EntryTime, '%Y-%m-%d'), '%Y-%m-%d')
WHEN WorkStartTime RLIKE '[0-9]{4}-[0-9]{1,2}-[0-9]{1,2}' THEN STR_TO_DATE(DATE_FORMAT(WorkStartTime, '%Y-%m-%d'), '%Y-%m-%d')
WHEN WorkStartTime RLIKE '[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}' THEN STR_TO_DATE(DATE_FORMAT(WorkStartTime, '%Y-%m-%d'), '%Y-%m-%d')
WHEN WorkStartTime RLIKE '[0-9]{4}-[0-9]{1,2}' THEN STR_TO_DATE(DATE_FORMAT(CONCAT(WorkStartTime,'-','1'), '%Y-%m-%d'), '%Y-%m-%d')
WHEN WorkStartTime RLIKE '[0-9]{4}/[0-9]{1,2}/' THEN STR_TO_DATE(DATE_FORMAT(CONCAT(WorkStartTime,'1'), '%Y-%m-%d'), '%Y-%m-%d')
WHEN WorkStartTime RLIKE '[0-9]{4}/[0-9]{1,2}' THEN STR_TO_DATE(DATE_FORMAT(CONCAT(WorkStartTime,'/','1'), '%Y-%m-%d'), '%Y-%m-%d')
ELSE STR_TO_DATE(DATE_FORMAT(CONCAT(WorkStartTime,'/','1','/','1'), '%Y-%m-%d'), '%Y-%m-%d')
END) AS WorkStartTime, #参加工作时间
(CASE 
WHEN IndustryStartTime=WorkStartTime AND TIMESTAMPDIFF(YEAR,BirthDate,WorkStartTime) <17 THEN STR_TO_DATE(DATE_FORMAT(EntryTime, '%Y-%m-%d'), '%Y-%m-%d')
WHEN IndustryStartTime='1899-12-31' THEN STR_TO_DATE(DATE_FORMAT(EntryTime, '%Y-%m-%d'), '%Y-%m-%d')
ELSE STR_TO_DATE(DATE_FORMAT(IndustryStartTime, '%Y-%m-%d'), '%Y-%m-%d')
END) AS IndustryStartTime, #行业从业起始时间
HighestDegree, #最高学历
GraduateSchool, #毕业院校
Major, #专业
PoliticalStatus, #政治面貌
Nation,  #民族
ContractSigningUnit, #劳动合同签署单位
(CASE
WHEN FirstSignTime='1899-12-31' THEN STR_TO_DATE(DATE_FORMAT(EntryTime, '%Y-%m-%d'), '%Y-%m-%d')
WHEN FirstSignTime='2017/' THEN STR_TO_DATE(DATE_FORMAT(EntryTime, '%Y-%m-%d'), '%Y-%m-%d')
ELSE STR_TO_DATE(DATE_FORMAT(FirstSignTime, '%Y-%m-%d'), '%Y-%m-%d')
END) AS FirstSignTime,  #首签劳动合同时间 
STR_TO_DATE(DATE_FORMAT(ThisSignTime, '%Y-%m-%d'), '%Y-%m-%d') AS ThisSignTime,  #本次签订时间
STR_TO_DATE(DATE_FORMAT(ContractExpiresTime, '%Y-%m-%d'), '%Y-%m-%d') AS ContractExpiresTime,  #本次合同到期时间
NativePlace, #籍贯
ArchiveType, #存档类型
ArchivalPlace, #档案存放地
AccountType,   #户口类型
CurrentAddress, #现住址
WorkingPlace,   #工作地点
Company          #公司
FROM CustomerService.ServingEmployee

