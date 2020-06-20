--select count(*) from [dbo].[marvel_heroe_list_2] --6361
--select count(*) from [dbo].[marvel-wikia-data_2] --6461

--alter table [marvel_heroe_list_2] add marvel_name_clean varchar(255)

--update [dbo].[marvel_heroe_list_2] set marvel_name_clean = replace(replace(replace(marvel_name,'''',''),'(',''),')','')


--select marvel_name_clean, LEFT(marvel_name_clean, charindex(',', marvel_name_clean)-1) from [dbo].[marvel_heroe_list_2]

--update [marvel_heroe_list_2] set marvel_name_clean = LEFT(marvel_name_clean, charindex(',', marvel_name_clean)-1)

select* from [marvel_heroe_list_2]

select* from [dbo].[marvel-wikia-data_2] where name2 = 'Fury'
select* 
from [marvel_heroe_list_2] where marvel_name_clean = 'eson'

--with categrory as (
--select hero_network_name, name2 [name], id, ALIGN, sex, ALIVE, APPEARANCES, Year
--from [marvel_heroe_list_2] a inner join [dbo].[marvel-wikia-data_2] b 
--	on a.marvel_name_clean = b.name2
--),

--name_link as (
--select* from [dbo].[agg_marvel_names]
--)

--select categrory.*, name_link.name [name_link_agg], name_link.name_clean [name_link_agg_clean]
--into marvel_network_link_data
--from categrory inner join name_link on categrory.hero_network_name = name_link.name_clean

--network_data as (
--select* from [dbo].[hero-network]
--)

select top 5 * from marvel_network_link_data
select top 5 * from [dbo].[hero-network]

select * from [dbo].[hero-network] where hero1 = 'LITTLE, ABNER'

drop table final_marvel_data

With a as(
select hero1 [node], name [node_name], id [node_identity], align [node_align], sex [node_sex], alive [node_alive], year [node_year], appearances [node_appearances], hero2 [edge]
from marvel_network_link_data a inner join  [hero-network_2] b 
on a.name_link_agg = b.hero1
),

b as(
select hero1 [node_link], hero2 [edge_link], name [edge_name], id [edge_identity], align [edge_align], sex [edge_sex], alive [edge_alive], year [edge_year], appearances [edge_appearances]
from marvel_network_link_data a inner join  [hero-network_2] b 
on a.name_link_agg = b.hero2) 

select* 
into final_marvel_data
from a inner join b on a.node = b.node_link and a.edge = b.edge_link  


 bcp "select 'node', 'node_name', 'node_identity', 'node_align', 'node_sex', 'node_alive', 'node_year', 'node_appearances', 'edge', 'node_link', 'edge_link', 'edge_name', 'edge_identity', 'edge_align', 'edge_sex', 'edge_alive', 'edge_year', 'edge_appearances' union all select * from [SQL_TRAINING].[dbo].[final_marvel_data]" queryout final_mavel_network_data.csv /CULDRMSARCSQ01 /c /t, -T



 select node_name, node_sex, edge_name, edge_sex 
 from final_marvel_data
 where node_name is not null
 and node_sex is not null
 and edge_name is not null
 and edge_sex is not null