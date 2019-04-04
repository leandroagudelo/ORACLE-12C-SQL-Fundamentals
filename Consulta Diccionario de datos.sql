select col.owner as schema_name,
       col.table_name, 
       col.column_name, 
       col.data_type,
       col.data_length,  
       col.nullable,
       comm.comments,
       nvl(pk.primary_key,fk.foreign_key) as constraint_1,
       nvl(nvl(pk.constraint_name,fk.constraint_name),uk.constraint_name) as constraint_name
  from all_tables tab
       inner join all_tab_columns col 
           on col.owner = tab.owner 
          and col.table_name = tab.table_name          
       left join all_col_comments comm
           on col.owner = comm.owner
          and col.table_name = comm.table_name 
          and col.column_name = comm.column_name 
       left join (select constr.owner, 
                         col_const.table_name, 
                         col_const.column_name, 
                         'PK' primary_key,
                         constr.constraint_name 
                    from all_constraints constr 
                         inner join all_cons_columns col_const
                             on constr.constraint_name = col_const.constraint_name 
                            and col_const.owner = constr.owner
                   where constr.constraint_type = 'P') pk
           on col.table_name = pk.table_name 
          and col.column_name = pk.column_name
          and col.owner = pk.owner
       left join (select constr.owner, 
                         col_const.table_name, 
                         col_const.column_name, 
                         'FK' foreign_key,
                         constr.constraint_name
                    from all_constraints constr
                         inner join all_cons_columns col_const
                             on constr.constraint_name = col_const.constraint_name 
                            and col_const.owner = constr.owner 
                   where constr.constraint_type = 'R'
                   group by constr.owner, 
                            col_const.table_name, 
                            col_const.column_name,
                            constr.constraint_name) fk
           on col.table_name = fk.table_name 
          and col.column_name = fk.column_name
          and col.owner = fk.owner
       left join (select constr.owner, 
                         col_const.table_name, 
                         col_const.column_name, 
                         'UK' unique_key,
                         constr.constraint_name constraint_name
                    from all_constraints constr
                         inner join all_cons_columns col_const
                             on constr.constraint_name = col_const.constraint_name 
                            and constr.owner = col_const.owner
                   where constr.constraint_type = 'U' 
                   union
                  select ind.owner, 
                         col_ind.table_name, 
                         col_ind.column_name, 
                         'UK' unique_key,
                         col_ind.index_name  constraint_name
                    from all_indexes ind
                         inner join all_ind_columns col_ind 
                            on ind.index_name = col_ind.index_name                  
                   where ind.uniqueness = 'UNIQUE') uk
           on col.table_name = uk.table_name 
          and col.column_name = uk.column_name
          and col.owner = uk.owner
       left join (select constr.owner, 
                         col_const.table_name, 
                         col_const.column_name, 
                         'Check' check_constraint
                    from all_constraints constr 
                         inner join all_cons_columns col_const
                             on constr.constraint_name = col_const.constraint_name 
                            and col_const.owner = constr.owner
                   where constr.constraint_type = 'C'
                   group by constr.owner, 
                         col_const.table_name, 
                         col_const.column_name) check_const
           on col.table_name = check_const.table_name 
          and col.column_name = check_const.column_name      
          and col.owner = check_const.owner
 where col.owner  in ('LEO', 'CR','YEISON','ASH')
 and col.table_name ='BOOKS'
 --  and col.owner = 'HR' 
 --  and lower(tab.table_name) like '%'   
 order by col.owner,
       col.table_name, 
       col.column_name;
       
     