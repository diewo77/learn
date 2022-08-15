select * from tblcontacts

select fn, sn, town from tblcontacts

select fn, sn, town from tblcontacts 
order by region

select fn, sn, town from tblcontacts 
where region ='West Yorkshire'


select Region, count(contactid) as Contacts  from tblcontacts
group by Region
having count(contactid)>2
order by count(contactid) desc

select fn, sn, M.MaritalStatus from tblcontacts C
inner join tblMaritalStatus M
on C.maritalstatus=m.maritalstatusid

