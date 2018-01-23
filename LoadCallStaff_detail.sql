INSERT INTO CustomerService.CallStaff_detail
SELECT
SerialNumber,
TransferType,
TypeClassification,
STR_TO_DATE(DATE_FORMAT(CallInTime, '%Y-%m-%d'), '%Y-%m-%d') AS CallInTime,
RecallDivision,
RecallUnderDivision,
RecallProject,
RecallDepartment,
`Name`,
DomainAccount,
CallInDivision,
CallInUnderDivision,
CallInProject,
CallInDepartment,
PrimaryForms,
JobCategory,
FirJobCategory,
SecJobCategory,
MainResponsibility,
`Position`,
IDCardNumber,
ContractSigningUnit,
STR_TO_DATE(DATE_FORMAT(FirstSignTime, '%Y-%m-%d'), '%Y-%m-%d') AS FirstSignTime,
STR_TO_DATE(DATE_FORMAT(ThisSignTime, '%Y-%m-%d'), '%Y-%m-%d') AS ThisSignTime,
STR_TO_DATE(DATE_FORMAT(ContractExpiresTime, '%Y-%m-%d'), '%Y-%m-%d') AS ContractExpiresTime,
CAST(SUBSTR(DATE_FORMAT(`LoadDate`,'%Y-%m-%d'),1,4) AS SIGNED INTEGER) AS `year`,
CAST(SUBSTR(DATE_FORMAT(`LoadDate`,'%Y-%m-%d'),6,2) AS SIGNED INTEGER) AS `month`
FROM CustomerService.CallStaff

