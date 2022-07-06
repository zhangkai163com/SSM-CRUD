package com.zk.crud.service;


import com.zk.crud.bean.Department;
import com.zk.crud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmenService {

    @Autowired
    private DepartmentMapper departmentMapper;

    public List<Department> getDepts(){
        List<Department> departments = departmentMapper.selectByExample(null);
        return departments;

    }



}
