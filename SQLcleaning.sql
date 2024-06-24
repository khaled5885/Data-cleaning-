select*from project..Sheet1$


select SaleDate,CONVERT(date,SaleDate) from project..Sheet1$
update Sheet1$
set SaleDate = CONVERT(date,SaleDate)


alter table Sheet1$
add saledateconverted date;


update Sheet1$
set saledateconverted = convert(date,SaleDate)
select saledateconverted from project..Sheet1$


select * from project..Sheet1$
--where PropertyAddress is null
order by ParcelID


select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress,ISNULL(a.PropertyAddress,b.PropertyAddress)
from project..Sheet1$ a
join project..Sheet1$ b
on a.ParcelID=b.ParcelID
and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null


update a
set PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)--(a.PropertyAddress,'no addres')
from project..Sheet1$ a
join project..Sheet1$ b
on a.ParcelID=b.ParcelID
and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null


select PropertyAddress from project..Sheet1$

select
SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) as address,
SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,len(PropertyAddress)) as address
--CHARINDEX(',',PropertyAddress)
from project..Sheet1$


alter table Sheet1$
add Address nvarchar(255);
update Sheet1$
set Address = SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1)

alter table Sheet1$
add city nvarchar(255);
update Sheet1$
set city = SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,len(PropertyAddress))
select*from project..Sheet1$


select OwnerAddress from project..Sheet1$
select
PARSENAME(REPLACE(OwnerAddress,',','.'),3),
PARSENAME(REPLACE(OwnerAddress,',','.'),2),
PARSENAME(REPLACE(OwnerAddress,',','.'),1)
from project..Sheet1$

alter table Sheet1$
add ownersplitaddress nvarchar(255);
update Sheet1$
set ownersplitaddress = PARSENAME(REPLACE(OwnerAddress,',','.'),3)

alter table Sheet1$
add ownercity nvarchar(255);
update Sheet1$
set ownercity = PARSENAME(REPLACE(OwnerAddress,',','.'),2)

alter table Sheet1$
add ownerstate nvarchar(255);
update Sheet1$
set ownerstate = PARSENAME(REPLACE(OwnerAddress,',','.'),1)
select* from project..Sheet1$


select distinct(SoldAsVacant),count(SoldAsVacant)
from project..Sheet1$
group by SoldAsVacant
order by 2
select SoldAsVacant,
case when SoldAsVacant='Y'then'Yes'
when SoldAsVacant='N'then'No'
else SoldAsVacant
end
from project..Sheet1$
update Sheet1$
set SoldAsVacant=
case when SoldAsVacant='Y'then'Yes'
when SoldAsVacant='N'then'No'
else SoldAsVacant
end
select distinct(SoldAsVacant),count(SoldAsVacant)
from project..Sheet1$
group by SoldAsVacant
order by 2


with rownumcte as(
select*,
ROW_NUMBER()over(
partition by parcelid,
propertyaddress,
saleprice,
saledate,
legalreference
order by
uniqueid
)row_num
from project..Sheet1$
--order by ParcelID
)
select*
from rownumcte
where row_num>1
order by PropertyAddress

with rownumcte as(
select*,
ROW_NUMBER()over(
partition by parcelid,
propertyaddress,
saleprice,
saledate,
legalreference
order by
uniqueid
)row_num
from project..Sheet1$
--order by ParcelID
)
delete
from rownumcte
where row_num>1
--order by PropertyAddress


select*
from project..Sheet1$
alter table project..Sheet1$
drop column owneraddress,taxdistrict,propertyaddress
alter table project..Sheet1$
drop column saledate