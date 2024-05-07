select * from professores
select * from alunos
select * from disciplinas
select * from cursos
select * from aproveitamentos

select AVG(apr_nota) Media 
from aproveitamentos

select AVG(apr_nota) Media
from aproveitamentos
where alu_rm = 1

select AVG(apr_nota) Media, COUNT(*) Qtd
from aproveitamentos
where alu_rm = 1

select AVG(apr_nota) Media, COUNT(*) Qtd,
	   MAX(apr_nota) Maior, min(apr_nota) Menor
from aproveitamentos
where alu_rm = 1

select alu_rm, AVG(apr_nota) Media, COUNT(*) Qtd,
	   MAX(apr_nota) Maior, min(apr_nota) Menor
from aproveitamentos
where alu_rm = 1 or alu_rm = 4
group by alu_rm 


select alu_rm, AVG(apr_nota) Media, COUNT(*) Qtd,
	   MAX(apr_nota) Maior, min(apr_nota) Menor
from aproveitamentos
group by alu_rm 



select alu_rm, AVG(apr_nota) Media, COUNT(*) Qtd,
	   MAX(apr_nota) Maior, min(apr_nota) Menor
from aproveitamentos
group by alu_rm 
having AVG(apr_nota) > 7


select alu_rm, AVG(apr_nota) Media, COUNT(*) Qtd,
	   MAX(apr_nota) Maior, min(apr_nota) Menor
from aproveitamentos
where apr_nota > 3
group by alu_rm 
having AVG(apr_nota) > 8.25

select alu_rm, convert(decimal(4,2), AVG(apr_nota)) Media, COUNT(*) Qtd,
	   MAX(apr_nota) Maior, min(apr_nota) Menor
from aproveitamentos
where apr_nota > 3
group by alu_rm 
having AVG(apr_nota) > 7

select alu_rm, convert(decimal(4,2), AVG(apr_nota)) Media, COUNT(*) Qtd,
	   MAX(apr_nota) Maior, min(apr_nota) Menor
from aproveitamentos
where apr_nota > 3
group by alu_rm 
having AVG(apr_nota) > 8 and count(*) > 7


select al.alu_rm, al.alu_nome Nome, convert(decimal(4,2), AVG(apr_nota)) Media, COUNT(*) Qtd,
	   MAX(apr_nota) Maior, min(apr_nota) Menor
from aproveitamentos ap, alunos al
where apr_nota > 3 and ap.alu_rm = al.alu_rm
group by al.alu_rm, al.alu_nome 
having AVG(apr_nota) > 8 and count(*) > 7


select al.alu_rm, al.alu_nome Nome, convert(decimal(4,2), AVG(apr_nota)) Media, COUNT(*) Qtd,
	   MAX(apr_nota) Maior, min(apr_nota) Menor
from aproveitamentos ap, alunos al
where apr_nota > 3 and ap.alu_rm = al.alu_rm
group by al.alu_rm, al.alu_nome 
having AVG(apr_nota) > 8 and count(*) > 7
order by Media desc


