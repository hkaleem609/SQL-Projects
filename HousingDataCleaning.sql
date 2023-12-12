use PortfolioProject;

select 
    count(*) 
from 
    [Nashville Housing Data for Data Cleaning];


select 
    *
from
    PortfolioProject.dbo.[Nashville Housing Data for Data Cleaning];

SELECT 
    *
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME = 'Nashville Housing Data for Data Cleaning'
        AND TABLE_SCHEMA = 'dbo';


select 
    SaleDate, CONVERT(date,saledate) 
from
    PortfolioProject.dbo.[Nashville Housing Data for Data Cleaning];


update 
    [Nashville Housing Data for Data Cleaning]
set 
    SaleDate = CONVERT(date,SaleDate);

select 
    *
from 
    PortfolioProject.dbo.[Nashville Housing Data for Data Cleaning]
WHERE
    PropertyAddress IS NULL
order by
    1,2


select 
    a.ParcelID,
	a.PropertyAddress,
	b.ParcelID,
	b.PropertyAddress, 
	ISNULL(a.PropertyAddress,b.PropertyAddress)
from
    PortfolioProject.dbo.[Nashville Housing Data for Data Cleaning] a
join
    PortfolioProject.dbo.[Nashville Housing Data for Data Cleaning] b
    on
	    a.ParcelID = b.ParcelID
	and
	    a.UniqueID <> b.UniqueID
where
    a.PropertyAddress is null;


update
    a
set 
    PropertyAddress =ISNULL(a.PropertyAddress,b.PropertyAddress)
from
    PortfolioProject.dbo.[Nashville Housing Data for Data Cleaning] a
join
    PortfolioProject.dbo.[Nashville Housing Data for Data Cleaning] b
    on
	    a.ParcelID = b.ParcelID
	and
	    a.UniqueID <> b.UniqueID
where
    a.PropertyAddress is null;


select 
    PropertyAddress
from 
    PortfolioProject.dbo.[Nashville Housing Data for Data Cleaning]

SELECT
    SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address,
	SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, len(PropertyAddress) ) as Address2
from 
    PortfolioProject.dbo.[Nashville Housing Data for Data Cleaning]
	    

alter table 
    PortfolioProject.dbo.[Nashville Housing Data for Data Cleaning]
add
    Property_Address Nvarchar(255);

update    
   PortfolioProject.dbo.[Nashville Housing Data for Data Cleaning]
set
   Property_Address = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


alter table
    PortfolioProject.dbo.[Nashville Housing Data for Data Cleaning]
add
    Property_CityName Nvarchar(255);


update    
   PortfolioProject.dbo.[Nashville Housing Data for Data Cleaning]
set
   Property_CityName = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, len(PropertyAddress));


select 
    Property_Address,
	Property_CityName
from
    PortfolioProject.dbo.[Nashville Housing Data for Data Cleaning];



select 
    *
from 
    PortfolioProject.dbo.[Nashville Housing Data for Data Cleaning]

select 
    OwnerAddress
from 
    PortfolioProject.dbo.[Nashville Housing Data for Data Cleaning]

select 
    PARSENAME(replace(OwnerAddress,',','.'),3),
	PARSENAME(replace(OwnerAddress,',','.'),2),
	PARSENAME(replace(OwnerAddress,',','.'),1)
from 
    PortfolioProject.dbo.[Nashville Housing Data for Data Cleaning]


alter table
    PortfolioProject.dbo.[Nashville Housing Data for Data Cleaning]
add
    Owner_address nvarchar(255)

update
    PortfolioProject.dbo.[Nashville Housing Data for Data Cleaning]
set
    Owner_address =  PARSENAME(replace(OwnerAddress,',','.'),3)


alter table
    PortfolioProject.dbo.[Nashville Housing Data for Data Cleaning]
add
    Owner_CityAddress nvarchar(255)

update
    PortfolioProject.dbo.[Nashville Housing Data for Data Cleaning]
set
    Owner_CityAddress =  PARSENAME(replace(OwnerAddress,',','.'),2)

select
   Owner_address,
   Owner_CityAddress
from
   PortfolioProject.dbo.[Nashville Housing Data for Data Cleaning]



select
    *
from
     PortfolioProject.dbo.[Nashville Housing Data for Data Cleaning]


select
    distinct(SoldAsVacant),
	COUNT(SoldAsVacant)
from
     PortfolioProject.dbo.[Nashville Housing Data for Data Cleaning]
group by
     SoldAsVacant
order by
     1,2


SELECT
    SoldAsVacant,
    CASE
        WHEN SoldAsVacant = 0 THEN CAST(0 AS bit)
        WHEN SoldAsVacant = 1 THEN CAST(1 AS bit)
        ELSE CAST(SoldAsVacant AS bit)
    END
FROM
    PortfolioProject.dbo.[Nashville Housing Data for Data Cleaning];

SELECT
    SoldAsVacant,
    CASE
        WHEN SoldAsVacant = 0 THEN 'NO'
        WHEN SoldAsVacant = 1 THEN 'YES'
        ELSE CAST(SoldAsVacant AS varchar)
    END AS SoldAsVacant
FROM
    PortfolioProject.dbo.[Nashville Housing Data for Data Cleaning];


update
    PortfolioProject.dbo.[Nashville Housing Data for Data Cleaning]
set SoldAsVacant=
    CASE
        WHEN SoldAsVacant = 0 THEN CAST(0 AS bit)
        WHEN SoldAsVacant = 1 THEN CAST(1 AS bit)
        ELSE CAST(SoldAsVacant AS bit)
    END

    
 alter table
    PortfolioProject.dbo.[Nashville Housing Data for Data Cleaning]
alter column
     SoldAsVacant VARCHAR(3);


UPDATE PortfolioProject.dbo.[Nashville Housing Data for Data Cleaning]
SET SoldAsVacant =
    CASE
        WHEN SoldAsVacant = 0 THEN 'NO'
        WHEN SoldAsVacant = 1 THEN 'YES'
        ELSE SoldAsVacant
    END;


WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From PortfolioProject.dbo.[Nashville Housing Data for Data Cleaning]

)
Select *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress


Select 
    *
From 
    PortfolioProject.dbo.[Nashville Housing Data for Data Cleaning];


ALTER TABLE 
    PortfolioProject.dbo.[Nashville Housing Data for Data Cleaning]
DROP COLUMN 
    OwnerAddress, TaxDistrict, PropertyAddress;

Select 
    *
From 
    PortfolioProject.dbo.[Nashville Housing Data for Data Cleaning];




  
    
    


