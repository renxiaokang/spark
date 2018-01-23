INSERT INTO CustomerService.EntryStaff_detail
SELECT 
EmployeeName,
(CASE
WHEN DomainAccount='无' THEN NULL
WHEN DomainAccount='/' THEN NULL
ELSE DomainAccount
END) AS DomainAccount,
(CASE 
WHEN WorkingNature IS NULL THEN '正式工'
ELSE WorkingNature
END) AS WorkingNature,
(CASE
WHEN Division="客户服务业事业部" THEN '事业部'
ELSE Division
END) AS Division,
(CASE
WHEN UnderDivision="亿洋楼宇" THEN '客户服务业事业部'
ELSE UnderDivision
END) AS UnderDivision,
Project,
PrimaryForms,
JobCategory,
FirJobCategory,
SecJobCategory,
MainResponsibility,
Department,
`Position`,
(CASE
WHEN Rank IS NULL THEN '无'
WHEN Rank RLIKE '不确定' THEN '无'
WHEN Rank RLIKE 'G' THEN '无'
WHEN Rank RLIKE 'F' THEN '无'
ELSE Rank
END) AS Rank,
Gender,
(CASE
WHEN IDCardNumber='15042119810809003x' THEN '15042119810809003X'
ELSE IDCardNumber
END) AS IDCardNumber,
(CASE
WHEN BirthDate RLIKE '[1-9]{4}/[0-9]{4}' THEN STR_TO_DATE(DATE_FORMAT(CONCAT(SUBSTR(BirthDate,1,7),'/',SUBSTR(BirthDate,8,2)),'%Y-%m-%d'),'%Y-%m-%d')
WHEN BirthDate RLIKE '[1-9]{4}/[1-9]{1}0[1-9]{1}' THEN STR_TO_DATE(DATE_FORMAT(CONCAT(SUBSTR(BirthDate,1,6),'/',SUBSTR(BirthDate,7,2)),'%Y-%m-%d'),'%Y-%m-%d')
WHEN BirthDate RLIKE '[1-9]{4}/[0-9]{3}' THEN STR_TO_DATE(DATE_FORMAT(CONCAT(SUBSTR(BirthDate,1,7),'/',SUBSTR(BirthDate,8,1)),'%Y-%m-%d'),'%Y-%m-%d')
ELSE STR_TO_DATE(DATE_FORMAT(BirthDate,'%Y-%m-%d'),'%Y-%m-%d')
END) AS BirthDate,
(CASE
WHEN BirthDate RLIKE '[1-9]{4}/[0-9]{4}' THEN ROUND(DATEDIFF(CURDATE(), STR_TO_DATE(DATE_FORMAT(CONCAT(SUBSTR(BirthDate,1,7),'/',SUBSTR(BirthDate,8,2)),'%Y-%m-%d'),'%Y-%m-%d'))/365.2422)
WHEN BirthDate RLIKE '[1-9]{4}/[1-9]{1}0[1-9]{1}' THEN ROUND(DATEDIFF(CURDATE(), STR_TO_DATE(DATE_FORMAT(CONCAT(SUBSTR(BirthDate,1,6),'/',SUBSTR(BirthDate,8,2)),'%Y-%m-%d'),'%Y-%m-%d'))/365.2422)
WHEN BirthDate RLIKE '[1-9]{4}/[0-9]{3}' THEN ROUND(DATEDIFF(CURDATE(), STR_TO_DATE(DATE_FORMAT(CONCAT(SUBSTR(BirthDate,1,7),'/',SUBSTR(BirthDate,8,1)),'%Y-%m-%d'),'%Y-%m-%d'))/365.2422)
ELSE ROUND(DATEDIFF(CURDATE(), STR_TO_DATE(DATE_FORMAT(BirthDate,'%Y-%m-%d'),'%Y-%m-%d'))/365.2422)
END) AS Age,
STR_TO_DATE(DATE_FORMAT(EntryTime,'%Y-%m-%d'),'%Y-%m-%d') AS EntryTime,
STR_TO_DATE(DATE_FORMAT(PositiveDate,'%Y-%m-%d'),'%Y-%m-%d') AS PositiveDate,
STR_TO_DATE(DATE_FORMAT(WorkStartTime,'%Y-%m-%d'),'%Y-%m-%d') AS WorkStartTime,
(CASE
WHEN IndustryStartTime='1899/12/31' THEN STR_TO_DATE(DATE_FORMAT(EntryTime,'%Y-%m-%d'),'%Y-%m-%d')
ELSE STR_TO_DATE(DATE_FORMAT(IndustryStartTime,'%Y-%m-%d'),'%Y-%m-%d')
END) AS IndustryStartTime,
HighestDegree,
GraduateSchool,
(CASE
WHEN Major='无' THEN NULL
WHEN Major='/' THEN NULL
WHEN Major='——' THEN NULL
ELSE Major
END) AS Major,
(CASE
WHEN PoliticalStatus IS NULL THEN '群众'
WHEN PoliticalStatus='共产党员' THEN '中国共产党党员'
WHEN PoliticalStatus='共青团员' THEN '中国共产主义青年团团员'
ELSE PoliticalStatus
END) AS PoliticalStatus,
(CASE
WHEN Nation='汉' THEN '汉族'
WHEN Nation='蒙古' THEN '蒙古族'
WHEN Nation='土家' THEN '土家族'
WHEN Nation='满' THEN '满族'
ELSE Nation
END) AS Nation,
ContractSigningUnit,
STR_TO_DATE(DATE_FORMAT(FirstSignTime,'%Y-%m-%d'),'%Y-%m-%d') AS FirstSignTime,
STR_TO_DATE(DATE_FORMAT(ThisSignTime,'%Y-%m-%d'),'%Y-%m-%d') AS ThisSignTime,
STR_TO_DATE(DATE_FORMAT(ContractExpiresTime,'%Y-%m-%d'),'%Y-%m-%d') AS ContractExpiresTime,
(CASE
WHEN CONCAT(SUBSTR(CustomerService.EntryStaff.NativePlace,1,2),'省') IN (SELECT Province FROM CustomerService.Regional_Information) THEN CONCAT(SUBSTR(NativePlace,1,2),'省')
WHEN SUBSTR(CustomerService.EntryStaff.NativePlace,1,3)='黑龙江' THEN '黑龙江省'
WHEN SUBSTR(CustomerService.EntryStaff.NativePlace,1,2)='广西' THEN '广西壮族自治区'
WHEN SUBSTR(CustomerService.EntryStaff.NativePlace,1,2)='内蒙' THEN '内蒙古自治区'
WHEN SUBSTR(CustomerService.EntryStaff.NativePlace,1,2)='蒙古' THEN '内蒙古自治区'
WHEN SUBSTR(CustomerService.EntryStaff.NativePlace,1,2)='杭州' THEN '浙江省'
WHEN SUBSTR(CustomerService.EntryStaff.NativePlace,1,2)='长春' THEN '吉林省'
WHEN SUBSTR(CustomerService.EntryStaff.NativePlace,1,2)='北京' THEN '北京市'
WHEN SUBSTR(CustomerService.EntryStaff.NativePlace,1,2)='朝阳' THEN '北京市'
WHEN SUBSTR(CustomerService.EntryStaff.NativePlace,1,2)='天津' THEN '天津市'
WHEN SUBSTR(CustomerService.EntryStaff.NativePlace,1,2)='上海' THEN '上海市'
WHEN EntryStaff.NativePlace='沈阳' THEN '辽宁省'
WHEN EntryStaff.NativePlace='铁岭' THEN '辽宁省'
WHEN EntryStaff.NativePlace='大连' THEN '辽宁省'
WHEN EntryStaff.NativePlace='武汉' THEN '湖北省'
WHEN EntryStaff.NativePlace='孝感' THEN '湖北省'
WHEN EntryStaff.NativePlace='鄂州' THEN '湖北省'
WHEN EntryStaff.NativePlace='云梦' THEN '湖北省'
WHEN EntryStaff.NativePlace='灯塔' THEN '辽宁省'
WHEN EntryStaff.NativePlace='昌图' THEN '辽宁省'
END) AS NativePlace,
(CASE
WHEN ArchiveType IS NULL THEN '个人中介存档'
ELSE ArchiveType
END) AS ArchiveType,
ArchivalPlace,
(CASE
WHEN SUBSTR(AccountType,1,2)='非农' THEN '非农业户口'
WHEN SUBSTR(AccountType,1,2)='农业' THEN '农业户口'
WHEN SUBSTR(AccountType,1,2)='城镇' THEN '非农业户口'
END) AS AccountType,
CurrentAddress,
WorkingPlace,
CAST(SUBSTR(DATE_FORMAT(`LoadDate`,'%Y-%m-%d'),1,4) AS SIGNED INTEGER) AS `year`,
CAST(SUBSTR(DATE_FORMAT(`LoadDate`,'%Y-%m-%d'),6,2) AS SIGNED INTEGER) AS `month`
FROM CustomerService.EntryStaff
WHERE LoadDate='2018-01-19'

