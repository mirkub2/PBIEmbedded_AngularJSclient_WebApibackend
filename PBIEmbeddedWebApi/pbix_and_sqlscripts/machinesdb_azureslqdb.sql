--T-SQL scripts for creation of tables in Azure SQL database, which will be datasource for PBI reports 
CREATE TABLE [dbo].[customers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nchar](50) NOT NULL,
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[products](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nchar](50) NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[status](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nchar](30) NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[devices](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[status_id] [int] NOT NULL,
	[location_city] [nchar](50) NOT NULL,
	[location_country] [nchar](50) NOT NULL,
	[install_date] [datetime] NOT NULL,
	[end_of_warranty] [datetime] NOT NULL
) ON [PRIMARY]
GO

--insert sample data into tables
INSERT INTO customers values('Customer A')
INSERT INTO customers values('Customer B')
INSERT INTO customers values('Customer C')
INSERT INTO customers values('Customer D')
INSERT INTO customers values('Customer E')
INSERT INTO customers values('Customer F')
INSERT INTO customers values('Customer G')

INSERT INTO products values('Climate model 1')
INSERT INTO products values('Climate model 2')
INSERT INTO products values('Climate model 3')
INSERT INTO products values('Lift model a')
INSERT INTO products values('Lift model b')
INSERT INTO products values('Lift model c')
INSERT INTO products values('Fire sensor x')
INSERT INTO products values('Fire sensor y')
INSERT INTO products values('Fire sensor z')
INSERT INTO products values('TV panel 50 inch')
INSERT INTO products values('TV panel 70 inch')
INSERT INTO products values('TV panel 90 inch')

INSERT INTO status values('Ready')
INSERT INTO status values('Turned off')
INSERT INTO status values('Error')

--generate random data
DECLARE @rows_per_city smallint;  
DECLARE @month_minus smallint;  
DECLARE @month_plus smallint;  
DECLARE @customer_number smallint;  
DECLARE @product_number smallint;  
DECLARE @status_number smallint;  
SET @rows_per_city = 1;  
WHILE @rows_per_city < 10  
   BEGIN  
	  SELECT @customer_number = (ABS(CHECKSUM(NewId())) % 7) + 1   
      SELECT @product_number = (ABS(CHECKSUM(NewId())) % 12) + 1   
      SELECT @status_number = (ABS(CHECKSUM(NewId())) % 3) + 1   
      SELECT @month_minus = (ABS(CHECKSUM(NewId())) % 12) + 1   
      SELECT @month_plus = (ABS(CHECKSUM(NewId())) % 12) + 1
      INSERT INTO devices values(@customer_number, @product_number, @status_number,'Bratislava','Slovakia', DATEADD(month,(-1)*@month_minus,getdate()) , DATEADD(month,@month_plus,getdate()) )
      SET @rows_per_city = @rows_per_city + 1  
   END;  
SET @rows_per_city = 1;  
WHILE @rows_per_city < 10  
   BEGIN  
	  SELECT @customer_number = (ABS(CHECKSUM(NewId())) % 7) + 1   
      SELECT @product_number = (ABS(CHECKSUM(NewId())) % 12) + 1   
      SELECT @status_number = (ABS(CHECKSUM(NewId())) % 3) + 1   
      SELECT @month_minus = (ABS(CHECKSUM(NewId())) % 12) + 1   
      SELECT @month_plus = (ABS(CHECKSUM(NewId())) % 12) + 1   
      INSERT INTO devices values(@customer_number, @product_number, @status_number,'Prague','Czech Republic', DATEADD(month,(-1)*@month_minus,getdate()) , DATEADD(month,@month_plus,getdate()) )
      SET @rows_per_city = @rows_per_city + 1  
   END;  
