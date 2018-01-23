CREATE TABLE `CustomerService`.`JobCategory_Information`( 
   `PrimaryForms` VARCHAR(36) COMMENT '一级业态', 
   `JobCategory` VARCHAR(36) COMMENT '岗位类别', 
   `FirJobCategory` VARCHAR(36) COMMENT '一级岗位类别', 
   `SecJobCategory` VARCHAR(36) COMMENT '二级岗位类别', 
   `MainResponsibility` VARCHAR(36) COMMENT '三级岗位类别（第一主责）'
 )
 
 
 
 SELECT * FROM JobCategory_Information WHERE MainResponsibility='物业拓展'