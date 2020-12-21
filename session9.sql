USE AdventureWorks2014

CREATE DATABASE SuperCool
GO

USE SuperCool
GO

CREATE TABLE SuperCoolEmployeeDetails(
[EmployeeName] [varchar](50) NOT NULL,
[EmployeeID] [varchar](20) NOT NULL,
[Designation] [varchar](50) NOT NULL,
[JoiningDate] [datetimeoffset](0) NOT NULL,
[ContactNo] [varchar](15) SPARSE NULL
)
GO

CREATE TABLE SuperCoolEmployeeDetails(
[EmployeeName] [varchar](50) NOT NULL,
[EmployeeID] [varchar](20) NOT NULL,
[Designation] [varchar](50) NOT NULL,
[JoiningDate] [datetimeoffset](0) NOT NULL,
[ContactNo] [varchar](15) SPARSE NULL,
GO

INSERT INTO SuperCoolEmployeeDetails(EmployeeName, EmployeeID,
Designation, JoiningDate, ContactNo)
VALUES('Gustavo Achang', 'E1001', 'President', '2008-10-10 00:00:00.0000000
+05:30', '0346353')
GO

CREATE TABLE DesignationDetails
(
[DesignationHID] [hierarchyid] PRIMARY KEY,
[DesignationId] [int] NULL, [Designation] [varchar](50) NULL )
GO

INSERT INTO DesignationDetails(DesignationHID, DesignationId,
Designation)
VALUES (hierarchyid::GetRoot(), 1, 'President')
GO

SELECT * FROM DesignationDetails
GO

CREATE PROCEDURE InsertDesignationDetails(@OrgId AS INT, @DesignationId
AS INT, @Designation VARCHAR(50)) AS
BEGIN
DECLARE @OrgHID AS hierarchyid
DECLARE @LastOrgID AS hierarchyid
DECLARE @DesignationHID AS hierarchyid
SELECT @OrgHID = DesignationHID FROM DesignationDetails WHERE DesignationId
= @OrgId
SELECT @LastOrgID = Max(DesignationHID) FROM DesignationDetails
WHERE DesignationHID.GetAncestor(1) = @OrgHID
INSERT INTO DesignationDetails VALUES
(@OrgHID.GetDescendant(@LastOrgID,Null), @DesignationId, @Designation)
RETURN @@RowCount
END
GO

EXEC InsertDesignationDetails 1,2,'General Manager'
EXEC InsertDesignationDetails 2,3,'Sales Manager'
EXEC InsertDesignationDetails 3,6,'Regional Head'
EXEC InsertDesignationDetails 6,8,'Section Head'
EXEC InsertDesignationDetails 8,9,'Salesman'
EXEC InsertDesignationDetails 2,4,'Production Manager'
EXEC InsertDesignationDetails 4,7,'Supervisor'
EXEC InsertDesignationDetails 2,5,'Finance Manager'

SELECT * FROM DesignationDetails
GO

SELECT DesignationHID.ToString() AS Hierarchy, * FROM
DesignationDetails
GO

CREATE TABLE SuperCoolSalesFigure
(CityId int PRIMARY KEY IDENTITY (1,1),
CityName nvarchar(25), Amount money, CityGeo geometry);
GO

INSERT INTO SuperCoolSalesFigure (CityName, Amount, CityGeo)
VALUES
('Adelaide', 45000.00, geometry::STGeomFromText('POLYGON ((0 0, 1 0, 11, 0 1, 0 0))', 0)),
('Brisbane', 50000.00, geometry::STGeomFromText('POLYGON ((3 3, 3 4, 44, 4 2, 3 3))', 0)),
('Canberra', 35000.00, geometry::STGeomFromText('POLYGON ((5 3, 6 3, 54, 5 3))', 0)),
('Darwin', 40000.00, geometry::STGeomFromText('POLYGON ((5 0, 6 0, 6 1,5 0))', 0)),
('Hobart', 25000.00, geometry::STGeomFromText('POLYGON ((4 1, 5 1, 5 2,4 2, 4 1))', 0)),
('Melbourne', 20000.00, geometry::STGeomFromText('POLYGON ((0 2, 1 2, 03, 0 2))', 0)),
('Perth', 55000.00, geometry::STGeomFromText('POLYGON ((2 1, 3 1, 3 2,2 2, 2 1))', 0)),
('Sydney', 60000.00, geometry::STGeomFromText('POLYGON ((1 3, 2 3, 2 4,1 4, 1 3))', 0));

SELECT * FROM SuperCoolSalesFigure
GO