SET @rows_per_city = 1;  
WHILE @rows_per_city < 10  
   BEGIN  
	  SELECT @customer_number = (ABS(CHECKSUM(NewId())) % 7) + 1   
      SELECT @product_number = (ABS(CHECKSUM(NewId())) % 12) + 1   
      SELECT @status_number = (ABS(CHECKSUM(NewId())) % 3) + 1   
      SELECT @month_minus = (ABS(CHECKSUM(NewId())) % 12) + 1   
      SELECT @month_plus = (ABS(CHECKSUM(NewId())) % 12) + 1
      INSERT INTO devices values(@customer_number, @product_number, @status_number,'Budapest','Hungary', DATEADD(month,(-1)*@month_minus,getdate()) , DATEADD(month,@month_plus,getdate()) )
      SET @rows_per_city = @rows_per_city + 1  
   END;  
SET @rows_per_city = 1;  
WHILE @rows_per_city < 10  
   BEGIN  
	  SELECT @customer_number = (ABS(CHECKSUM(NewId())) % 7) + 1   
      SELECT @product_number = (ABS(CHECKSUM(NewId())) % 12) + 1   
      SELECT @status_number = (ABS(CHECKSUM(NewId())) % 3) + 1   
      SELECT @month_minus = (ABS(CHECKSUM(NewId())) % 12) + 1   
      SELECT @month_plus = (ABS(CHECKSUM(NewId())) % 12) + 1
      INSERT INTO devices values(@customer_number, @product_number, @status_number,'Warszaw','Poland', DATEADD(month,(-1)*@month_minus,getdate()) , DATEADD(month,@month_plus,getdate()) )
      SET @rows_per_city = @rows_per_city + 1  
   END;  
SET @rows_per_city = 1;  
WHILE @rows_per_city < 10  
   BEGIN  
	  SELECT @customer_number = (ABS(CHECKSUM(NewId())) % 7) + 1   
      SELECT @product_number = (ABS(CHECKSUM(NewId())) % 12) + 1   
      SELECT @status_number = (ABS(CHECKSUM(NewId())) % 3) + 1   
      SELECT @month_minus = (ABS(CHECKSUM(NewId())) % 12) + 1   
      SELECT @month_plus = (ABS(CHECKSUM(NewId())) % 12) + 1
      INSERT INTO devices values(@customer_number, @product_number, @status_number,'Vienna','Austria', DATEADD(month,(-1)*@month_minus,getdate()) , DATEADD(month,@month_plus,getdate()) )
      SET @rows_per_city = @rows_per_city + 1  
   END;  

GO  

--check status of largest table
SELECT * from devices 

--T-SQL script for creation of table with JSON column status_info
--this column will contain device_id,status_group, status_text, status_value, status_location, status_date
--this data will be historical, not only actual
--column device_id will project data from JSON structure inside status_info
CREATE TABLE [dbo].[status_extended_json] (
	[id] [int] IDENTITY(1,1) NOT NULL,
    [status_info] NVARCHAR(MAX) NULL CONSTRAINT status_info_IS_JSON CHECK ( ISJSON(status_info)>0 ),
	[device_id] AS JSON_VALUE(status_info, '$.device_id')
	)

--index on column projected from JSON structure
CREATE INDEX idx_JsonLocation ON status_extended_json(device_id)

--insert sample data
insert into [dbo].[status_extended_json](status_info) values(N'{"device_id":1,"status_group":"Error","status_text":"Undefined","status_value":0.00,"status_location":"Bratislava","status_date":"2016-09-01T00:00:00"}')
insert into [dbo].[status_extended_json](status_info) values(N'{"device_id":2,"status_group":"Warning","status_text":"Temperature","status_value":30.00,"status_location":"Prague","status_date":"2016-09-02T00:00:00"}')

--check data
select * from [dbo].[status_extended_json]

--DirectQuery to Azure SQLDB supports tables and views. To explore data structure hidden in JSON column for PowerBI Desktop tool, 
--we will create view, which will return JSON data in form of classic T-SQL columns
CREATE VIEW dbo.viewStatusData AS
SELECT	id,device_id, 'status_group'=JSON_VALUE(status_info, '$.status_group'), 'status_text'=JSON_VALUE(status_info, '$.status_text'), 'status_value'=convert(numeric(18,2),JSON_VALUE(status_info, '$.status_value')), 'status_location'=JSON_VALUE(status_info, '$.status_location'), 'status_date'=convert(datetime,JSON_VALUE(status_info, '$.status_date')) from [dbo].[status_extended_json]

GO


